## Dataset simple M:N
This data set demonstrates a basic M:N realtionship between 2 tables    
The first is a list of members in Developer Community counting badges gained in Global Masters   
The second is the reference of assigned badges from Global Masters with their titles   
So we have M members that refer to the multiple badges they gained + their count    
And we have set of N Bagdes that are assigned to several members with the count of mebers   
releated tthe the badge and tre back link to them.   

All data result from analysis of the member web pages in Developer Community   
A loader for update of ídentified menbers and addition of new members is provided   
The actual status reflects ~8600 account pages downloaded and analyzed.  
It is up to you to take care for correct maipulation of the M:N reations.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 
Clone/git pull the repo into any local directory
```
git clone https://github.com/rcemper/Dataset-simple-M-N.git
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
## How to Test it

Open IRIS terminal:
###########################################################
```
$ docker-compose exec iris iris session iris 
USER>write ##class(dc.PackageSample.ObjectScript).Test()
```
## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/), [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.
Open /src/cls/PackageSample/ObjectScript.cls class and try to make changes - it will be compiled in running IRIS docker container.
![docker_compose](https://user-images.githubusercontent.com/2781759/76656929-0f2e5700-6547-11ea-9cc9-486a5641c51d.gif)

Feel free to delete PackageSample folder and place your ObjectScript classes in a form
/src/Package/Classname.cls
[Read more about folder setup for InterSystems ObjectScript](https://community.intersystems.com/post/simplified-objectscript-source-folder-structure-package-manager)

The script in Installer.cls will import everything you place under /src into IRIS.


## What's inside the repository

### Dockerfile

The simplest dockerfile which starts IRIS and imports code from /src folder into it.
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.


### .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

### .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript

[Read about all the files in this artilce](https://community.intersystems.com/post/dockerfile-and-friends-or-how-run-and-collaborate-objectscript-projects-intersystems-iris)
