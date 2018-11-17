
# ML-GRADLE Securing Content with ml-gradle, Hands-On Exercises 

## Episode 5 - Security by Roles

Episode 5 is part of the [**ml-gradle** series] (http://mlu.marklogic.com/ondemand/index.xqy?q=Series%3A%22ml-gradle%22). Visit [MarkLogic University On Demand] (http://mlu.marklogic.com/ondemand) for a variety of video topics.

This episode investigates extending configurations created in **Episode 4**. We will extend our configurations to add log in and log out functions to the application code for our Star Wars web page project. The deployment utilizes MarkLogic security, roles and permissions.

## Requirements

To successfully do the hands-on portions for this episode, make sure you have the following installed.

* Ensure you have a 64-bit Operating System. *Important: MarkLogic Server runs only on 64-bit operating systems.*
* MarkLogic Server, Version 9.0-3 or greater installed and started. <http://developer.marklogic.com/products>
* Java, Version 1.8 or greater. <https://java.com/en/download/>
* Gradle, Version 3.5 or greater. <https://gradle.org/install/>
* An internet connection to pull dependencies from Gradle repositories.

## Episode 5 Hands-On Instructions

Deploying Security with ml-gradle is divided into multiple folders. These folder represent the final results of each episode. We will be running Gradle tasks on the command prompt (Windows) or in Terminal (CentOS/RedHat or MacOS).

To follow along with episode 5, do the following.

### `part2-permissions` instructions.  

1. Copy the folder called `starwarsproject` in the `part2-permissions` folder to the same level as the `episode5` folder. Replace any existing `starwarsproject` folder.  

2. The `episode5` folder should now have the following folders:  
	* `part2-permissions`
	* `starwarsproject` <-- created when you copied the folder from the `part2-permissions` folder in **Step 1**.

3. In a command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to the `starwarsproject` folder.
	* Type `cd <path to the episode5 files>/episode5/starwarsproject` then press ENTER.

4. Note the inclusion of our MarkLogic Content Pump transformation script, `setPermissions.sjs` in the `src/main/ml-modules/root/transforms` directory.
	* The `deployContent` task in the build.gradle file will call the deployed `setPermissions.sjs` transformation script. Each document will be processed as it is loaded to set the permission on the document according to the "alliance" JSON property value in the content.

5. Run the **ml-gradle** `mlDeploy` task.
	* Type `gradle mlDeploy` then press ENTER.

6. Run the `deployContent` custom task.
	* Type `gradle deployContent` then press ENTER.

7. In a web browser, go to <http://localhost:9010/login.xqy> to see the project web page. Edit the port number (:9010) if your value of `mlRestPort` in the `gradle.properties` file is different.

8. Log into the Web application.
	* Enter `lorth` as the username and `lorth` as the password.
	* Click the **Login** button.
	* The Web application displays a table of Star Wars character information. The chart of Star Wars character heights is below the table.
	* Note that the content displayed is only Empire-related content since Lorth Needa does not need to see Rebel-related content.

9. Log out of the application.
	* Click the **Logout** button at the top of the Web page.
	* At the "Click here to login again" prompt, click the **login** link.

10. Log into the Web application again.
	* Enter `luke` as the username and `luke` as the password.
	* Click the **Login** button.
	* Note that the content displayed is only Rebel-related content since Luke Skywalker does not need to see Empire-related content.

11. Log out of the application.
	* Click the **Logout** button at the top of the Web page.
	* At the "Click here to login again" prompt, click the **login** link.

12. Log into the Web application.
	* Enter either `darth` as the username and `darth` as the password or `leia` as the username and `leia` as the password.
	* Click the **Login** button.
	* Note that the content displayed is both Rebel and Empire-related content. As leaders of their alliances, both Darth Vader and Leia Organa need access to more information.

13. Log out of the application.
	* Click the **Logout** button at the top of the Web page.
	* At the "Click here to login again" prompt, click the **login** link.

10. Undeploy the application and content
	* In a command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to the `starwarsproject` folder.
	* Type `cd <path to the episode5 files>/episode5/starwarsproject` then press ENTER.
	* Type `gradle mlUndeploy -Pconfirm=true` then press ENTER.

## Next Steps

When you have completed the `part2-permissions` exercise, you have finished with the Episode 5 hands-on exercise.

We hope you have enjoyed this episode.