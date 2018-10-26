#!/bin/bash

# Save the first argument as the first MarkLogic host in the cluster
first_node="$1"

# Initialize all MarkLogic hosts
for arg in "$@"; do
  gradle -PmlHost="$arg" mlInit
done

# Only need to create the admin user on the
#  first MarkLogic host
gradle -PmlHost="$first_node" mlInstallAdmin

# add the remaining hosts to the first node's cluster
# skip the first argument which is the first ML host initialized.
shift

# process the remaining ML hosts adding them to the first ML host cluster.
for arg in "$@"; do
  gradle -PmlHost="$first_node" -Phost="$arg" mlAddHost
done

# Deploy the example project and load the content
gradle -PmlHost="$first_node" mlDeploy

gradle -PmlHost="$first_node" deployContent

echo -e "\nDone MarkLogic cluster deployment."
