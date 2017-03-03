/**
 * Created by faisal on 2017-02-28.
 */
import React from 'react';
import {RecipeFeed} from './recipeFeed';

var SearchBox = React.createClass({

    getInitialState () {
      },

    // Event handler for text change
    handleChange (e) {
        // Prevent following the link.
        e.preventDefault();
        this.setState({ ingredient : e.target.value });
    },

    // Event handler for button clicked / enter typed
    handleSubmit(e) {
        // Prevents reinitialization
        e.preventDefault();
        this.props.callback(this.state.ingredient);
    },

    render () {
        return (
            <form onSubmit={this.handleSubmit}>
                <label>
                    <input type="text" defaultValue={this.state.ingredient} onChange={this.handleChange}/>
                </label>
                <input type="submit" value="Get Recipes!" />
            </form>
        );
    }

});

var IngredientSearchComponent = React.createClass({

    getInitialState: function () {
        return {
            ingredient : ''
        }
    },

    // Callback function used by TextBox to update this component's state
    setIngredientState(n){
        this.setState({ ingredient: n });
    },

    // All components must have a render function.
    render(){
        return(
            <div>
                Enter a Recipe's ingredient here:<br/>
                <SearchBox callback={this.setIngredientState}/>
                <br/>
                <RecipeFeed name={this.state.ingredient}/>
            </div>
        );
    }

});

export class IngredientSearch extends React.Component{
    render(){
        return(<IngredientSearchComponent/>);
    }
}
