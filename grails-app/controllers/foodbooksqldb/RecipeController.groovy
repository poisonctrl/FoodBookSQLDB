package foodbooksqldb

import groovy.sql.*

class RecipeController {

    static responseFormats = ['json', 'xml']

    //Establish Database Connection
    def username = 'dbreadonly', password = '', database = 'foodbook', server = 'localhost:3306'
    def db = Sql.newInstance("jdbc:mariadb://$server/$database", username, password, 'org.mariadb.jdbc.Driver')

    //define the parameter entry for getting a recipe
    def recipenumber = params.recipeid

    //initialize an arraylist to hold the returned recipe parameters
    def recipe = []

    //define a function to call an SQL query the fields from the recipe table
    /**
     * myrecipe is called by /recipe/myrecipe?recipeid=<recipenumber>
     * @return void, however respond with JSON arraylist containing recipename, steps, favcount, and image path
     */
    def myrecipe() {
        db.eachRow("SELECT * from recipe WHERE ID = " + params.recipeid){ row ->
            recipe.add("$row.recipename")
            recipe.add("$row.recipesteps")
            recipe.add("$row.favoritecount")
            recipe.add("$row.recipeimagepath")
        }
    }

    //define a function to call an SQL query to get the ingredients from the ingredient table
    /**
     * myrecipe is called by /recipe/getingrs?recipeid=<recipenumber>
     * @return void, however respond with JSON arraylist containing ingredient names
     */
    def getingrs() {
        db.eachRow("SELECT DISTINCT ingredient, qtymeas_ingredient from ingredients WHERE recipeid = " + params.recipeid){ row ->
            recipe.add("$row.qtymeas_ingredient" + " " + "$row.ingredient")


        }
        respond recipe
    }

    //define a function to call the functions to get all parts to a recipe
    def wholerecipe() {
        recipe.clear()
        myrecipe()
        getingrs()
    }

    /*define an abbreviated function to get everything about a recipe except
    the steps as this would be the largest download, and if we are displaying
    50 results per page this potentially becomes a lot of downloading.

    The pictures of course are larger than the steps should ever be, but every
    but helps.

    This results in faster parsing of the results page.
    */
    def recipeicon(recipenumber) {
        def recipeicon = []

        db.eachRow("SELECT recipename, favoritecount, recipeimagepath FROM recipe WHERE ID = " + params.recipeid)
                { row ->
                    recipeicon.add("$row.recipename")
                    recipeicon.add("$row.favoritecount")
                    recipeicon.add("$row.recipeimagepath")
                }
        respond recipeicon
        recipeicon.clear()
    }
}
