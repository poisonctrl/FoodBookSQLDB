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
    def ingredient = [] // array to hold the ingredients in
    def qtymeas = [] // the quantity measurements
    def recipeName // name of the new recipe
    def recipeSteps // recipe steps
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
    // add ingredient to list
    def addIngredient(){
        ingredient.add(params.ingredient)
        qtymeas.add(params.qtymeas)
    }
    // remove ingredient from list
    def removeIngredient(){

        def index=null;
        for (int i=0;i <ingredient.size();i++){
            if (ingredient[i]==params.ingredient){
                index = i //where is it in the list
            }
        }
        if (index == null){ // if the ingredient was not found
            render "Ingredient not in list."
        }

        ingredient.remove(params.ingredient)
        qtymeas.remove(index) // remove corresponding quantity measurement
    }
    //add the name of the recipe
    def addName(){
        recipeName = params.name
    }
    //add the steps of the recipe
    def addSteps(){
        recipeSteps = params.steps
    }
    def add(){

        db.execute("INSERT INTO recipe (recipename,recipesteps) VALUES ($recipeName,$recipeSteps)") //insert

        //get the number of entries currently in table
        def result = db.firstRow('select count(*) as cont from recipe')
        long id = result.cont
        def params = []
        for (int i=0;i<ingredient.size();i++){

            params = [id,ingredient[i],qtymeas[i]]
            db.execute 'INSERT INTO ingredients (recipeid,ingredient,qtymeas_ingredient) VALUES (?,?,?)',params //insert

        }


    }
}
