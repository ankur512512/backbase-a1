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

You can also choose to deploy to your own minikube cluster but that might give problems while using hostport. For my assignment, I have used the one on katakoda from link above.

Step-2: Download all the project artifacts directly using wget command as below and cd into it:

	wget https://github.com/ankur512512/backbase-a1.git
	cd backbase-a1

Step-3: I have assumed that we would be having a Docker repo somewhere and have created a fresh account for this assignment with below credentials:

Username: backbasedevops
Password: backbase@123

Now use these commands to docker and then build and push our custom images to docker repository:

	docker login -u backbasedevops -p backbase@123
	docker build -f Dockerfile-tomcat . -t backbasedevops/tomcat
	docker build -f Dockerfile-nginx . -t backbasedevops/nginx
	docker push backbasedevops/nginx
	docker push backbasedevops/tomcat
	
  (In case we decide not to have a docker registry, I have given an alternate solution as well for that to do the changes directly via bash script in kubernetes)
	
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
	
	b.) Test the nginx deployment using below curl command:
	
		curl `minikube ip`:8080

This will give you a simple output like below:
			
		"hello world" 
			
			
######## Alternate Method (Optional)############################################3
	
If you don't have any container registry then follow steps 1 and 2 as above. After that use below commands:

	kubectl apply -f optional/

Wait for the pods to get ready.

	kubectl get pods

Test using same methods given in Step-5.
	
	