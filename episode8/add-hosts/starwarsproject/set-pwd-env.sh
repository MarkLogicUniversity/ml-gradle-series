#!/bin/bash

# Save passwords in environment variables
# ---------- WARNING --------------------
# You would NOT check this script into source control
# or save in a directory you do not have direct control
# over.
echo "Setting environment variables to credential values."

export ADMINPWD="changeme"
export MANAGEPWD="changeme"
export SECUREPWD="changeme"
export RESTPWD="changeme"

# please do not change. this is the password for
# the "starwars-admin" user that we will deploy.
export MLCPPWD="starwars-admin"

echo "Environment variables set."
