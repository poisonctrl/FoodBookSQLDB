package foodbooksqldb

import grails.rest.RestfulController
import groovy.sql.*

/*
This class acts as a controller to manage the search of the associated database
 */
class SearchController extends RestfulController {

    SearchController () {
        super(User)
    }

    //Recipe map
    def recipe = [
            name: "",
            stepcnt: "",
            steps: [],
            ingrcnt:"",
            ingrs: []
    ]

    //Instantiates a database session
    def username = 'dbreadonly', password = '', database = 'foodbook', server = 'localhost:3306'
    def db = Sql.newInstance("jdbc:mariadb://$server/$database", username, password, 'org.mariadb.jdbc.Driver')

    static responseFormats = ['json', 'xml']

    //Creates an arraylist of search parameters
    def myList = []

    //Count for the ingredients processed by getIngredients()
    def ingredientCount = 0

    //Combines all ingredients and separates them by sapces
    def addAllIngredients() {
        def ingredientString = params.ingredient
        myList = ingredientString.split("\\s+")
    }

    //Adds an ingredient, displays current search parameters
    def addIngredient() {
        myList.add(params.ingredient)
        showSearchParams()
    }

    //Returns current ingredients after removing one
    def remIngredient() {
        myList.remove(params.ingredient)
        showSearchParams()
    }

    //Returns current search parameter list
    def showSearchParams() {
        respond myList
    }

    //Initiates a counter to record list size when searching the databse
    def count = 1

    /*
    This is the main search function for the class and returns matching recipes, based on a list of ingredients
    */
    def search() {
        // Adds ingredients to myList
        addAllIngredients()

        /*
        Creates an SQL query based on the entered parameters
        Takes a series of ingredient names and returns recipe IDs
        */
        def mysrch = "SELECT DISTINCT recipe.ID, recipename, recipesteps, recipeimagepath\n" +
                "FROM ingredients JOIN recipe\n" +
                "ON ingredients.recipeid = recipe.ID\n" +
                "WHERE ingredients.ingredient LIKE \'%" + myList[0] + "%\'"

        //Loop to add additional search parameters to a query
        while (count<(myList.size())) {
            mysrch += " OR ingredient LIKE '%" + myList[count] + "%\'"
            count++
        }

        //Series of arrays to contain the strings to be returned vy the searcg function
        def theReturnArray = []
        def tempArray2 = []
        def tempString = []

        //Closure message to put the information into our array list
        //Analyzes each returned row
        db.eachRow(mysrch) { row ->
            //Recipe map
            def recipe = [
                    name: "",
                    stepcnt: "",
                    steps: [],
                    ingrcnt:"",
                    ingrs: []
            ]

            //Assigns the ID
            def theID = "$row.ID"

            //Populates the array with the ingredients based off the ID
            tempArray2 = getIngredients(theID)

            //Populates the string with the recipe steps based off of the ID
            tempString = "$row.recipesteps"

            //Buffer Reader to decompose the list of steps into an acceptable output format
            BufferedReader rdr = new BufferedReader(new StringReader(tempString))
            def lines = []
            def recipeStepCount = 0
            for (String line = rdr.readLine(); line != null; line = rdr.readLine()) {
                lines.add(line)
                recipeStepCount++
            }
            rdr.close()

            //Assigns the desired output data
            recipe.name = "$row.recipename"
            recipe.ingrcnt = ingredientCount
            recipe.ingrs = tempArray2
            recipe.stepcnt = recipeStepCount
            recipe.steps = lines
            theReturnArray.add(recipe)

        }

        //Returns the desired array
        respond theReturnArray

        //myList.clear()
        count = 1
    }

    /*
    This is the secondary search function for the class and returns matching recipes, based on a recipe name
    */
    def recnamesearch() {

        //Recipe name search string
        String test

        //Separates the string of name parameters
        def recparts = []
        test = params.recname
        recparts = test.split(' ')

        //SQL query to search for recipe IDs, based off of recipe name
        def myrecnmsrch = "SELECT DISTINCT ID, recipename, recipesteps, favoritecount, recipeimagepath  FROM recipe WHERE recipename LIKE \'%" + recparts[0] + "%\'"

        //Initiates a counter to record list size when searching the databse
        def count = 1

        //Loop to add additional search parameters to a query
        while (count<(recparts.size())) {
            myrecnmsrch += " AND recipename LIKE '%" + recparts[count] + "%\'"
            count++
        }

        //Series of arrays to contain the strings to be returned vy the searcg function
        def theReturnArray = []
        def tempArray2 = []
        def tempString = []

        //Closure message to put the information into our array list
        //Analyzes each returned row
        db.eachRow(myrecnmsrch) { row ->
            //Recipe map
            def recipe = [
                    name: "",
                    stepcnt: "",
                    steps: [],
                    ingrcnt:"",
                    ingrs: []
            ]

            //Assigns the ID
            def theID = "$row.ID"

            //Assigns the name
            recipe.name =  "$row.recipename"

            //Populates the array with the ingredients based off the name
            tempArray2 = getIngredients(theID)

            //Assigns respective values
            recipe.ingrcnt = ingredientCount
            recipe.ingrs = tempArray2

            //Populates the string with the recipe steps based off of the name
            tempString = "$row.recipesteps"

            //Buffer Reader to decompose the list of steps into an acceptable output format
            BufferedReader rdr = new BufferedReader(new StringReader(tempString))
            def lines = []
            def recipeStepCount = 0
            for (String line = rdr.readLine(); line != null; line = rdr.readLine()) {
                lines.add(line)
                recipeStepCount++
            }
            rdr.close()

            //Assigns the desired output data
            recipe.stepcnt = recipeStepCount
            recipe.steps = lines
            theReturnArray.add(recipe)

        }
        //Returns the desired array
        respond theReturnArray
    }

    /*
    Method to return recipes based off of an ID
    This method is intended to locate recipe information after a database search has identified the recipes
    */
    def getrecipes(recid) {
        count = 0
        def recs = []
        while (count <= (recid.size())) {
            recs.add("redirect:/recipe/wholerecipe?recipeid=" + count)
        }
    }

    //Array to hold ingredients
    def uniqueIngrs = []
    //Returns unique ingredients in the ingredients list
    def unqingr() {
        db.eachRow("SELECT DISTINCT ingredient from ingredients"){ row ->
            uniqueIngrs.add("$row.ingredient")
        }
        respond uniqueIngrs
        uniqueIngrs.clear()
    }

    //Clears all ingredients, displays current search parameters
    def clearparams() {
        myList.clear()
        showSearchParams()
    }

    /*
    This method retrives the ingredients associated with a recipe ID
    It is intended to return the ingredient list after a recipe has been identified by the search function
    */
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