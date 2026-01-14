# The layout is a mixture of divs and reactive components. For a StippleMakie
# figure, we have the `makie_figure` component that place the figure in the UI.
UI::ParsedHTMLString = row(
    cell(
        class = "st-module", style = "height: 80vh; width: 100%", column(
            class = "full-height", [
                h4(col = "auto", "Inflación Total Interanual")
                cell(class = "full-width", makie_figure(:fig1))
            ]
        )
    )
)
ui() = UI
