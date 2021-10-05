## Dataset simple M:N
This data set demonstrates a basic M:N realtionship between 2 tables    
The first is a list of members in Developer Community counting badges gained in Global Masters   
The second is the reference of assigned badges from Global Masters with their titles   
So we have M members that refer to the multiple badges they gained + their count    
And we have set of N Bagdes that are assigned to several members with the count of mebers   
releated tthe the badge and tre back link to them.   

All data result from analysis of the member web pages in Developer Community   
A loader for update of ídentified menbers and addition of new members is provided   
The actual status reflects 9690 accounts pages downloaded and analyzed relating to 177 badges.   

Relations are implemented as Lists of pure id's (not oref to save space on GitHub)   
````
/// pure ID of awarded GM badges
Property Badges As List Of %Integer;

/// pure ID of assigned members
Property Members As List Of %Integer;
````

A few explanation on operations structures for further extention:   
GM badges never change or get deleted - so they just can grow   
DC members can get GM badges granted, but the will never lose it  
It is up to you to take care for correct maintenance of the M:N relations for   
DELETE or UPDATE of DC members. This is intentionally left open . 

3 utilitie are provided:   
- Load: this loads and analyzes the information presentes on the member'S page     
- Upd : runs over all defined members to usinf LOAD for actual values    
- New : runs past the highest known member's id and tries to find new ones  
MemberId's are not given in closed sequence. So they can't be predicted but tried

### Examples 
````
---- find badges for specific members
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

---- find DCmembers that hold a specific GMbadge
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
````







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
