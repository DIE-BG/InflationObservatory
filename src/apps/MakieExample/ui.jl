# Define the UI layout for the Makie example app.
# This layout displays two Makie plots and a button.
UI::ParsedHTMLString = row(
    cell(
        class = "st-module",
        style = "height: 80vh; width: 100%",
        column(
            class = "full-height",
            [
                # Title and first Makie plot
                h4(col = "auto", "MakiePlot 1"),
                cell(class = "full-width", makie_figure(:fig1)),

                # Title and second Makie plot
                h4(col = "auto", "MakiePlot 2"),
                cell(class = "full-width", makie_figure(:fig2)),

                # Example button
                btn(col = "auto", "Hello", class = "q-mt-lg", @click(:hello), color = "primary")
            ]
        )
    )
)

# Return the UI layout
ui() = UI