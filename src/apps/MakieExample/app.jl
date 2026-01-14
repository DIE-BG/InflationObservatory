"""
This module sets up the Makie example app for the Inflation Observatory project.
It loads the reactive model and UI components for the app.
"""
module MakieExample

# DrWatson is used for project management and environment activation.
using DrWatson
@quickactivate :InflationObservatory

# Load the reactive model for the Makie example app.
include(srcdir("apps", "MakieExample", "model.jl"))

# Load the UI layout for the Makie example app.
include(srcdir("apps", "MakieExample", "ui.jl"))

end # module MakieExample