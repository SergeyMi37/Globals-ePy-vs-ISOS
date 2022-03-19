# Globals-ePy-vs-ISOS
This example demonstrates the difference you may experience when you access globals   
directly from Embedded Python compared to native ObjectScript.   

To make this demo useful I start 2 background jobs that simply write sequentially   
to a dedicated global. A common control method signals for a synchronous start.   
Similar a common stop & view interrupts data feeding.   

As 2 jobs run in parallel the probability of just using sequential blocks is reduced.    
During the development of this demo, I detected that the JOB command has problems   
with ClassMethods in Embedded Python.    
**WARNING:**     
Due to the poor dimensioned Community License the start of the background jobs     
may fail if you have other connections active at the same time. 

During my series of test, I found that ePy writes ~53% of the pure ISOS code   
See also examples below.   

The control method prepares the background processes and has 3 commands:   
- 0 .. stop background jobs and show last run results
- 1 .. interrupt background jobs and show last run results
- 2 .. run data load in background jobs.   
Loading is interrupted after 60 sec to prevent breaking of the DB  
if not done manually

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 
Clone/git pull the repo into any local directory
```
git clone https://github.com/rcemper/Globals-ePy-vs-ISOS.git
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
## How to Test it
Connect to the container using [webterminal](http://localhost:52773/terminal/?ns=USER) or    
start an IRIS session in docker
```
   docker-compose exec iris iris session iris
```
or use    
- **[Online Demo SMP](https://globals-epy-vs-isos.demo.community.intersystems.com/csp/sys/%25CSP.Portal.Home.zen)**    
- **[Online Demo Webterminal](https://globals-epy-vs-isos.demo.community.intersystems.com/terminal/?ns=USER)**    
### Example
```
USER>do ##class(dc.rcc.ePYvsISOS).do()

JobStart ISOS #3841
JobStart  ePy #3842
Job Control [0=stop,1=view,2=go]: 2
Job Control [0=stop,1=view,2=go]: 1
^ePy(1,492029)=2022-03-11 20:49:32.851286
^ISOS(1,927383)=2022-03-11 20:49:32.851289

Job Control [0=stop,1=view,2=go]:
Job Control [0=stop,1=view,2=go]: 2
Job Control [0=stop,1=view,2=go]:
Job Control [0=stop,1=view,2=go]:
Job Control [0=stop,1=view,2=go]:
Job Control [0=stop,1=view,2=go]:
^ePy(2,4149270)=2022-03-11 20:50:54.620362
^ISOS(2,7719690)=2022-03-11 20:50:54.620371

Job Control [0=stop,1=view,2=go]:2
Job Control [0=stop,1=view,2=go]:
Job Control [0=stop,1=view,2=go]: 0
^ePy(3,3148765)=2022-03-11 20:50:54.620362
^ISOS(3,6714519)=2022-03-11 20:50:54.620371
```

## What's inside the repository
### Dockerfile
The simplest dockerfile which starts IRIS and imports code from /src folder into it.   
Use the related docker-compose.yml to easily setup additional parameters like     
port number and where you map keys and host folders.
### .vscode/settings.json   
Settings file to let you immediately code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)
###  .vscode/launch.json  
Config file if you want to debug with VSCode ObjectScript

### Code Quality 
![CodeQuality](https://raw.githubusercontent.com/rcemper/Globals-ePy-vs-ISOS/master/CodeQuality.JPG) 

[Article in DC.PT](https://pt.community.intersystems.com/post/globals-comparar-embedded-python-e-objectscript)     
[Article in DC.EN](https://community.intersystems.com/post/compare-global-write-epy-vs-isoscos) 
