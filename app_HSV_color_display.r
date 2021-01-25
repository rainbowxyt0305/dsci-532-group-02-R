library(plotly)
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

app <- Dash$new()

app$layout(
    htmlDiv(
        className = "ten columns offset-by-half",
        list(
            htmlDiv(
                className = "row",
                list(
                    htmlH2('Foundation Shades Across the Globe',
                        className = "nine columns"
                    ),
                    htmlDiv("What is the range and distribution of makeup foundations shades
                        offered by each of the best - selling cosmetics brands across the globe ",
                        className = "ten columns",
                        style = list('marginLeft' = 0)
                    )
                ),
            ),
            htmlDiv(
                className = "row",
                list(
                    htmlDiv(
                        className = "six columns",
                        list(
                            htmlH6('Best Seller Shades by Country:'),
                            dccDropdown(
                                id = 'dropdown_best_seller_shades_by_countries',
                                options = list(
                                    list(label = "New York City", value = "NYC"),
                                    list(label = "San Francisco", value = "SF")
                                ),
                                value = list("SF", "NYC"),
                                multi = TRUE
                            )
                        )
                    ),
                    htmlDiv(
                        className = "six columns",
                        list(
                            htmlH6('Best Selling Brands by Country:'),
                            dccDropdown(
                                id = 'radio_button_best_selling_brand_by_country',
                                options = list(
                                    list(label = "New York City", value = "NYC"),
                                    list(label = "San Francisco", value = "SF")
                                ),
                                value = list("SF", "NYC"),
                                multi = TRUE
                            )
                        )
                    )
                )
            ),
            htmlDiv(
                className = "row",
                list(
                    htmlDiv(
                        className = "six columns",
                        list(
                            dccGraph(
                                id = 'histogram_best_seller_by_country',
                                figure = plot_ly(x = ~rnorm(50), type = "histogram")
                            )
                        ),
                        style = list('marginLeft' = 0)
                    ),
                    htmlDiv(
                        className = "six columns",
                        list(
                            dccGraph(
                                id = 'histogram_best_seller_brand_by_country', 
                                figure = plot_ly(x = ~rnorm(50), type = "histogram")
                            )
                        ),
                        style = list('marginLeft' = 0)
                    )
                )
            )
        )
    )
)

app$run_server(debug = T)