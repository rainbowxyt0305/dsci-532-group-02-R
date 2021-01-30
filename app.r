library(plotly)
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(colorspace)
library(ggplot2)
library(ggplotly)

app <- Dash$new()

# read csv
shades <- read_csv("data/processed/shades_processed.csv")

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
                )
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
                                    list(label = "US", value = "US"),
                                    list(label = "Nigeria", value = "Nigeria"),
                                    list(label = "India", value = "India"),
                                    list(label = "Japan", value = "Japan")
                                ),
                                value = list("US", "India"),
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
                                id = 'histogram_best_seller_by_country'
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
                            htmlH1(id = "match_1", className="round-square"),
                            htmlP(id = "match_1_color"),
                            htmlP(id = "match_1_text")
                        )
                    ),
                    htmlDiv(
                        className = "round-square two columns offset-by-half ",
                        list(
                            htmlH1(id = "match_2", className="round-square"),
                            htmlP(id = "match_2_color"),
                            htmlP(id = "match_2_text")
                        )
                    ),
                    htmlDiv(
                        className = "round-square two columns offset-by-half",
                        list(
                            htmlH1(id = "match_3", className="round-square"),
                            htmlP(id = "match_3_color"),
                            htmlP(id = "match_3_text")
                        )
                    ),
                    htmlDiv(
                        className = "round-square two columns offset-by-half",
                        list(
                            htmlH1(id = "match_4", className="round-square"),
                            htmlP(id = "match_4_color"),
                            htmlP(id = "match_4_text")
                        )
                    ),
                    htmlDiv(
                        className = "round-square two columns offset-by-half",
                        list(
                            htmlH1(id = "match_5", className="round-square"),
                            htmlP(id = "match_5_color"),
                            htmlP(id = "match_5_text")
                        )
                    )
                )
            )
        )
    )
)

# Histogram Left
app$callback(
    output('histogram_best_seller_by_country', 'figure'),
    list(input('dropdown_best_seller_shades_by_countries', 'value')),
    function(input_country) {
        p <- ggplot(shades %>% filter(country %in% input_country),
                    aes(x = Lightness, color = country)) +
            geom_histogram(fill= NA, bins = 30) +
            xlim(0, 100) +
            theme_bw()
        ggplotly(p, tooltip = 'text')
    }
)

# Histogram Right
app$callback(
  output('histogram_best_seller_brand_by_country', 'figure'),
  list(input('radio_button_best_selling_brand_by_country', 'value')),
  function(input_country) {
    p <- ggplot(shades %>% filter(country == input_country),
                aes(x = Lightness, color = brand)) +
         geom_histogram(bins = 30, fill = NA) +
         xlim(0, 100) +
         theme_bw()

    ggplotly(p, tooltip = 'text')
  }
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
        styles <- map(most_similar_hex_colors$hex, function(data) list("background-color" = data))
        return(styles)
    }
)

# concatenate the results of 2-column dataframe
concat_data <- function(data) paste0(data[1], ", ", data[2])

# display the top 5 similar products' hex and country based on 3D euclidean distance
app$callback(
    list(output('match_1_color', 'children'),
         output('match_2_color', 'children'),
         output('match_3_color', 'children'),
         output('match_4_color', 'children'),
         output('match_5_color', 'children')),
    list(input('slider_hue', 'value'),
         input('slider_saturation', 'value'),
         input('slider_value_brightness', 'value')),
    function(H, S, V) {
        selected_color <- c(H, S, V)
        row_index <- order(apply(shades[4:6], 1, get_distance, selected_color))[1:5]
        most_similar_color_countries <- shades[row_index, c("hex", "country")]
        hex_country_list <- as.list(apply(most_similar_color_countries, 1, concat_data))
        return(hex_country_list)
    }
)

# display the top 5 similar products' brand and product name based on 3D euclidean distance
app$callback(
    list(output('match_1_text', 'children'),
         output('match_2_text', 'children'),
         output('match_3_text', 'children'),
         output('match_4_text', 'children'),
         output('match_5_text', 'children')),
    list(input('slider_hue', 'value'),
         input('slider_saturation', 'value'),
         input('slider_value_brightness', 'value')),
    function(H, S, V) {
        selected_color <- c(H, S, V)
        row_index <- order(apply(shades[4:6], 1, get_distance, selected_color))[1:5]
        most_similar_color_product_info <- shades[row_index, c("brand", "product")]
        product_info_list <- as.list(apply(most_similar_color_product_info, 1, concat_data))
        return(product_info_list)
    }
)

app$run_server()