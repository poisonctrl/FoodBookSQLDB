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
    <h1 id="search_title">Search By:</h1>
    <h2 id="ing_list">Ingredients List:
        <input type="text" size="30">
        <button>GO</button>
    </h2>

    <div id="recipeFeed" align="left"></div>
    <asset:javascript src="index.bundle.js"/>

</div>



<div name="image_pack" id="image_pack">
    <div name="first" class="first">first</div>
    <div name="second" class="second">second</div>
    <div name="third" class="third">third</div>
    <div name="forth" class="forth">forth</div>
    <div name="fifth" class="fifth">fifth</div>
</div>

</body>
</html>
