"""
The main module for the Inflation Observatory application.

Each separate app is included from `src/apps/`. Each app exports a `main` function that
receives a route string as input. After including an app, its `main` function is called
with the desired route.
"""
module App

using DrWatson
@quickactivate :InflationObservatory

# In this app we define the landing page. It also serves as an example of how to
# structure additional apps.
include(
    srcdir("apps", "Landing", "app.jl")
)
Landing.main("/")

# This app is the main Makie example adapted to out project organization structure.
include(
    srcdir("apps", "MakieExample", "app.jl")
)
MakieExample.main("/makie_example")

end # module App