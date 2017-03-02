/**
 * Created by faisal on 2017-03-01.
 */
import React from 'react';

var Recipe = React.createClass({

    getInitialState (){
        return {
        }
    },

    render (){
        return (
            <div>
                <b>Ingredient searched: {this.props.ingredient}</b>
                <br/>
                {this.props.recipe}
            </div>
        );
    }

});

export class RecipeFeed extends React.Component {

    constructor() {
        super();
        this.state = {recipes: []};
    }

    fetchFromAPI(ingredient){
        fetch('localhost:8080/search/addIngredient?ingredient='+ingredient).then(response =>{
            if(response.ok){
                fetch('http://localhost:8080/search/search').then(response =>{
                    if(response.ok){
                        response.json().then(json =>{
                            let results = [];
                            for (let i = 0; i < json.length; i++){
                                fetch('http://localhost:8080/recipe/wholerecipe?recipeid='+json[i].statusText).then(response =>{
                                    if(response.ok){
                                        response.json().then(json =>{
                                            let details = [];
                                            for (let i = 0; i < json.length; i++){
                                                if(i == 0){
                                                    details.push(<div><Detail ingredient={ingredient} detail={json[i].statusText}/><br/></div>);
                                                } if(i == 1){
                                                    details.push(<div><Detail ingredient={ingredient} detail={json[i].statusText}/><br/></div>);
                                                } if (i == 3){
                                                    details.push(<div><img src={json[i].statusText}/><br/></div>);
                                                } if(i >= 4){
                                                    details.push(<div><Detail ingredient={ingredient} detail={json[i].statusText}/><br/></div>);
                                                }
                                            }
                                            this.setState({results: this.state.append(concat(details))});
                                        });
                                    }
                                });
                            }
                            this.setState({recipes: results});
                        });
                    }
                });
            }
            else{
                // If response is NOT OKAY (e.g. 404), clear the recipes.
                this.setState({recipes: []});
            }
        });
    }

    componentDidMount(){
        let ingredient = this.props.ingredient;
        this.fetchFromAPI(ingredient);
    }

    componentWillReceiveProps(nextProps){
        let ingredient = nextProps.ingredient;
        this.fetchFromAPI(ingredient);
    }

    render(){
        return(
            <div>
                {this.state.recipes}
            </div>
        );
    }

}