/**
 * Created by faisal on 2017-03-01.
 */
import React from 'react';

var Recipe = React.createClass({
    getInitialState () {
        return {
        }
    },
    render () {
        return (
            <div>
                <b>{this.props.name}</b>
                <br/>
                {this.props.image}
                {this.props.ingredients}
                {this.props.instructions}
            </div>
        );
    }
});

export class RecipeFeed extends React.Component {

    constructor() {
        super();
        this.state = {recipes: []};
        this.state = {names: []};
        this.state = {images: []};
        this.state = {ingredients: []};
        this.state = {instructions: []};
    }

    fetchFromAPI(name){

    }

    fetchFromAPI(ingredient){

    }

    render() {
        return(
            <div>
                {this.state.recipes}
            </div>
        );
    }
}