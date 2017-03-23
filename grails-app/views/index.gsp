<!doctype html>
<html>

<head>

    <link rel = "stylesheet"
          type = "text/css"
          href="${resource(dir: 'css', file: '/style.css')}" />

    <title>FOODBOOK</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.13.3/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.13.3/JSXTransformer.js"></script>
</head>

<body>

<div id="content"></div>
<div id="login"></div>
<div id="recipeFeed"></div>

<script type="text/jsx">



    var Title = React.createClass({

        render() {
            return(<h1 id="title" className="title">FOODBOOK</h1>);
        }



    });
    React.render(<Title />, document.getElementById('content'));

    var Login = React.createClass({
        render() {
            return(
                    <div>
                        <form onSubmit={this.loginRedirect}>
                            <input type="submit" value="Login" />
                        </form>
                    </div>);
        }
    });
    React.render(<Login />, document.getElementById('login'));

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
                                results.push(
                                    <div id="recipe">
                                    <div id="name">
                                        {json[i].name}
                                        <br/>
                                    </div>
                                    <div id = "ingrs">
                                        {json[i].ingrs.map((number) =>
                                                <li>{number}</li>
                                        )}
                                        <br/>
                                    </div>
                                    <div id = "steps">
                                        {json[i].steps.map((number) =>
                                                <li>{number}</li>
                                        )}
                                    </div>
                                    <br/>
                                </div>
                                );
                            }
                            if (response.json.isNull) { let results = ['No Result']
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
                                results.push(
                                    <div id="recipe">
                                        <div id="name">
                                            {json[i].name}
                                            <br/>
                                        </div>
                                        <div id = "ingrs">
                                            {json[i].ingrs.map((number) =>
                                                    <li>{number}</li>
                                            )}
                                            <br/>
                                        </div>
                                        <div id = "steps">
                                            {json[i].steps.map((number) =>
                                                    <li>{number}</li>
                                            )}
                                        </div>
                                        <br/>
                                    </div>
                                );
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

        render() {
            return (
                    <div>
                        <div name="searchBar" id="searchbar">

                            <form onSubmit={this.handleIngrSubmit}>
                                <label>
                                    <input type="text" id="inbox" defaultValue={this.state.ingredients} onChange={this.handleIngrChange}/>

                                </label>
                                <br/>
                                <td/> <input type="submit" id="button" value="Search by Ingredient" />
                            </form>

                            <form onSubmit={this.handleNameSubmit}>
                                <label>
                                    <input type="text" id="inbox" defaultValue={this.state.recipename} onChange={this.handleNameChange}/>
                                </label>
                                <br/>
                                <td/> <input type="submit" id="button" value="Search by Recipe" />
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

