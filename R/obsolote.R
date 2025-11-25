# data-cleaning-subtheme_var1
trimis <- trimis |> 
    tibble::rowid_to_column("id") |>
    select(-subtheme) |> 
    left_join(
        trimis |>
            tibble::rowid_to_column("id") |>
            select(id, subtheme) |>
            mutate(subtheme = stringr::str_replace(subtheme, " / ", "/")) |>
            tidyr::separate_wider_delim(subtheme,
                                        names_sep = "_",
                                        delim = "/",
                                        too_few = "align_start") |>
            tidyr::pivot_longer(-c(id), names_to = "subthemes", values_to = "theme") |>
            filter(!is.na(theme)) |>
            select(-subthemes) |>
            arrange(theme) |>
            group_by(id) |>
            mutate(order = paste("subtheme", row_number(), sep = "_")) |>
            ungroup() |>
            tidyr::pivot_wider(names_from = "order", values_from = "theme")  |>
            tidyr::unite("subtheme",
                         subtheme_1:subtheme_3,
                         na.rm = TRUE,
                         sep = "/"),
        by = "id")


# data-cleaning-subtheme_var2
trimis <- trimis |> 
    tibble::rowid_to_column("id") |>
    left_join(
        trimis |> 
            tibble::rowid_to_column("id") |>
            select(id, subtheme) |> 
            mutate(subtheme = stringr::str_replace(subtheme, " / ", "/")) |> 
            tidyr::separate_wider_delim(subtheme, 
                                        names_sep = "_", 
                                        delim = "/",
                                        too_few = "align_start") |> 
            select(id, subtheme_1),
        by = "id")