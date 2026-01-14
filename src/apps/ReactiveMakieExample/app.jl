"""
This module defines the basic reactive Makie app for the Inflation Observatory.
"""
module ReactiveMakieExample 

# DrWatson is used for project management.
using DrWatson
@quickactivate :InflationObservatory


# The `model.jl` file contains the reactive logic for this app.
include(joinpath(@__DIR__, "model.jl"))


# The `ui.jl` file defines the layout of the reactive components that will be displayed to the client.
include(joinpath(@__DIR__, "ui.jl"))

end # module ReactiveMakieExample
