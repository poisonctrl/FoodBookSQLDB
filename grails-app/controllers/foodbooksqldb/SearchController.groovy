package foodbooksqldb

import grails.rest.RestfulController
import groovy.sql.*


class SearchController {

    //instantiates a database session
    def username = 'dbreadonly', password = '', database = 'foodbook', server = 'localhost:3306'
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
        respond myList
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
        def mysrch = "SELECT DISTINCT recipe.ID, recipename, recipesteps, recipeimagepath\n" +
                "FROM ingredients JOIN recipe\n" +
                "ON ingredients.recipeid = recipe.ID\n" +
                "WHERE ingredients.ingredient LIKE \'%" + myList[0] + "%\'"

        //loop to add additional search parameters to a query
        while (count<(myList.size())) {
            mysrch += " OR ingredient LIKE '%" + myList[count] + "%\'"
            count++
        }


        //closure message to put the information into our arraylist
        db.eachRow(mysrch) { row ->
            render "Recipe ID: " + "$row.ID" + "<br />"
            render "Recipe Name: " + "$row.recipename" + "<br />"
            render "Recipe Steps: " + "$row.recipesteps" + "<br />"
            render "<br />"
        }

        respond theIDS
        theIDS.clear()
        count = 1

    }

    def recnamesearch() {
        //recipe name search query
        String test;


        def recparts = []

        test = params.recname

        recparts = test.split(' ')

        def recids = []

        def myrecnmsrch = "SELECT DISTINCT ID, recipename, recipesteps, favoritecount, recipeimagepath  FROM recipe WHERE recipename LIKE \'%" + recparts[0] + "%\'"

        def count = 1

        //loop to add additional search parameters to a query
        while (count<(recparts.size())) {
            myrecnmsrch += " AND recipename LIKE '%" + recparts[count] + "%\'"
            count++
        }

        //debug to view search query as submitted to database

        //closure message to put the information into our arraylist
        db.eachRow(myrecnmsrch){ row ->
            render "Recipe ID: " + "$row.ID" + "<br />"
            render "Recipe Name: " + "$row.recipename" + "<br />"
            render "Recipe Steps: " + "$row.recipesteps" + "<br />"
            render "<br />"
        }
        respond recids
        recids.clear()
        count = 1

}

    def getrecipes(recid) {
        count = 0
        def recs = []
        while (count < (recid.size())) {
            recs.add("redirect:/recipe/wholerecipe?recipeid=" + count)
        }
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

    //clears all ingredient, displays current search parameters
    def clearparams() {
        myList.clear()
        showSearchParams()
    }
}
