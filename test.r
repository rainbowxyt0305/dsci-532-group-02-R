library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(ggplot2)
library(tidyverse)
library(plotly)

app <- Dash$new()
shades <- read_csv("data/processed/shades_processed.csv")

app$layout(
    htmlDiv(
        className = "ten columns offset-by-half",
        list(
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
                            dccRadioItems(
                                id = 'radio_button_best_selling_brand_by_country',
                                options = list(
                                    list(label = "US", value = "US"),
                                    list(label = "Nigeria", value = "Nigeria"),
                                    list(label = "India", value = "India"),
                                    list(label = "Japan", value = "Japan")
                                ),
                                labelStyle = list(display = 'inline-block'),
                                value = "US"

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
                            dccGraph(id = 'histogram_best_seller_brand_by_country'
                            )
                        ),
                        style = list('marginLeft' = 0)
                    )
                )
            )
        )
    )
)


app$callback(
    output('histogram_best_seller_brand_by_country', 'figure'),
    list(input('radio_button_best_selling_brand_by_country', 'value')),
    function(input_country) {
        p <- ggplot(shades %>% filter(country == input_country),
                    aes(x = Lightness, color = brand)) +
            geom_histogram(bins = 30)
        ggplotly(p, tooltip = 'text')
    }
)

app$run_server(debug = F)