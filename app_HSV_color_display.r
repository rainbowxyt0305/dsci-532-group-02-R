library(plotly)
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(colorspace)

# read csv
shades <- read_csv("data/processed/shades_processed.csv")

app <- Dash$new()

app$layout(
    htmlDiv(
        className = "ten columns offset-by-half",
        list(
            # row 1: app title and app description
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
            # row 2: 2 titles and control side by side
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
            # row 3: 2 histograms side by side
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
            ),
            # row 4: 1 title on `Finding the Top 5 Similar Foundations by HSV`
            htmlDiv(
                className = "row",
                list(
                    htmlH5('Finding the Top 5 Similar Foundations by HSV:',
                            className = "six columns"
                    )
                )
            ),
            # row 5: 3 titles and 3 sliders control underneath
            htmlDiv(
                className = "row",
                list(
                    htmlDiv(
                        className = "three columns",
                        list(
                            htmlH6("Hue (Color Spectrum)"),
                            dccSlider(
                                id = "slider_hue",
                                min = 0,
                                max = 50,
                                step = 1,
                                value = 29,
                                marks = list(
                                    "0" = "0\u00b0",
                                    "10" = "10\u00b0",
                                    "20" = "20\u00b0",
                                    "30" = "30\u00b0",
                                    "40" = "40\u00b0",
                                    "50" = "50\u00b0"
                                )
                            )
                        )
                    ),
                    htmlDiv(
                        className = "three columns",
                        list(
                            htmlH6("Saturation (Color Intensity)"),
                            dccSlider(
                                id = "slider_saturation",
                                min = 0,
                                max = 100,
                                step = 1,
                                value = 53,
                                marks = list(
                                    "0" = '0%',
                                    "20" = '20%',
                                    "40" = '40%',
                                    "60" = '60%',
                                    "80" = '80%',
                                    "100" = '100%'
                                )
                            )
                        )
                    ),
                    htmlDiv(
                        className = "three columns",
                        list(
                            htmlH6("Value (Color Brightness)"),
                            dccSlider(
                                id = "slider_value_brightness",
                                min = 20,
                                max = 100,
                                step = 1,
                                value = 70,
                                marks = list(
                                    "20" = '20%',
                                    "60" = '60%',
                                    "100" = '100%'
                                )
                            )
                        )
                    )
                )
            ),
            # row 6: Selected HSV value and 1 subtitle on `Most Matching Results from Best Selling Foundation Lists`
            htmlDiv(
                className = "row",
                list(
                    htmlDiv(
                        className = "six columns",
                        list(
                            htmlP(id = "HSV_user_choice_output"),
                            htmlDiv(id = "user_selected_color_div"),
                            htmlH6("Most Matching Results from Best Selling Foundation Lists:")
                        )
                    )
                )
            ),
            # row 7: 5 top similar products
            htmlBr(),
            htmlDiv(
                className = "row",
                list(
                    htmlDiv(
                        className = "two columns",
                        list(
                            htmlH1(id = "match_1", className="round-square",
                                   style = list('background-color' = "blue")),
                            htmlP(id = "match_1_color"),
                            htmlP(id = "match_1_text")
                        )
                    ),
                    htmlDiv(
                        className = "round-square two columns offset-by-half ",
                        list(
                            htmlH1(id = "match_2", className="round-square",
                                   style = list('background-color' = "purple")),
                            htmlP(id = "match_2_color"),
                            htmlP(id = "match_2_text")
                        )
                    ),
                    htmlDiv(
                        className = "round-square two columns offset-by-half",
                        list(
                            htmlH1(id = "match_3", className="round-square",
                                   style = list('background-color' = "yellow")),
                            htmlP(id = "match_3_color"),
                            htmlP(id = "match_3_text")
                        )
                    ),
                    htmlDiv(
                        className = "round-square two columns offset-by-half",
                        list(
                            htmlH1(id = "match_4", className="round-square",
                                   style = list('background-color' = "green")),
                            htmlP(id = "match_4_color"),
                            htmlP(id = "match_4_text")
                        )
                    ),
                    htmlDiv(
                        className = "round-square two columns offset-by-half",
                        list(
                            htmlH1(id = "match_5", className="round-square",
                                   style = list('background-color' = "red")),
                            htmlP(id = "match_5_color"),
                            htmlP(id = "match_5_text")
                        )
                    )
                )
            )
        )
    )
)

# display user color choice as HEX color
app$callback(
    list(output('HSV_user_choice_output', 'children'),
         output('user_selected_color_div', 'style')),
    list(input('slider_hue', 'value'),
         input('slider_saturation', 'value'),
         input('slider_value_brightness', 'value')),
    function(H, S, V) {
        selected_color <- hex(HSV(H, S/100, V/100))
        return(
            list(
                paste0("You selected HSV value of H:",
                       H, ", S: ", S, ", and V: ", V, " (Hex code: ",
                       selected_color, ")"),
                list("background-color" = selected_color,
                     "height" = "50px",
                     "width" = "100px")
            )
        )
    }
)

# function to calculate euclidean distance between 2 points
get_distance <- function(p1, p2) sqrt(sum((p1 - p2) ^ 2))

# display the top 5 similar color based on 3D euclidean distance
app$callback(
    list(output('match_1', 'style'),
         output('match_2', 'style'),
         output('match_3', 'style'),
         output('match_4', 'style'),
         output('match_5', 'style')),
    list(input('slider_hue', 'value'),
         input('slider_saturation', 'value'),
         input('slider_value_brightness', 'value')),
    function(H, S, V) {
        selected_color <- c(H, S, V)
        row_index <- order(apply(shades[4:6], 1, get_distance, selected_color))[1:5]
        most_similar_hex_colors <- shades[row_index, "hex"]
        return(
            list(
                list("background-color" = most_similar_hex_colors$hex[1]),
                list("background-color" = most_similar_hex_colors$hex[2]),
                list("background-color" = most_similar_hex_colors$hex[3]),
                list("background-color" = most_similar_hex_colors$hex[4]),
                list("background-color" = most_similar_hex_colors$hex[5])
            )
        )
    }
)

app$run_server()