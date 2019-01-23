
# ML-GRADLE Clusters 

## Episode 8 - Adding MarkLogic Hosts to Clusters

Episode 8 is part of the [**ml-gradle** series](http://mlu.marklogic.com/ondemand/index.xqy?q=Series%3A%22ml-gradle%22). Visit [MarkLogic University On Demand](http://mlu.marklogic.com/ondemand) for a variety of video topics.

This episode investigates deploying MarkLogic hosts and adding them to an existing cluster. We will explore enhancing our existing Gradle build from **episode 7** to create multiple Docker containers, each being a MarkLogic server. Then, we will use **ml-gradle** to add these multiple MarkLogic hosts to a cluster. Finally, we will deploy our example application.

### MarkLogic Clusters

We are using Docker to simulate a multiple MarkLogic server scenario on one host computer. One could use VirtualBox, VMWare or other virtual technology to achieve the same outcome. Docker doesn't virtualize hardware nor operating system components except that which is required to run an application. Docker *containers* (instantiations of Docker *images*) are lightweight, faster to create and an excellent choice for creating microservices. See <https://www.docker.com/> for more information on Docker. Visit <https://developer.marklogic.com/blog> then select **DOCKER** under **Categories** for more information on MarkLogic and Docker.

For our example **Star Wars** application, we decided on a cluster architecture consisting of 1 MarkLogic Evaluator Node (E-Node) and 2 MarkLogic Data Nodes (D-Nodes). We could have choosen combination E/D-Nodes where the data is stored on the same MarkLogic hosts as the MarkLogic application servers. For instructional purposes, the separation of the E-Node from the D-Nodes permits a cleaner explanation. Your architectural needs may differ.

The E-Node is a MarkLogic server with our example application's HTTP *Application Server* (responds to requests to a database) to evaluate our requests to the **starwars-content** *Database* (transaction controller and response aggregator). The D-Nodes will have the *Forests* (content storage) for the database.

                     E-Node
                (starwars app server)
                /                   \
               /                     \
			D-Node	                 D-Node
		(starwars-content        (starwars-content
		 forest)                  forest)


We have updated the deployment configurations for our example application to reflect our cluster architecture. Our application server still responds to requests on port 9010. However, the application server will be created on a specifically named MarkLogic host instead of **localhost**, as in our previous single MarkLogic host deployments. Our database deployment now includes two forest configurations, creating a forest on each of the two additional MarkLogic hosts. 

MarkLogic scales horizontally. If more requests than expected come in, we can add a new **E-Node** and add a load balancer between the E-Nodes. If we require more storage, we can easily add another **Forest** to our existing MarkLogic server hosts or add another **D-Node**. We have an architecture that can quickly respond to changing needs.

### Docker and MarkLogic

Our Docker container has one MarkLogic server already installed and running. The MarkLogic containers are instantiated from a previously created MarkLogic Docker *image* (a master image from which to create containers). Three containers will be created for our architecture.

Docker networking hides Docker containers from the host computer's networking. Containers are isolated but specific ports can be exposed to the host. Naturally, exposed ports cannot conflict. If we already use port 8001 by running MarkLogic on the computer that also hosts Docker, we cannot expose a port 8001 in a container also running MarkLogic. The ports would conflict. We would need to expose the container on a new port and Docker has methods that let exposed ports be mapped to different container ports. All the MarkLogic containers in the Docker network will be able to communicate with each other without exposing their ports to the host computer.

> For our educational purposes, we are only exposing port 8001 (MarkLogic's Admin Interface), port 8000 (MarkLogic's Query Console) and port 9010 (our example Star Wars application server). Ensure those ports are available on your computer.

An additional container runs Gradle. Since Docker networking creates a separate network on top of our host computer's networking, we'd have to expose additional ports for **ml-gradle** to call MarkLogic's REST api and deploy our configurations. Creating another container for Gradle, puts the Gradle container in the same Docker network thus removing the need to expose ports to our host computer needlessly. Almost all of the networking needs for our cluster is neatly within our Docker network.

> To ease our deployment, in the `docker-compose` build script, we have mapped a directory in the Gradle container's storage to the host computer's directory containing this episode's `starwarsproject`. Therefore, we don't need to copy any files into the Docker container running Gradle. It will look in our `starwarsproject` folder for our configurations, content and Gradle build scripts. `docker-compose` orchestrates the creation of our MarkLogic containers, Gradle container and the Docker network that enables them to communicate with each other.

## Requirements

To successfully do the hands-on portions for this episode, make sure you have the following installed.

* Ensure you have a 64-bit Operating System. *Important: MarkLogic Server runs only on 64-bit operating systems.*
* The CentOS/Red Hat Enterprise MarkLogic .rpm installer downloaded, Version 9.0-5 or greater. <http://developer.marklogic.com/products>
* Docker, version 8.03-ce or higher, installed and working. <https://www.docker.com/get-started>
* Java, Version 1.8 or greater. <https://java.com/en/download/>
* Gradle, Version 3.5 or greater. <https://gradle.org/install/>

	> Note: Currently, **ml-gradle** supports Gradle versions up to 4.10.x. Gradle versions 5 and higher are currently unsupported. You can have multiple versions of Gradle on your computer. Just make sure the 4.x version is called for **ml-gradle** tasks.

* An internet connection to pull dependencies from Gradle repositories.

## Episode 8 Hands-On Instructions

Deploying Security with ml-gradle is divided into multiple folders. These folder represent the final results of each episode. We will be running Gradle tasks on the command prompt (Windows) or in Terminal (CentOS/RedHat or MacOS).

### Check Your Requirements

Ensure you have the necessary requirements installed and working.

1. Check Docker.
	1. Open a Terminal window or Windows Command Prompt.
	2. Type `docker --version` then press ENTER. Ensure the version is at least `Docker version 18.03-ce`.
2. Check Docker Compose.
	1. Open a Terminal window or Windows Command Prompt.
	2. Type `docker-compose --version` then press ENTER. Ensure the version is at least `docker-compose version 1.21`. 
3. Download the MarkLogic RHEL/CentOS installer.
	1. In a browser, go to <http://developer.marklogic.com/products>.
	2. Scroll to the section **Red Hat Enterprise Linux / CentOS, Version 7**.
	3. Click the link for **MarkLogic Server x64 (AMD64, Intel EM64T) 64-bit Linux RPM**.
	4. Sign in with your MarkLogic Community credentials then click the **Download** button.
	5. Later, we will copy the downloaded .rpm file as part of the steps to deploy our cluster.
4. Ensure ports 8000 through 8010 and port 9010 are available.
	* If you have MarkLogic installed on your host computer, please stop MarkLogic. There is no need to uninstall MarkLogic, just ensure it is not running. <https://docs.marklogic.com/guide/installation/procedures#id_53295> *Only do step 1 in the Remove MarkLogic procedures to stop, but not remove, MarkLogic.*
	* *Troubleshooting tip:* If you have issues deploying or accessing MarkLogic after deploying, ensure you do not have MarkLogic already running either locally or in a VM and also check to see if any firewall might be blocking the required ports.

### `add-hosts` instructions.  

To follow along with episode 8, do the following.

1. Copy the folder called `starwarsproject` in the `add-hosts` folder to the same level as the `episode8` folder. Replace any existing `starwarsproject` folder.  

2. The `episode8` folder should now have the following folders:  
	* `add-hosts`
	* `starwarsproject` <-- created when you copied the folder from the `add-hosts` folder in **Step 1**.	
3. Copy the MarkLogic .rpm installer that you previously downloaded from <http://developer.marklogic.com/products> to the `src/main/docker/marklogic` folder, within the `starwarsproject` folder created in **Step 1**.

4. In a command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to the `starwarsproject` folder.
	* Type `cd <path to the episode8 files>/episode8/starwarsproject` then press ENTER.

5. Note the inclusion of our project application code in the `src/main/ml-modules/root` and `src/main/ml-modules/services` directories.
	* `root` - contains our web page code and javascript needed to display Google Charts in the browser. We have added new XQuery scripts to log into our application and log out of our application. This enables us to easily test our roles and permissions in this episode.
	* `services` - contains our MarkLogic Server-side JavaScript code to extend MarkLogic's REST api to query our content database for Star Wars character names and heights. The data will be returned to the browser in JSON format.

6. Note our project forest configurations in the `src/main/ml-config/forests` directory.
	* `starwars-content` - directory named after our database name containing custom forest configurations. Our custom configuration, `custom-forests.json`, creates 2 forests on 2 separate MarkLogic hosts (Docker containers, in this case) for the `starwars-content` database.

7. Rather than embed passwords in the Docker Compose build file (`docker-compose.yml`), we are setting environment variables. These environment variable values will be used when the **ml-gradle** deployment is run by the Gradle container.
	* Open the `set-pwd-env.sh` file or the `set-pwd-env.bat` file in a text editor, depending if you are on Unix/Mac or a Windows computer.
	* The lines containing `ADMINPWD=`, `MANAGEPWD=`, `SECUREPWD=`, and `RESTPWD=` contain default password values of `changeme`. You may leave the default values or change them. If you change them, please remember them as they will be used for the MarkLogic Administrator user and other MarkLogic roles.
		* NOTE: Please do not change the line containing `MLCPPWD=`. This contains the password value for our `starwars-admin` user that we will deploy with **ml-gradle**.	 
	* Save the file and exit from your text editor.  
	* On Mac or Unix computers:  
		* In your previously opened terminal window, type `.<space>set-pwd-env.sh` then press ENTER. *Note: there is a space between the "`.`" and the command,* `set-pwd-env.sh`. 
	*  On Windows computers: 
		*  In your previously opened command prompt, type `set-pwd-env.bat` then press ENTER.
	*  These passwords are used by various user account roles in **ml-gradle** as follows:
		*  `mlUsername` - Default user for any REST api call unless overriden by the other user account properties below.
		*  `mlRestAdminUsername` - User for loading modules. Non-REST modules use port 8000. REST modules use the port defined by the `mlRestPort` **ml-gradle** property.
		*  `mlManageUsername` - For ml-gradle, version 3.4.0+, the user for REST api calls to the **Manage** server on port 8002. User must have the `manage-admin` role.
		* `mlSecurityUsername` - User for REST api calls to **Security** endpoints on port 8002 that require a user with both the `manage-admin` and `security` roles.

8. Test password environment variables.
	* On Mac or Unix computers:
		* In a terminal session prompt (CentOS/RedHat or MacOS), type `echo $ADMINPWD` then press ENTER.
		* The value for the `ADMINPWD` environment variable should display with the value that you set (or the default of `changeme`).
	* On Windows computers:  
		* In a command prompt (Windows), type `echo %ADMINPWD%` then press ENTER.
		* The value for the `ADMINPWD` environment variable should display with the value that you set (or the default of `changeme`). 

9. Run the **Docker Compose** build command.
	* Type `docker-compose up` then press ENTER.
	* The Docker Compose build script calls a shell script, `deploy_cluster.sh` from the Gradle Docker container.
	* The `deploy_cluster.sh` script contains multiple **ml-gradle** tasks for doing the following tasks:
		* Initializes each MarkLogic host using the **ml-gradle** `mlInit` task.
		* Creates an administrator account with the `admin` role on the first MarkLogic server container using the **ml-gradle** `mlInstallAdmin` task.
		* Adds the 2 MarkLogic servers to the first MarkLogic server's cluster using the **ml-gradle** `mlAddHost` task.
		* Deploys the application. The application code and configuration is deployed using the **ml-gradle** `mlDeploy` task. A custom task, `deployContent` utilizes MarkLogic's Content Pump libraries to load the database content.
	* Leave the terminal window / command prompt window open.

10. In a web browser, go to <http://localhost:9010/login.xqy> to see the project web page.

11. Log into the deploy Web application. Log out of the Web application first, if necessary.
	* Enter `leia` as the username and `leia` as the password.
	* Click the **Login** button.
	* The Web application displays a table of Star Wars character information. The chart of Star Wars character heights is below the table.

12. When finished, log out of the application.
	* Click the **Logout** button at the top of the Web page.
	* At the "Click here to login again" prompt, click the **login** link.

13. Undeploy the application and content
	* In your previously opened command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), press CTRL-C to quit from Docker Compose. This will also stop the Docker containers.
	* In the same command prompt (Windows) or terminal session prompt (CentOS/RedHat or MacOS), change to the `starwarsproject` folder, if not already there.
	* Type `docker-compose down` then press ENTER. This will delete all of the Docker containers that were created which also deletes our application and content.
	
		> Note, a Docker image called `MarkLogic:LATEST` will remain. Re-running the `docker-compose up` command will not need to create this image again. You may remove this image by typing `docker rmi MarkLogic:LATEST` then pressing ENTER.
		
14. If you wish to create the cluster and run the example application again, it would be a good practice to begin at **Step 7** to ensure the environment variables with the needed password values are set correctly. Then move on to **Steps 8** through **12**.

## Next Steps
When you have completed the `add-hosts` exercise, you have finished with the Episode 8 hands-on exercise.

We hope you have enjoyed this episode.