## Milestone 3 Reflection: Foundation Shades Across the Globe

### 1. What we have implemented

We have implemented all 3 sections outlined in our Milestone 1 proposal, which included:

1. `Best Seller Shades by Country` histogram;

2. `Best Selling Brands by Country` histogram;

3. `Finding the Top 5 Similar Foundations by HSV` section, with the top 5 matching results displayed in the same color as the foundation shades by Hue, Saturation, and Value/Brightness (HSV).

### 2. What we decided not to implement

We decided not to include the `country` filter under our `Finding the Top 5 Similar Foundations by HSV` section because:

* it could cause problems when there aren't many matching results, as some countries might not have that many matching shades of foundation, due to the nature of our rather small dataset;

* it could also cause problems when users don't select any country in the `country` filter. 

### 3. Our experience of implementing the dashboard a second time in R

Implementing dashboard in R is definitely not the same as implementing in python. In addition to the regular differences in R syntax when it comes to writing functions, creating plots, there are some dash specific nuances related to R. For example,

* dash instance initialization looks slightly different:
  
  * Python: `app = dash.Dash()` vs. R: `app <- Dash$new()`;

* instead of `.`, R sometimes uses `$` and sometimes just omits the `.`:
  
  * Python: `app.layout = ...` vs. R: `app$layout(...)`;
  
  * Python: `html.Div` vs. R: `htmlDiv`;
  
* `app$layout` is a function in R where as `app.layout` is a variable in Python;

* instead of `[]`, R uses `list()`;

* instead of `dictionaries`, R uses `named lists`;

* instead of `@app.callback()`, R uses `app$callback()`.

It has definitely been a learning experience for us to try to switch the dashboard coding style in the R way.

### 4. Reflection on some feedback we received and how it has impacted our dashboard

A piece of feedback we received from Joel was to tweak the stylistic layout of our histograms, so that it is more aesthetic appealing to the eyes and less color-clustered. After carefully discussing this suggestion among the team, and assessing whether this change would align with our strategic goal of our dashboard, we implemented the change! The change in the color layout and the design of our histograms has been reflected on our current Milestone 3 dashboard app.    

