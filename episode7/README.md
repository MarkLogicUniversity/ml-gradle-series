# ML-GRADLE Security 
## Episode 7 - Protecting Passwords

We continue our existing Gradle build to explore an approach to protecting passwords used in **ml-gradle** deployments. In this episode, we will use the **Credentials** Gradle plugin to store encrypted password values on the local computer. We will, then, retrieve the values to use when deploying our application code, configurations and content.

Generally, it's not a good practice to store usernames and passwords in clear text. It's also not a good practice to store these values in source code control. Separation of password values from the source code that uses them is always desired behavior. 

With Gradle builds, there are different approaches to separating password values from sources that use them. The values can be passed on the command-line when calling Gradle to begin a build. You could encrypt the password values. You could type them into environment variables. You could store them in a `gradle.properties` file that is never committed to source control but created or customized for your build. Depending on your build and deployment technologies, there may be other approaches.

In our previous episodes, we have stored **ml-gradle** usernames and passwords in our `gradle.properties` file. This file contains properties and values used during our **ml-gradle** build. Additionally, our `gradle.properties` file defines MarkLogic user and password properties and values to contact MarkLogic, ultimately calling the MarkLogic REST api with credentials that have sufficent permissions to do the task. As a good practice, these user and password values should not be checked into source control. Instead, they should be added to `gradle.properties` before running the build.

In this episode, we will utilize the **Credentials** plugin to store our passwords in encrypted form on our local computer. The **ml-gradle** build will, then, read these values using the plugin's `credentials` object. The passwords would never be stored in clear text. Once the passwords are encrypted on the computer that will run the builds, the script that is run to encrypt should be deleted.

### The Credentials Plugin

The **Credentials** plugin provides a convenient method of encrypting password and other values at rest. You call the  **Credentials** plugin and add key/value pairs to be stored. The value is encrypted. When using the `credentials` object, you can retrieve the values during your builds. The **Credentials** plugin GitHub repository has additional information about how the plugin functions and also the encryption design. See <https://github.com/etiennestuder/gradle-credentials-plugin>.

### ml-gradle and Authentication

**ml-gradle** calls MarkLogic's REST api to implement configuration and deployment functionality. The REST api calls require authentication using MarkLogic user accounts with sufficient roles and privileges.

Properties are used to conveniently implement authentication with site-specific defined usernames. Below are a list of the properties used in **ml-gradle**.  

*  `mlUsername`/`mlPassword` - Default user for any REST api call unless overridden by the other user account properties below. This does not have to be a user with the `admin` role. However, secure REST api calls would require `security` and `manage-admin` roles so the `mlUsername` account should inherit both of these roles.
*  `mlRestAdminUsername`/`mlRestAdminPassword` - User for loading modules. Non-REST modules use port 8000. REST modules use the port defined by the `mlRestPort` **ml-gradle** property.
*  `mlManageUsername`/`mlManagePassword` - For ml-gradle, version 3.4.0+, the user for REST api calls to the **Manage** server on port 8002. User must have the `manage-admin` role.
* `mlSecurityUsername`/`mlSecurityPassword` - User for REST api calls to **Security** endpoints on port 8002 that require a user with both the `manage-admin` and `security` roles.
* `mlAdminUsername`/`mlAdminPassword` - Prior to ml-gradle version 3.4.0, the user for talking to the Admin server on port 8001 and for the Security endpoints that require a user with both the `manage-admin` and `security` roles, which is often an admin user.

## Requirements

To successfully do the hands-on portions for this episode, make sure you have the following installed.

* Ensure you have a 64-bit Operating System. *Important: MarkLogic Server runs only on 64-bit operating systems.*
* MarkLogic Server, Version 9.0-3 or greater installed and started. <http://developer.marklogic.com/products>
* Java, Version 1.8 or greater. <https://java.com/en/download/>
* Gradle, Version 3.5 or greater. <https://gradle.org/install/>
* An internet connection to pull dependencies from Gradle repositories.

## Episode 7 Hands-On Instructions

Encrypting Passwords with ml-gradle utilizes the same project as episode 6. The changes are the password values for the username properties in the `gradle.properties` file have been set to a default text value of `none`.

To follow along with episode 7, do the following.

### `password-encryption` instructions.  

1. Copy the folder called `starwarsproject` in the `password-encryption` folder to the same level as the `episode7` folder. Replace any existing `starwarsproject` folder.  

2. The `episode7` folder should now have the following folders:  
	* `password-encryption`
	* `starwarsproject` <-- created when you copied the folder from the `part3-element-level-security` folder in **Step 1**.	
3. In a command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to the `starwarsproject` folder.
	* Type `cd <path to the episode7 files>/episode7/starwarsproject` then press ENTER.

4. Note the changes in the `build.gradle` and `gradle.properties` files.
	* `build.gradle` - adds the `credentials` plugin by including  `id "nu.studer.credentials" version "1.0.4"` in the `plugins {...)` block. In the `ext {...}` block, the `credentials` object retrieves the encrypted passwords, decrypts them then sets the password properties for the various **ml-gradle** users as we discussed above in **ml-gradle Users**. The connections to MarkLogic are re-initialized with the updated credentials via the `mlManageClient` and `mlAdminManager` objects.
	* `gradle.properties` - contains the properties for the **ml-gradle** users we will be using. No password values are stored.

5. Encrypt desired passwords. 
> The included script calls the `credentials` Gradle plugin to encrypt the password values for the MarkLogic user account we'll be using for our `ml-gradle` REST api calls to MarkLogic. The `pwd-encrypt` script has both Unix/Mac and Windows versions. The argument of `set` encrypts the password values and stores them locally. There is no need to re-run the script once it has initially been run unless the password values have changed or the encrypted values have been removed. You can remove the encrypted values by passing the argument of `remove` to the `pwd-encrypt` script.
	* Open the `pwd-encrypt.sh` file or the `pwd-encrypt.bat` file in a text editor, depending if you are on Unix/Mac or a Windows computer.
	* Change the `changeme` text in each of the 5 lines that contain `gradle addCredentials --key ... --value changeme` where "..." is a string key to associate with the encrypted password value.
		* NOTE: Please do not change the 6th line. This contains the password value for our `starwars-admin` user that we will deploy with **ml-gradle**.	 
	* Save the file and exit from your text editor.  
	* On Unix or Mac computers, type `./pwd-encrypt.sh set` then press ENTER.
	* On Windows computers, type `pwd-encrypt.bat set` then press ENTER.

6. Run the **ml-gradle** `mlDeploy` task.
	* Type `gradle mlDeploy` then press ENTER.

7. Run the `deployContent` custom task.
	* Type `gradle deployContent` then press ENTER.

8. In a web browser, go to <http://localhost:9010/login.xqy> to see the project web page. Edit the port number (:9010) if your value of `mlRestPort` in the `gradle.properties` file is different.

9. Log into the deploy Web application.
	* Enter `leia` as the username and `leia` as the password.
	* Click the **Login** button.
	* The Web application displays a table of Star Wars character information. The chart of Star Wars character heights is below the table.

10. When finished, log out of the application.
	* Click the **Logout** button at the top of the Web page.
	* At the "Click here to login again" prompt, click the **login** link.

11. Undeploy the application and content
	* In a command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to the `starwarsproject` folder.
	* Type `cd <path to the episode7 files>/episode7/starwarsproject` then press ENTER.
	* Type `gradle mlUndeploy -Pconfirm=true` then press ENTER.

12. Remove the encrypted password values.
	* On Unix or Mac computers, type `./pwd-encrypt.sh remove` then press ENTER.
	* On Windows computers, type `pwd-encrypt.bat set` then press ENTER.

## Next Steps
When you have completed the `password-encryption` exercise, you have finished with the Episode 7 hands-on exercise.

We hope you have enjoyed this episode.