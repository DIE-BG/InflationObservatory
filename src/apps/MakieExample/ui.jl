UI::ParsedHTMLString = row(cell(class = "st-module", style = "height: 80vh; width: 100%", column(class = "full-height", [
    h4(col = "auto", "MakiePlot 1")
    cell(class = "full-width", makie_figure(:fig1))

    h4(col = "auto", "MakiePlot 2")
    cell(class = "full-width", makie_figure(:fig2))

    btn(col = "auto", "Hello", class = "q-mt-lg", @click(:hello), color = "primary")
])))