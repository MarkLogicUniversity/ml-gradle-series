#!/bin/bash

# Encrypted credentials are store in GRADLE_USER_HOME/gradle.encrypted.properties.
echo "This script sets or removes encrypted credentials."
echo "These credentials are used by the MarkLogic University ml-gradle series episode 7 example."
if [ "$1" = "set" ];
then
  gradle addCredentials --key managePassword --value changeme
  gradle addCredentials --key securityPassword --value changeme
  gradle addCredentials --key adminPassword --value changeme
  gradle addCredentials --key restPassword --value changeme
  gradle addCredentials --key appServicesPassword --value changeme

  # please do not change. the password is already set for the
  # starwars-admin user in the configuration we will deploy.
  gradle addCredentials --key mlcpPassword --value starwars-admin

  echo "Finished encypting credentials."
elif [ "$1" = "remove" ];
then
  gradle removeCredentials --key managePassword
  gradle removeCredentials --key securityPassword
  gradle removeCredentials --key adminPassword
  gradle removeCredentials --key restPassword
  gradle removeCredentials --key appServicesPassword
  gradle removeCredentials --key mlcpPassword

  echo "Finished removing credentials."
else
  echo ""
  echo "Usage:"
  echo "set-password.sh set      to encrypt the example passwords"
  echo "set-password.sh remove   to delete the example passwords"
fi
