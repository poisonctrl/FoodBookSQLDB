<!doctype html>
<html>

<head>
    <title>FOODBOOK</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.13.3/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.13.3/JSXTransformer.js"></script>
</head>

<body>

<div id="content"></div>
<div id="recipeFeed"></div>

<script type="text/jsx">

    var Title = React.createClass({

        render() {
            return(
                    <h1 id="title" className="title">FOODBOOK</h1>
            );
        }

    });

    React.render(<Title />, document.getElementById('content'));

    var RecipeFeed = React.createClass({

        getInitialState() {
            return {recipes: []};
        },

        fetchByNameFromAPI(recipeName){
            fetch('http://localhost:8080/search/recnamesearch?recname=' + recipeName)
                .then(response => {
                    if(response.ok) {
                        response.json().then(json => {
                            let results = [];
                            for (let i = 0; i < json.length; i++) {
                                results.push(<div>{json[i]}</div>);
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

        fetchByIngredientFromAPI(ingredient){
            fetch('http://localhost:8080/search/search?ingredient=' + ingredient)
                .then(response => {
                    if(response.ok) {
                        response.json().then(json => {
                            let results = [];
                            for (let i = 0; i < json.length; i++) {
                                results.push(<div>{json[i]}</div>);
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

        render() {
            return(
                    <div className="recipeFeedContainer">
                        <div className="searchByName">Choose Name:</div>
                        <button onClick={this.fetchByNameFromAPI.bind(this,"Five")} className="buttonFiveStar">Five Star Chicken</button>
                        <button onClick={this.fetchByNameFromAPI.bind(this,"Four")} className="buttonFourStar">Four Star Chicken</button>
                        <button onClick={this.fetchByNameFromAPI.bind(this,"Three")} className="buttonThreeStar">Three Star Chicken</button>
                        <button onClick={this.fetchByNameFromAPI.bind(this,"Two")} className="buttonTwoStar">Two Star Chicken</button>
                        <button onClick={this.fetchByNameFromAPI.bind(this,"One")} className="buttonOneStar">One Star Chicken</button>
                        <div className="searchByIngredient">Choose Ingredient:</div>
                        <button onClick={this.fetchByIngredientFromAPI.bind(this,"Raw")} className="buttonRawChicken">Raw Chicken</button>
                        <button onClick={this.fetchByIngredientFromAPI.bind(this,"Seasoning")} className="buttonSeasoning">Seasoning</button>
                        <button onClick={this.fetchByIngredientFromAPI.bind(this,"Love")} className="buttonLove">Love</button>
                        <div>
                            {this.state.recipes}
                        </div>
                    </div>
            );
        }

    });

    React.render(<RecipeFeed />, document.getElementById('recipeFeed'));

</script>

</body>

