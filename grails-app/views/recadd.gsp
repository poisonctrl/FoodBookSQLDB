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
<div id="home"></div>
<div id="recipeAddb"></div>


<script type="text/jsx">
    //create standard header for FoodBook
    var Title = React.createClass({

        render() {
            return(<h1 id="title" className="title">FOODBOOK</h1>);
        }
    });
    React.render(<Title />, document.getElementById('content'));

    //create home button
    var Login = React.createClass({
        render() {
            return(
                    <div>
                        <form action="../">
                            <input type="submit" className="button_login" value="Home" />
                        </form>
                    </div>);
        }
    });
    React.render(<Login />, document.getElementById('home'));

    //create recipe add page with 4 input boxes, set states, and fetch post calls (oringially posts but failed so tried just plain fetch call)
    var RecADD = React.createClass({
        getInitialState() {
            return {recipes: [],
                steps : "",
                recipename : ""
            };
        },

        handleStepsChange (e) {
            // Prevent following the link.
            e.preventDefault();
            this.setState({ steps : e.target.value  , success : "..."});
        },

        handleRecNameChange (e) {
            // Prevent following the link.
            e.preventDefault();
            this.setState({ recipeName : e.target.value  , success : "..."});
        },

        handleRecipeSubmit(e) {
            // Prevents reinitialization
            e.preventDefault();
            let steps = this.state.Steps;
            let recipeName = this.state.recipeName;

            fetch('localhost:8080/recipe/addName?name=' + recipeName)
                .then(response => {
                    if(response.ok) {
                    this.setState({queryone: 'Yes!'});
                }
                else{
                    this.setState({queryone: 'No...'});
                }
            })
            fetch('http://localhost:8080/recipe/addSteps?steps=' + steps)
                .then(response => {
                    if(response.ok) {
                        this.setState({querytwo: 'Yes!'});
                    }
                    else{
                        this.setState({querytwo: 'No...'});
                    }
                })
            fetch('http://localhost:8080/recipe/addIngredient?ingredient=fake&qtymeas=1 for sure')
                .then(response => {
                    if(response.ok) {
                        this.setState({querythree: 'Yes!'});
                    }
                    else{
                        this.setState({querythree: 'No...'});
                    }
                })
            fetch('http://localhost:8080/recipe/add')
                .then(response => {
                    if(response.ok) {
                        this.setState({queryfour: 'Yes!'});
                    }
                    else{
                        this.setState({queryfour: 'No...'});
                    }
                })
        },
        //displayed the result of each query
        render() {
            return(
                    <div>
                        <br/>
                        <form onSubmit={this.handleRecipeSubmit}>
                            <label>
                                <input type="text" id="inbox" defaultValue={this.state.recipeName} onChange={this.handleRecNameChange}/>
                                <input type="text" id="inbox" defaultValue={this.state.steps} onChange={this.handleStepsChange}/>
                            </label>
                            <input type="submit" value="Add Recipe" />
                        </form>
                        <br/>
                        Recipe Name Added: {this.state.queryone}
                        <br/>
                        Step Added: {this.state.querytwo}
                        <br/>
                        Ingredients Added: {this.state.querythree}
                        <br/>
                        Overall Recipe Added to Database: {this.state.queryfour}
                    </div>);
        }
    });
    React.render(<RecADD />, document.getElementById('recipeAddb'));

    // ------------------------------Ingredient Feed--------------------------------------------------


</script>

</body>

