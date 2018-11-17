
# ML-GRADLE Securing Content with ml-gradle, Hands-On Exercises 

## Episode 6 - Element-Level Security

Episode 6 is part of the [**ml-gradle** series] (http://mlu.marklogic.com/ondemand/index.xqy?q=Series%3A%22ml-gradle%22). Visit [MarkLogic University On Demand] (http://mlu.marklogic.com/ondemand) for a variety of video topics.

This episode investigates extending configurations created in **Episode 5**. We will extend our configurations to add log in and log out functions to the application code for our Star Wars web page project. The deployment utilizes MarkLogic security, roles and permissions.

## Requirements

To successfully do the hands-on portions for this episode, make sure you have the following installed.

* Ensure you have a 64-bit Operating System. *Important: MarkLogic Server runs only on 64-bit operating systems.*
* MarkLogic Server, Version 9.0-3 or greater installed and started. <http://developer.marklogic.com/products>
* Java, Version 1.8 or greater. <https://java.com/en/download/>
* Gradle, Version 3.5 or greater. <https://gradle.org/install/>
* An internet connection to pull dependencies from Gradle repositories.

## Episode 6 Hands-On Instructions

Deploying Security with ml-gradle is divided into multiple folders. These folder represent the final results of each episode. We will be running Gradle tasks on the command prompt (Windows) or in Terminal (CentOS/RedHat or MacOS).

To follow along with episode 6, do the following.

### `part3-element-level-security` instructions.  

1. Copy the folder called `starwarsproject` in the `part3-element-level-security` folder to the same level as the `episode6` folder. Replace any existing `starwarsproject` folder.  

2. The `episode6` folder should now have the following folders:  
	* `part3-element-level-security`
	* `starwarsproject` <-- created when you copied the folder from the `part3-element-level-security` folder in **Step 1**.	
3. In a command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to the `starwarsproject` folder.
	* Type `cd <path to the episode6 files>/episode6/starwarsproject` then press ENTER.

4. Note the inclusion of our project application code in the `src/main/ml-modules/root` and `src/main/ml-modules/services` directories.
	* `root` - contains our web page code and javascript needed to display Google Charts in the browser. We have added new XQuery scripts to log into our application and log out of our application. This enables us to easily test our roles and permissions in this episode.
	* `services` - contains our MarkLogic Server-side JavaScript code to extend MarkLogic's REST api to query our content database for Star Wars character names and heights. The data will be returned to the browser in JSON format.

5. Run the **ml-gradle** `mlDeploy` task.
	* Type `gradle mlDeploy` then press ENTER.

6. Run the `deployContent` custom task.
	* Type `gradle deployContent` then press ENTER.

7. In a web browser, go to <http://localhost:9010/login.xqy> to see the project web page. Edit the port number (:9010) if your value of `mlRestPort` in the `gradle.properties` file is different.

8. Log into the deploy Web application.
	* Enter `leia` as the username and `leia` as the password.
	* Click the **Login** button.
	* The Web application displays a table of Star Wars character information. The chart of Star Wars character heights is below the table.

9. When finished, log out of the application.
	* Click the **Logout** button at the top of the Web page.
	* At the "Click here to login again" prompt, click the **login** link.

10. Undeploy the application and content
	* In a command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to the `starwarsproject` folder.
	* Type `cd <path to the episode6 files>/episode6/starwarsproject` then press ENTER.
	* Type `gradle mlUndeploy -Pconfirm=true` then press ENTER.

## Next Steps
When you have completed the `part3-element-level-security` exercise, you have finished with the Episode 6 hands-on exercise.

We hope you have enjoyed this episode.