@echo off

REM # Save passwords in environment variables
REM # ---------- WARNING --------------------
REM # You would NOT check this script into source control
REM # or save in a directory you do not have direct control
REM # over.
echo "Setting environment variables to credential values."

SET ADMINPWD=changeme
SET MANAGEPWD=changeme
SET SECUREPWD=changeme
SET RESTPWD=changeme

REM please do not change. this is the password for
REM the "starwars-admin" user that we will deploy.
SET MLCPPWD=starwars-admin

echo "Environment variables set."
pause
