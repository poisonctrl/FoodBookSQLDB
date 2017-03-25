<!doctype html>
<html>

<head>

    <link rel = "stylesheet"
          type = "text/css"
          href="${resource(dir: 'css', file: '/style.css')}" />
    <title>FOODBOOK</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.13.3/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.13.3/JSXTransformer.js">


        <script src="jquery-1.10.2.min.js"></script>
    <link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
    <script
            src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
    <script src="semantic/dist/semantic.min.js"></script>


    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="js/mb.bgndGallery.js"></script>




</head>

<body>



<div class="column" >
    <div id="content">

    </div>
</div>

<div class="ui two column very relaxed grid">
    <div id="searchbar">
        <div id="recipeFeed"></div>
    </div>

    <div id="image_pack">
        <div class="login-header"><a href="javascript:void(0);">
            <button class="ui red button">Login</button>
        </a></div>
        <div class="login">
            <div class="login-input-content">
                <div class="login-input">
                    <label class="ui label">
                        <h3>USERNAME:</h3>
                    </label>
                    <input type="text" placeholder="please enter user name"  name="info[username]" id="username" class="list-input"/>
                </div>
                <div class="login-input">
                    <label>
                        <h3>PASSWORD:</h3>
                    </label>
                    <input type="password" placeholder="please enter password" name="info[password]" id="password" class="list-input"/>
                </div>
            </div>
            <br/>
            <div class="ui yellow button"><a id="login-button-submit">OK</a></div>
            <div class="login-title"><span><a href="javascript:void(0);" class="close-login"><br/>
                <button class="ui blue button">Close</button>
            </a></span></div>
        </div>

        <div class="login-bg"></div>

    </div>
    <div id="pack">


        <div>
            <input  class="ui input" type="file" onchange="previewFile()"><br/> 
            <img src="" height="300" alt="Image preview..."> 
            <br/><input  class="ui secondary button"  type="submit" id="button" value="upload the image" />
        </div>

    </div>
</div>






<script type="text/javascript">
    function previewFile(){
        var preview = document.querySelector('img'); //selects the query named img 
        var file    = document.querySelector('input[type=file]').files[0]; //sames as here 
        var reader  = new FileReader();
        reader.onloadend = function () {
            preview.src = reader.result;
        }
        if (file) {
            reader.readAsDataURL(file); //reads the data as a URL 
        } else {
            preview.src = "";
        }
    }
    previewFile();


</script>

<script type="text/javascript">

</script>

<script type="text/javascript">
    /*login*/
    $(function () {
        H_login = {};
        H_login.openLogin = function(){
            $('.login-header a').click(function(){
                $('.login').show();
                $('.login-bg').show();
            });
        };
        H_login.closeLogin = function(){
            $('.close-login').click(function(){
                $('.login').hide();
                $('.login-bg').hide();
            });
        };
        H_login.loginForm = function () {
            $("#login-button-submit").on('click',function(){
                var username = $("#username");
                var usernameValue = $("#username").val();
                var password = $("#password");
                var passwordValue = $("#password").val();
                if(usernameValue == ""){
                    alert("please enter your user name");
                    username.focus();
                    return false;
                }else if(usernameValue.length > 15){
                    alert("the unvaild user name please enter again");
                    username.focus();
                    return false;
                }else if(passwordValue == ""){
                    alert("please enter the password");
                    password.focus();
                    return false;
                }else if(passwordValue.length < 6 || passwordValue.length > 30){
                    alert("please enter the vaild password");
                    password.focus();
                    return false;
                }else{
                    alert("success");
                    setTimeout(function(){
                        $('.login').hide();
                        $('.login-bg').hide();
                        $('.list-input').val('');
                    },2000);
                }
            });
        };
        H_login.run = function () {
            this.closeLogin();
            this.openLogin();
            this.loginForm();
        };
        H_login.run();
    });
</script>

<script type="text/jsx">

    /*名字*/
    var Title = React.createClass({

        render() {
            return(
                    <div >
                        <div className="ui vertical column">
                            <h1 id="title" className="ui title">FOODBOOK</h1>
                        </div>

                    </div>
            );
        }

    });
    React.render(<Title />, document.getElementById('content'));




    /*菜单搜索栏*/
    var RecipeFeed = React.createClass({

        getInitialState() {
            return {recipes: [],
                ingredients : "",
                recipename : ""
            };
        },

        handleIngrChange (e) {
            // Prevent following the link.
            e.preventDefault();
            this.setState({ ingredients : e.target.value  , success : "..."});
        },

        handleNameChange (e) {
            // Prevent following the link.
            e.preventDefault();
            this.setState({ recipename : e.target.value  , success : "..."});
        },

        handleNameSubmit(e) {
            // Prevents reinitialization
            e.preventDefault();
            this.setState({recipes: []});
            let recipename = this.state.recipename;
            fetch('http://localhost:8080/search/recnamesearch?recname=' + recipename)
                .then(response => {
                    if(response.ok) {
                        response.json().then(json => {
                            let results = [];
                            for (let i = 0; i < json.length; i++) {
                                results.push(<div id="recipes">{json[i],<br/>}</div>);
                            }
                            this.setState({recipes: results});
                        });
                    }
                    else{
                        // If response is NOT OKAY (e.g. 404), clear the recipes.
                        this.setState({recipes: []});
                    }
                });
        },

        handleIngrSubmit(e) {
            // Prevents reinitialization
            e.preventDefault();
            this.setState({recipes: []});
            let ingredients = this.state.ingredients;
            fetch('http://localhost:8080/search/search?ingredient=' + ingredients)
                .then(response => {
                    if(response.ok) {
                        response.json().then(json => {
                            let results = [];
                            for (let i = 0; i < json.length; i++) {
                                results.push(<div id="recipes">{json[i],<br/>}</div>);
                            }
                            this.setState ({recipes: results});
                        });
                    }
                    else{
                        // If response is NOT OKAY (e.g. 404), clear the recipes.
                        this.setState({recipes: []});
                    }
                });
        },





        /*显示的东西*/
        render() {
            return (
                    <div>

                        <div name="searchBar" id="searchbar">

                            <form onSubmit={this.handleIngrSubmit}>
                                <label>
                                    <input className="ui input" type="text" id="inbox" defaultValue={this.state.ingredients} onChange={this.handleIngrChange}/>

                                </label>
                                <br/>
                                <td/> <input className="ui red button" type="submit" id="button" value="Search by Ingredient" />
                            </form>

                            <form onSubmit={this.handleNameSubmit}>
                                <label>
                                    <input type="text" id="inbox" defaultValue={this.state.recipename} onChange={this.handleNameChange}/>
                                </label>
                                <br/>
                                <td/> <input className="ui red button" type="submit" id="button" value="Search by Recipe" />
                            </form>

                        </div>
                        <div name="image_pack" id="image_pack">
                            {this.state.recipes}
                        </div>
                    </div>

            );
        }
    });
    React.render(<RecipeFeed />, document.getElementById('recipeFeed'));




</script>

</body>
