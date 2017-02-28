package foodbooksqldb

import groovy.sql.*

class SearchController {

    //instantiates a database session
    def username = 'dbreadonly', password = '', database = 'foodbook', server = 'localhost:1433'
    def db = Sql.newInstance("jdbc:mariadb://$server/$database", username, password, 'org.mariadb.jdbc.Driver')

    static responseFormats = ['json', 'xml']

    def index() {
    }

    //creates an arraylist of search parameters
    def myList = []

    //adds an ingredient, displays current search parameters
    def addIngredient() {
        myList.add(params.ingredient)
        showSearchParams()
    }

    //returns current ingredients after removing one
    def remIngredient() {
        myList.remove(params.ingredient)
        showSearchParams()
    }

    //returns current search parameter list
    def showSearchParams() {
        response myList
    }

    //creates an arraylist to store the IDs
    def theIDS = []
    //initiates a counter
    def count = 1
    //main search function
    /*
    Currently has issue where while loop doesn't run on refreshed calls
     */
    def search() {
        //basic search query
        def mysrch = "SELECT DISTINCT recipeid FROM ingredients WHERE ingredient LIKE \'%" + myList[0] + "%\'"

        //loop to add additional search parameters to a query
        while (count<(myList.size())) {
            mysrch += " OR ingredient LIKE '%" + myList[count] + "%\'"
            count++
        }

        //debug to view search query as submitted to database
        render mysrch + "\n"

        //closure message to put the information into our arraylist
        db.eachRow(mysrch){ row -> theIDS.add("$row.recipeID")

        }
        respond theIDS
        theIDS.clear()
    }


    def uniqueIngrs = []
    //returns unique ingredients in the ingredients list
    def unqingr() {
        db.eachRow("SELECT DISTINCT ingredient from ingredients"){ row ->
            uniqueIngrs.add("$row.ingredient")
        }
        respond uniqueIngrs
        uniqueIngrs.clear()
    }

}
