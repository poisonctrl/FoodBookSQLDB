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
        <input type="text" size="30" id="searchterm">
        <button onclick="goAdd()">Add Ingredient</button>
    </h2>

    <div id="recipeFeed" align="left"></div>
    <asset:javascript src="index.bundle.js"/>

</div>



<div name="image_pack" id="image_pack">
    <h3>This is a prototype and as such below is the temporary way to interface in the recipe.</h3>
        <h3>When you click on an ingredient it will add it to the ingredient list.</h3>
        <h3>You can remove the same ingredients, or clear them all in section 2</h3>
        <h3>In section 3 you search the database and you will see a list of recipe numbers containing those ingredients in the list</h3>
        <h3>Finally you can get the recipe in its raw format</h3>
        <br>
        <br>
    <h2>Add Ingredients</h2>

        <a href="${createLink(uri:'http://localhost:8080/search/addIngredient?ingredient=chicken')}">Add Chicken</a>
        <a href="${createLink(uri:'http://localhost:8080/search/addIngredient?ingredient=ham')}">Add ham</a>
        <a href="${createLink(uri:'http://localhost:8080/search/addIngredient?ingredient=seasoning')}">Add seasoning</a>
        <a href="${createLink(uri:'http://localhost:8080/search/addIngredient?ingredient=Love')}">Add Love</a>
        <a href="${createLink(uri:'http://localhost:8080/search/addIngredient?ingredient=Dog Food')}">Add Dog Food</a>
        <a href="${createLink(uri:'http://localhost:8080/search/addIngredient?ingredient=apples')}">Add apples</a>
        <a href="${createLink(uri:'http://localhost:8080/search/addIngredient?ingredient=' + this.ingreds)}">Add Toast</a>
<br>
        <br>

        <h2>Remove Ingredients</h2>
        <a href="${createLink(uri:'http://localhost:8080/search/remIngredient?ingredient=chicken')}">Remove Chicken</a>
        <a href="${createLink(uri:'http://localhost:8080/search/remIngredient?ingredient=ham')}">Remove ham</a>
        <a href="${createLink(uri:'http://localhost:8080/search/remIngredient?ingredient=seasoning')}">Remove seasoning</a>
        <a href="${createLink(uri:'http://localhost:8080/search/remIngredient?ingredient=Love')}">Remove Love</a>
        <a href="${createLink(uri:'http://localhost:8080/search/remIngredient?ingredient=Dog Food')}">Remove Dog Food</a>
        <a href="${createLink(uri:'http://localhost:8080/search/remIngredient?ingredient=apples')}">Remove apples</a>
        <a href="${createLink(uri:'http://localhost:8080/search/remIngredient?ingredient=' + this.ingreds)}">Remove Toast</a>
        <br><br>
        <li><a href="${createLink(uri:'http://localhost:8080/search/clearparams')}">Clear Ingredient List</a></li>

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
