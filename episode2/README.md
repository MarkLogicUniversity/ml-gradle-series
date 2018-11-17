# ML-GRADLE Hands-On Exercises 
## Episode 2 - Scaffolding New Projects with ml-gradle

Episode 2 is part of the [**ml-gradle** series] (http://mlu.marklogic.com/ondemand/index.xqy?q=Series%3A%22ml-gradle%22). Visit [MarkLogic University On Demand] (http://mlu.marklogic.com/ondemand) for a variety of video topics.

This episode investigates creating initial project configuration files to deploy to a MarkLogic server. 

## Requirements

To successfully do the hands-on portions for this episode, make sure you have the following installed.

* Ensure you have a 64-bit Operating System. *Important: MarkLogic Server runs only on 64-bit operating systems.*
* MarkLogic Server, Version 9.0-3 or greater installed and started. <http://developer.marklogic.com/products>
* Java, Version 1.8 or greater. <https://java.com/en/download/>
* Gradle, Version 3.5 or greater. <https://gradle.org/install/>
* An internet connection to pull dependencies from Gradle repositories.

## Episode 2 Hands-On Instructions

This episode is divided into 3 different folders. These folder represent the final results of each part. We will be running Gradle tasks on the command prompt (Windows) or in Terminal (CentOS/RedHat or MacOS).

To follow along, do the following.

### `part1-initial` instructions.  

1. Copy the folder called `starwarsproject` in the `part1-initial` folder to the same level as the `episode2` folder.  

2. The `episode2` folder should now have the following folders:  
	* `part1-initial`
	* `part2-scaffold`
	* `part3-customized`
	* `starwarsproject` <-- created when you copied the folder from the `part1-initial` folder in **Step 1**.	
3. Examine the contents of the `starwarsproject` folder and verify there is a `build.gradle` file. Look at the file in a text editor, if you'd like. The contents of the `build.gradle` file pulls in the `ml-gradle` Gradle plug-in.  

4. In command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to your new `starwarsproject` folder.
	* Type `cd <path to the episode2 files >/episode2/starwarsproject` then press ENTER.

5. Run the **ml-gradle** `mlDeploy` task.
	* Type `gradle mlDeploy` then press ENTER.
	* Since there is no `gradle.properties` file nor configuration directory structure, `ml-gradle` deploys a default REST application server, content database and module database.

6. Examine your deployed configurations.
	* Visit the Admin Interface in your browser to verify the changes that were deployed. <http://localhost:8001>
	* Note a default REST application server called `my-app` was created.
	* Note 2 databases, `my-app-content` and `my-app-modules`, were created.
	* Note forests for the above databases were also created.

7. Undeploy the configuraitons.  
	* Type `gradle mlUndeploy -Pconfirm=true` then press ENTER.
	* Your deployed configurations have been removed from your MarkLogic Server. 
	* You can go to the Admin Interface in your browser to verify, <http://localhost:8001>. If your browser is already open, refresh the page to re-read the current configuration information from your local MarkLogic server.

6. The **ml-gradle** dependencies are downloaded and you can proceed to the **part2-scaffold**. 

### `part2-scaffold` instructions

1. In command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), be sure you are in the `episode2/starwarsproject` folder.

2. Run the **ml-gradle** `mlNewProject` task.
	* Type `gradle mlNewProject` then press ENTER.
	* For the application name, type `starwars` then press ENTER.
	* Press ENTER to accept `localhost` as the MarkLogic server to deploy.
	* Enter your MarkLogic Administrator username.
	* Enter the password for your MarkLogic Administrator.
	* Enter `8090` as the REST api port number then press ENTER. 
	* Leave the Test REST api port number blank and just press ENTER.
	* Press ENTER to accept the default value of **Y** to create MarkLogic database configurations.
	* Press ENTER to accept the default value of **Y** to create MarkLogic Security Role and User configurations.

3. Edit the `gradle.properties` file. Change the name of the application server that will be created and also add the name of our content and modules databases that will be created.

	* Open the `gradle.properties` file in your `starwarsproject` folder in a text editor.
	* Change the `mlAppName` property value from `starwars` to `starwars-gradle`.
	* At the bottom of the `gradle.properties` file, insert a blank line.
	* In the blank line, type `mlContentDatabaseName=starwars-content`
	* Insert another blank line at the bottom of your `gradle.properties` file.
	* In the new blank line, type `mlModulesDatabaseName=starwars-modules`
	* Save your changes and exit your text editor.  

4. Run the **ml-gradle** `mlDeploy` task.
	* Type `gradle mlDeploy` then press ENTER.

5. Examine your deployed configurations.
	* Visit the Admin Interface in your browser to verify the changes that were deployed. <http://localhost:8001>

6. Undeploy the configuraitons.  
	* Type `gradle mlUndeploy -Pconfirm=true` then press ENTER.
	* Your deployed configurations have been removed from your MarkLogic Server. You can go to the Admin Interface in your browser to verify. <http://localhost:8001>

### `part3-customized` instructions

1. In command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), be sure you are in the `episode2/starwarsproject` folder.

2. Copy the `episodes2/part3-customized/starwarsproject` folder to your `episode2` folder. Replace your existing `starwarsproject` folder.

3. If you entered a port number other than **8090** during the **Episode 2** `mlNewProject` task, be sure to edit the `mlRestPort` value in the `gradle.properties` file and change the value.

4. View the included MarkLogic element-range index configurations.
	* View the `content-database.json` file in the `src/main/ml-config/databases` directory in a text editor of your choice.
	* Note the element-range index configuration that will be deployed.

5. Run the **ml-gradle** `mlDeploy` task.
	* Type `gradle mlDeploy` then press ENTER.

6. Examine your deployed configurations.
	* Visit the Admin Interface in your browser to verify the changes that were deployed. <http://localhost:8001>

7. Undeploy the configuraitons.  
	* Type `gradle mlUndeploy -Pconfirm=true` then press ENTER.
	* Your deployed configurations have been removed from your MarkLgoic Server. You can go to the Admin Interface in your browser to verify. <http://localhost:8001>

## Next Steps
Once the `part3-customized` configuration has been undeployed, proceed to **Episode 3 - Customizing Deployments with ml-gradle** video. The hands-on exercises will be in the `episode3` folder of this same `ml-gradle-series` GitHub repository you downloaded.

We hope you have enjoyed this episode.