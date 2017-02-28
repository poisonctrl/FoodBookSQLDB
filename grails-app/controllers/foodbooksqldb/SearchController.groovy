package foodbooksqldb

import groovy.sql.*
import groovy.sql.GroovyRowResult

class SearchController {
    def username = 'dbreadonly', password = '', database = 'foodbook', server = 'localhost:1433'

    def db = Sql.newInstance("jdbc:mariadb://$server/$database", username, password, 'org.mariadb.jdbc.Driver')

    static responseFormats = ['json', 'xml']

    def index() {
        render ""
    }

    def myList = []

    def addIngredient() {
        myList.add(params.ingredient)
        showSearchParams()
    }

    def remIngredient() {
        myList.remove(params.ingredient)
        showSearchParams()
    }

    def showSearchParams() {
        render myList
    }

    // def something() = Ingredients.find { ingredient == mylist[0] }

    def theIDS = []

    def count = 1
    def search() {

        def mysrch = "SELECT DISTINCT recipeid FROM ingredients WHERE ingredient LIKE \'%" + myList[0] + "%\'"

        while (count<(myList.size())) {
            mysrch += " OR ingredient LIKE '%" + myList[count] + "%\'"
            count++
        }

        render mysrch

        db.eachRow(mysrch){ row -> theIDS.add("$row.recipeID")

        }
        respond theIDS
        theIDS.clear()
    }


    def uniqueIngrs = []

    def unqingr() {

        db.eachRow("SELECT DISTINCT ingredient from ingredients"){ row ->
            uniqueIngrs.add("$row.ingredient")
        }
        respond uniqueIngrs
        uniqueIngrs.clear()
    }

}
