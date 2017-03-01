/**
 * Created by faisal on 2017-03-01.
 */
import React from 'react';
import ReactDOM from 'react-dom';
import { NameSearch } from './nameSearch';
import { IngredientSearch } from './ingredientSearch';

ReactDOM.render(
    <div>
        <NameSearch/>
        <br/>
        <IngredientSearch/>
    </div>, document.getElementById('recipeFeed')
);
