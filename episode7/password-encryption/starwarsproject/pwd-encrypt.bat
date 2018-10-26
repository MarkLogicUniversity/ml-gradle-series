@echo off

REM Encrypted credentials are store in GRADLE_USER_HOME/gradle.encrypted.properties.

echo "This script sets or removes encrypted credentials."
echo "These credentials are used by the MarkLogic University ml-gradle series episode 7 example."
if /i "%1%" == "set" goto setCredentials
if /i "%1%" == "remove" goto removeCredentials
echo ""
echo "Usage:"
echo "set-password.bat set      to encrypt the example passwords"
echo "set-password.bat remove   to delete the example passwords"
goto commonexit

:setCredentials
gradle addCredentials --key managePassword --value changeme
gradle addCredentials --key securityPassword --value changeme
gradle addCredentials --key adminPassword --value changeme
gradle addCredentials --key restPassword --value changeme
gradle addCredentials --key appServicesPassword --value changeme

REM please do not change. the password is already set for the
REM starwars-admin user in the configuration we will deploy.
gradle addCredentials --key mlcpPassword --value starwars-admin

echo "Finished encypting credentials."
goto commonexit

:removeCredentials
gradle removeCredentials --key managePassword
gradle removeCredentials --key securityPassword
gradle removeCredentials --key adminPassword
gradle removeCredentials --key restPassword
gradle removeCredentials --key appServicesPassword
gradle removeCredentials --key mlcpPassword

echo "Finished removing credentials."
goto commonexit

:commonexit
pause
