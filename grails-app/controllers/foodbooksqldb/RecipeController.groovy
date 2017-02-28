package foodbooksqldb

import groovy.sql.*

class RecipeController {

    static responseFormats = ['json', 'xml']


        def username = 'dbreadonly', password = '', database = 'foodbook', server = 'localhost:1433'
        def db = Sql.newInstance("jdbc:mariadb://$server/$database", username, password, 'org.mariadb.jdbc.Driver')


        def index() {
            render ""
        }
    def recipenumber = params.recipeid
    def recipe = []

    def myrecipe() {
        db.eachRow("SELECT * from recipe WHERE ID = " + recipenumber){ row ->
            recipe.add("$row.recipename")
            recipe.add("$row.recipesteps")
            recipe.add("$row.favoritecount")
            recipe.add("$row.recipeimagepath")
        }
    }

    def getingrs() {
        db.eachRow("SELECT DISTINCT ingredient from ingredients WHERE recipeid = " + recipenumber){ row ->
            recipe.add("$row.ingredient")
        }
        respond recipe
        recipe.clear()
    }

    def wholerecipe() {
        myrecipe()
        getingrs()
        recipe.clear()
    }

    def recipeicon(recipenumber) {
        def recipeicon = []

        db.eachRow("SELECT recipename, favoritecount, recipeimagepath FROM recipe WHERE ID = " + recipenumber)
                { row ->
                    recipeicon.add("$row.recipename")
                    recipeicon.add("$row.favoritecount")
                    recipeicon.add("$row.recipeimagepath")
                }
        respond recipeicon
        recipeicon.clear()
    }
}
