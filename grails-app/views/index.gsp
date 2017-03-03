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
    <button class="button_signup" id="button">Sign Up</button>
    <button class="button_login" id="button">Log In</button>
</div>


<div name="searchBar" id="searchbar">
    <h1 id="search_title">Search By:</h1>
    <h2 id="ing_list">Ingredients List:
        <g:form name = "srchBar" controller="search">
            <g:textField name="ingredient" />
            <div name="buttons">

            <g:actionSubmit value="Add Ingredient" method="get" id="smbutton" action="addIngredient" />
            <g:actionSubmit value="Rem Ingredient" method="get" id="smbutton" action="remIngredient" />
            <BR />
            <BR />
            <g:actionSubmit value="Search by Ingredient" id="smbutton" action="search" />
            <BR />

        </g:form>

    </div>
        <HR />
        <div name="clearbutton">
            <g:form name = "clrsrchBar" controller="search">
                <g:actionSubmit value="Clear Ingredient List" id="smbutton" action="clearparams" />
                <g:actionSubmit value="Show Ingredient List" id="smbutton" action="showSearchParams" />
            </g:form>
        </div>

        <div name="srchbutton">
            <g:form name = "srchsrchBar" controller="search">
                <HR />
                <g:textField name="recname" />
                <g:actionSubmit value="Search by Recipename" id="smbutton"action="recnamesearch" />
            </g:form>
            <BR />
            <BR />
        </div>
    </h2>

    <div id="recipeFeed" align="left"></div>
    <asset:javascript src="index.bundle.js"/>

</div>



<div name="image_pack" id="image_pack">
        <br>
    <br>
</div>

</body>
</html>
