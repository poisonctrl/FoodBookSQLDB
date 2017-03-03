<!doctype html>
<html>
<head>
    <link rel = "stylesheet"
          type = "text/css"
          href="${resource(dir: 'css', file: '/style.css')}" />

</head>

<body class="div">



<div name="title" class="title">
    <h1 id="title">
        FOODBOOK
    </h1>
    <button class="buttom_signup" id="buttom">Sign Up</button>
    <button class="buttom_login" id="buttom">Log In</button>
</div>


<div name="searchBar" id="searchbar">
    <h2>Section Under Construction<br>Use sections on right to interface the database</h2>
    <h1 id="search_title">Search By:</h1>
    <h2 id="ing_list">Ingredients List:
    <g:form name = "srchBar" controller="search">
    <g:textField name="ingredient">  </g:textField>
    <g:actionSubmit value="Add Ingredient" action="addIngredient" />
        <g:actionSubmit value="Rem Ingredient" action="remIngredient" />
    </g:form>
    <g:form name = "clrsrchBar" controller="search">
    <g:actionSubmit value="Clear Ingredient List" action="clearparams" />
    </g:form>
    </h2>

    <div id="recipeFeed" align="left"></div>
    <asset:javascript src="index.bundle.js"/>

</div>



<div name="image_pack" id="image_pack">
    <h3>This is a prototype and as such below is the temporary way to interface in the recipe.</h3>
    <h3>In section 3 you search the database and you will see a list of recipe numbers containing those ingredients in the list</h3>
    <h3>Finally you can get the recipe in its raw format</h3>
        <br>
        <br>

        <H2>Search by Ingredient</H2>
        <a href="${createLink(uri:'http://localhost:8080/search/search')}">Search</a>
    <H2>Get Recipe</H2>
    <a href="${createLink(uri:'http://localhost:8080/recipe/wholerecipe?recipeid=1')}">Get Recipe 1</a>
    <a href="${createLink(uri:'http://localhost:8080/recipe/wholerecipe?recipeid=2')}">Get Recipe 2</a>
    <a href="${createLink(uri:'http://localhost:8080/recipe/wholerecipe?recipeid=3')}">Get Recipe 3</a>
    <a href="${createLink(uri:'http://localhost:8080/recipe/wholerecipe?recipeid=4')}">Get Recipe 4</a>
    <a href="${createLink(uri:'http://localhost:8080/recipe/wholerecipe?recipeid=5')}">Get Recipe 5</a>


</div>

</body>
</html>
