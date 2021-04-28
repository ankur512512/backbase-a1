Assignment -1:
Task Details:
- Based on Minikube
- Deploy tomcat v8 to minikube
- Deploy sample.war to tomcat (use this: https://tomcat.apache.org/tomcat-8.0-doc/appdev/sample/ )
- Bind tomcat service to hostport 8090
- Deploy nginx/apache to minikube
- Bind nginx/apache to hostport 8080
- Include simple "hello world" in index.html of nginx


Solution:

Step-1: Login to minikube cloud cluster by going to below link and clicking on ‘Launch Terminal’ button in blue color under ‘Create minikube cluster’ section:

  https://kubernetes.io/docs/tutorials/hello-minikube/
  
  (Wait for a couple of minutes or so for the cluster to get started)

You can also choose to deploy to your own minikube cluster but that might give problems while using hostport. For my assignment, I have used the one on katakoda from link above.


Step-2: Download all the project artifacts directly using git clone command as below and cd into it:

	git clone https://github.com/ankur512512/backbase-a1.git
	cd backbase-a1

####Optional one-click setup

(If you don't want to execute each and every command for deployment then you can directly use setup.sh script as well. You will need to give execute permission first)
		
		chmod 755 setup.sh
		./setup.sh

############################

Step-3: I have assumed that we would be having a Docker registry somewhere to store our images and thus I have created a fresh account on dockerhub for this assignment with below credentials:

Username: backbasedevops
Password: backbase@123

Now use these commands to login to docker hub and then build and push our custom images to docker repository:

	docker login -u backbasedevops -p backbase@123
	docker build -f Dockerfile-tomcat . -t backbasedevops/tomcat
	docker build -f Dockerfile-nginx . -t backbasedevops/nginx
	docker push backbasedevops/nginx
	docker push backbasedevops/tomcat
	
  (In case we decide not to have a docker registry, I have given an alternate solution as well for that, to do the changes directly via bash script in kubernetes)
	

Step-4: We are ready to create our deployments in kubernetes now. Run below commands to create and start the deployments:

	kubectl apply -f .
	
Wait for the pods to come in ready state using this:

	kubectl get pods -w
	
	(Hit ctrl+c when ready)
	

Step -5: Time to test. 

  a.) Test the tomcat deployment by using curl command as below:

	curl `minikube ip`:8090/sample/

This should give output like this:

	<html>
	<head>
	<title>Sample "Hello, World" Application</title>
	</head>
	<body bgcolor=white>

	<table border="0">
	<tr>
	<td>
	<img src="images/tomcat.gif">
	</td>
	<td>
	<h1>Sample "Hello, World" Application</h1>
	<p>This is the home page for a sample application used to illustrate the
	source directory organization of a web application utilizing the principles
	outlined in the Application Developer's Guide.
	</td>
	</tr>
	</table>

	<p>To prove that they work, you can execute either of the following links:
	<ul>
	<li>To a <a href="hello.jsp">JSP page</a>.
	<li>To a <a href="hello">servlet</a>.
	</ul>

	</body>
	</html>	
  	
  If you want to check it via web-browser UI as well, then click on the '+' sign at the top of the minikube terminal (next to the preview port 30000).
  
  ![image](https://user-images.githubusercontent.com/12583640/116216256-0f4adf80-a766-11eb-98c3-55a3cc2826bd.png)

  Then select 'Select Port to view on Host 1':

  ![image](https://user-images.githubusercontent.com/12583640/116216617-6ea8ef80-a766-11eb-9093-06bff3db794c.png)
  
  Enter the port number '8090' in the text box next to the 'Display Port' button and hit enter:
  
  ![image](https://user-images.githubusercontent.com/12583640/116216742-8ed8ae80-a766-11eb-97a3-3b3bf730a025.png)

  You will see the default tomcat page. Append the URL with '/sample/' to view the content of sample.war file and hit enter. It would look like this:
  
  ![image](https://user-images.githubusercontent.com/12583640/116217013-dfe8a280-a766-11eb-89a8-e254e1586b38.png)



  b.) Test the nginx deployment using below curl command:
	
		curl `minikube ip`:8080

This will give you a simple output like below:
			
		"hello world" 
			
If you want to check it via web-browser UI as well, then click on the '+' sign at the top of the minikube terminal (next to the preview port 30000).

Then select 'Select Port to view on Host 1'.

Enter the port number '8080' in the text box next to the 'Display Port' button and hit enter. It should look like this:

![image](https://user-images.githubusercontent.com/12583640/116217463-48d01a80-a767-11eb-8906-255974539064.png)


			
######## Alternate Method (Optional)############################################3
	
If you don't have any container registry then follow steps 1 and 2 as above. After that use below commands:

	kubectl delete deploy tomcat-deployment nginx-deployment   (just in case you are using the same terminal, need to cleanup the old deploys)
	kubectl apply -f optional/

Wait for the pods to get ready.

	kubectl get pods

Test using same methods given in Step-5.
	
	
