/**
 * Created by faisal on 2017-02-28.
 */
import React from 'react';
import {RecipeFeed} from './recipeFeed';

var SearchBox = React.createClass({

    getInitialState () {
        return {
            name : ""
        }
    },

    // Event handler for text change
    handleChange (e) {
        // Prevent following the link.
        e.preventDefault();
        this.setState({ name : e.target.value });
    },

    // Event handler for button clicked / enter typed
    handleSubmit(e) {
        // Prevents reinitialization
        e.preventDefault();
        this.props.callback(this.state.name);
    },

    render () {
        return (
            <form onSubmit={this.handleSubmit}>
                <label>
                    <input type="text" defaultValue={this.state.name} onChange={this.handleChange}/>
                </label>
                <input type="submit" value="Get Recipes!" />
            </form>
        );
    }

});

var NameSearchComponent = React.createClass({

    getInitialState: function () {
        return {
            name : ''
        }
    },

    // Callback function used by TextBox to update this component's state
    setNameState(n){
        this.setState({ name: n });
    },

    // All components must have a render function.
    render(){
        return(
            <div>
                Enter a Recipe's name here:<br/>
                <SearchBox callback={this.setNameState}/>
                <br/>
                <RecipeFeed name={this.state.name}/>
            </div>
        );
    }

});

export class NameSearch extends React.Component{
    render(){
        return(<NameSearchComponent/>);
    }
}