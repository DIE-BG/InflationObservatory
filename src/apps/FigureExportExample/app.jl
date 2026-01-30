"""
This module sets up the Makie example app for the Inflation Observatory project.
It loads the reactive model and UI components for the app.
"""
module FigureExportExample

using DrWatson
@quickactivate :InflationObservatory


# Load the reactive model for the Makie example app.
include(srcdir("apps", "FigureExportExample", "model.jl"))

# in this example, we want to define an html file with embedded Julia code.
# Load the UI from the HTML in order to leverage from the processing
# of the .jl.html files by Genie.
ui() = ParsedHTMLString(
    Genie.Renderer.Html.template(
        srcdir("apps", "FigureExportExample", "ui.jl.html");
        context = @__MODULE__
    )
)

end # module FigureExportExample
