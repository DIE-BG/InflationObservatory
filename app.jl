# This file defines the entry point for the Genie web application.



using DrWatson
@quickactivate :InflationObservatory
@genietools


# Our set of applications is a mix of Genie and StippleMakie apps. StippleMakie is used to create reactive Makie visualizations that are served through Genie.
# Since Makie requires its own server for Bonito apps, we use a reverse proxy to serve both Genie and Makie apps on the same port. This functionality is provided by StippleMakie.
startproxy()

# Because our reactive models can be large, we disable model storage to improve performance.
Stipple.enable_model_storage(false)



# The landing page app is defined here. It also serves as an example of how to structure additional apps.
include(srcdir("apps", "Landing", "app.jl"))
Landing.main("/")


# This app is the main Makie example, adapted to our project organization structure.
include(srcdir("apps", "MakieExample", "app.jl"))
route_bonito_app(
    "/makie_example",
    MakieExample.reactive_model,
    MakieExample.ui
)


# In this example, we go a step further and make the Makie figure reactive.
# We also show how to apply the `die_theme` from `Mudie.jl` to the reactive figure.
include(srcdir("apps", "ReactiveMakieExample", "app.jl"))
route_bonito_app(
    "/reactive_makie_example",
    ReactiveMakieExample.reactive_model,
    ReactiveMakieExample.ui
)


# In this example, we go a step further exporting a reactive makie figure.
include(srcdir("apps", "FigureExportExample", "app.jl"))
route_bonito_app(
    "/figure_export_example",
    FigureExportExample.reactive_model,
    FigureExportExample.ui
)


# This is the base layout for all our apps.
include(srcdir("apps", "LayoutExample", "app.jl"))
route_bonito_app(
    "/layout_example",
    LayoutExample.reactive_model,
    LayoutExample.ui
)