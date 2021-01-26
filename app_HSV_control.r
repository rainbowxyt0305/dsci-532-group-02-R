library(plotly)
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

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
                            htmlH1(id = "match_1"),
                            htmlP(id = "match_1_color"),
                            htmlP(id = "match_1_text")
                        )
                    ),
                    htmlDiv(
                        className = "two columns offset-by-half",
                        list(
                            htmlH1(id = "match_2"),
                            htmlP(id = "match_2_color"),
                            htmlP(id = "match_2_text")
                        )
                    ),
                    htmlDiv(
                        className = "two columns offset-by-half",
                        list(
                            htmlH1(id = "match_3"),
                            htmlP(id = "match_3_color"),
                            htmlP(id = "match_3_text")
                        )
                    ),
                    htmlDiv(
                        className = "two columns offset-by-half",
                        list(
                            htmlH1(id = "match_4"),
                            htmlP(id = "match_4_color"),
                            htmlP(id = "match_4_text")
                        )
                    ),
                    htmlDiv(
                        className = "two columns offset-by-half",
                        list(
                            htmlH1(id = "match_5"),
                            htmlP(id = "match_5_color"),
                            htmlP(id = "match_5_text")
                        )
                    )                                       
                )
            )
        )
    )
)

app$run_server(debug = T)