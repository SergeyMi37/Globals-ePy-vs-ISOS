# Dataset Lightweight M:N
This data set demonstrates a basic M:N relationship between 2 tables   
The dataset is targeted to show a **slim** implementation of M:N    
It's no question that other implementations exist. But at significant more storage consumption.

The first is a list of members in Developer Community counting badges gained in Global Masters   
The second is the reference of assigned badges from Global Masters with their titles   
So we have M members that refer to the multiple badges they gained + their count    
And we have a set of N Bagdes that are assigned to several members + the count of members   
related to that badge and the Ids to these members.   

All datas result from the analysis of the member web pages in Developer Community   
A utility for updates of ídentified members and the addition of new members is provided   
The actual status reflects 9690 account pages downloaded and analyzed relating to 177 badges.   

Relations are implemented as Lists of pure id's (not *oref* to save space)   
````
/// pure ID of awarded GM badges
Property Badges As List Of %Integer;

/// pure ID of assigned members
Property Members As List Of %Integer;
````

A few explanations on operation structures for further extension:   
- GM badges never change or get deleted - so they just can grow   
- DC members can get GM badges granted, but they will never lose it  
It is up to you to take care for correct maintenance of the M:N relations    
for DELETE or UPDATE of DC members. This is intentionally left open.   

3 utility methods are provided:   
- Load(): this loads and analyzes the information presented on the member's page     
- Upd() : runs over every defined member using *Load()* for actual values    
- New() : runs past the highest known MemberId and tries to find new ones  
MemberId's are not given in closed sequence. So they can't be predicted but only tried
- To use these methods you will need to create a SSL Configuration named "community"    
in SMP for client access to _community.intersystems.com:443_ .    
This is included in Docker image setup

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
Connect to the containers SMP and examine content in namespace USER   
applying the described examples   
**[or use Online Demo](https://dataset-lightweight-m-n.demo.community.intersystems.com/csp/sys/UtilHome.csp)**

### Example 1 
- find badges for specific members
```
  select name,title FROM dc_data_rcc.DCmember
  join dc_data_rcc.GMbadge on BadgeId %inlist (badges)
  where mbrid in (13081,65426) 
  order by 1,2
----------------------------------------------
Name               Title
Joerg Schuck       1,000 Points
Joerg Schuck       Challenge Starter
Joerg Schuck       DC Commenter
Joerg Schuck       Open Sesame!
Leontiy Mischenko  1,000 Points
Leontiy Mischenko  5,000 Points
Leontiy Mischenko  Challenge Starter
Leontiy Mischenko  Open Sesame!
----------------------------------------------
```
### Example 2
- find DCmembers that hold a specific GMbadge
```
  select title, name FROM dc_data_rcc.GMbadge
  join dc_data_rcc.DCmember on mbrid %inlist (members)
  where badgeid in (15,25)
  order by 1,2
----------------------------------------------
Title                 Name
Conversation Starter  Dmitry Maslennikov
Conversation Starter  Fabian Haupt
Conversation Starter  Robert Cemper
Conversation Starter  Scott Beeson
Conversationalist     david clifte
Conversationalist     Robert Cemper
Conversationalist     Scott Beeson
Conversationalist     Stephen De Gabrielle
----------------------------------------------
```
## What's inside the repository
### Dockerfile
The simplest dockerfile which starts IRIS and imports code from /src folder into it.   
Use the related docker-compose.yml to easily setup additional parametes like     
port number and where you map keys and host folders.
### .vscode/settings.json   
Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)
###  .vscode/launch.json  
Config file if you want to debug with VSCode ObjectScript

### Code Quality
![CodeQuality](https://raw.githubusercontent.com/rcemper/Dataset-Lightweight-M-N/master/CodeQuality.JPG)

[Article in DC](https://community.intersystems.com/post/dataset-lightweight-mn)
