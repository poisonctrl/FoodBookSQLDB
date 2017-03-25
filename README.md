1.	Browse to https://mariadb.com/downloads, where you can download the version applicable to your software.
2.	Install the default settings. 
3.	The important settings are MariaDB should be configured by default to 3306. One Global access account should exist.
4.	Open Heidi the SQL client that comes with MariaDB (Windows). 
5.	Connect to the database, use root user unless you created an account already: 
6.	Save the file foodbook.sql to your computer. It is in the main directory of this repository as foodbook.sql.
7.	Go to the file menu select load SQL File:   
8.	Hit the blue play button: 
9.	You will probably see some errors, this is normal and is syntactical, the file was auto-generated.
10.	Accept the errors and click on the pane on the left, hit refresh. Foodbook will appear in the left pane.
11.	Click on the little people to create an account: 
  - Create the account as dbreadonly, accept connections from everywhere ‘%’, leave password blank, and grant SELECT. 
13.	Import the foodbooksqldb repository into intellij or clone it
14.	Open a cmd prompt (or hit play in intelliJ, your preference) Browse to the root project folder usually ~\IdeaProjects\FoodBookSQLDB, but will be different if you clone and type ‘grails run-app’.
15.	Open your web browser and type localhost:8080/
16.	You should see our fledgling prototype.

There are only three unique ingredients, 'Love', 'seasoning', and 'chicken', the recipe names are all <text number> star chicken. So example one star chicken. 

You can test out this functionality. 

