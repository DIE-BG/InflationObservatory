"""
This module defines the Landing page of the Inflation Observatory web application.
"""
module Landing

# We use DrWatson for project management.
using DrWatson
@quickactivate :InflationObservatory

# We have to load the GenieFramework with `@genietools` to use its web functionalities.
using GenieFramework
@genietools

# We include the background layout for this app.
include(srcdir("ui", "layouts", "bg.jl"))

# the `model.jl` file contains the reactive logic for this app.
include(joinpath(@__DIR__, "model.jl"))

"""
    main(r::AbstractString)

The main function for the Landing app.

This is the function that later we call from `/app.jl` to render the landing page
in the correct route. We don't define the route here because we prefer to keep all route
definitions in a single file.
"""
function main(r::AbstractString)
    @page(
        r,
        srcdir("apps", "Landing", "ui.html");
        core_theme = false,
        layout = BG_LAYOUT(),
    )
end

end # module Landing
