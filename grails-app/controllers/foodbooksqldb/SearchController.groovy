package foodbooksqldb

import grails.rest.RestfulController
import groovy.sql.*


class SearchController extends RestfulController {

    SearchController () {
        super(User)
    }

    //recipe map
    def recipe = [
            name: "",
            stepcnt: "",
            steps: [],
            ingrcnt:"",
            ingrs: []
    ]

    //instantiates a database session
    def username = 'dbreadonly', password = '', database = 'foodbook', server = 'localhost:3306'
    def db = Sql.newInstance("jdbc:mariadb://$server/$database", username, password, 'org.mariadb.jdbc.Driver')

    static responseFormats = ['json', 'xml']

    //creates an arraylist of search parameters
    def myList = []

    // count for the ingredients processed by getIngredients()
    def ingredientCount = 0


    //adds all ingedients separated by spaces
    def addAllIngredients() {
        def ingredientString = params.ingredient
        myList = ingredientString.split("\\s+")
    }


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

    //initiates a counter
    def count = 1
    //main search function
    /*
    Currently has issue where while loop doesn't run on refreshed calls
     */
    def search() {
        // adds ingredients to myList
        addAllIngredients()


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

        def theReturnArray = []
        def tempArray2 = []
        def tempString = []

        //closure message to put the information into our arraylist
        db.eachRow(mysrch) { row ->
            //recipe map
            def recipe = [
                    name: "",
                    stepcnt: "",
                    steps: [],
                    ingrcnt:"",
                    ingrs: []
            ]

            def theID = "$row.ID"

            tempArray2 = getIngredients(theID)

            tempString = "$row.recipesteps"

            BufferedReader rdr = new BufferedReader(new StringReader(tempString))
            def lines = []
            def recipeStepCount = 0
            for (String line = rdr.readLine(); line != null; line = rdr.readLine()) {
                lines.add(line)
                recipeStepCount++
            }

            rdr.close()
            recipe.name = "$row.recipename"
            recipe.ingrcnt = ingredientCount
            recipe.ingrs = tempArray2
            recipe.stepcnt = recipeStepCount
            recipe.steps = lines
            theReturnArray.add(recipe)

        }

        // returns the desired array
        respond theReturnArray

        //myList.clear()
        count = 1



    }

    def recnamesearch() {

        //recipe name search query
        String test


        def recparts = []
        test = params.recname
        recparts = test.split(' ')


        def myrecnmsrch = "SELECT DISTINCT ID, recipename, recipesteps, favoritecount, recipeimagepath  FROM recipe WHERE recipename LIKE \'%" + recparts[0] + "%\'"

        def count = 1

        //loop to add additional search parameters to a query
        while (count<(recparts.size())) {
            myrecnmsrch += " AND recipename LIKE '%" + recparts[count] + "%\'"
            count++
        }

        //debug to view search query as submitted to database

        def theReturnArray = []
        def tempArray2 = []
        def tempString = []

        //closure message to put the information into our arraylist
        db.eachRow(myrecnmsrch) { row ->
            //recipe map
            def recipe = [
                    name: "",
                    stepcnt: "",
                    steps: [],
                    ingrcnt:"",
                    ingrs: []
            ]
            def theID = "$row.ID"

            recipe.name =  "$row.recipename"

            tempArray2 = getIngredients(theID)
            recipe.ingrcnt = ingredientCount
            recipe.ingrs = tempArray2

            tempString = "$row.recipesteps"

            BufferedReader rdr = new BufferedReader(new StringReader(tempString))
            def lines = []
            def recipeStepCount = 0
            for (String line = rdr.readLine(); line != null; line = rdr.readLine()) {
                lines.add(line)
                recipeStepCount++
            }

            rdr.close()

            recipe.stepcnt = recipeStepCount
            recipe.steps = lines
            theReturnArray.add(recipe)

        }
        // returns the desired array
        respond theReturnArray

        //count = 1
    }

    def getrecipes(recid) {
        count = 0
        def recs = []
        while (count <= (recid.size())) {
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

    def getIngredients(recipeID) {
        ingredientCount = 0
        def tempArray = []

        db.eachRow("SELECT ingredient,qtymeas_ingredient  FROM ingredients WHERE recipeid LIKE " + recipeID){ row ->
            tempArray.add("$row.qtymeas_ingredient" + " " + "$row.ingredient")
            ingredientCount++
        }
        return tempArray

    }
}