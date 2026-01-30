"""
    InflationObservatory

The `InflationObservatory` module provides core packages and helper functions
used across all applications in the Inflation Observatory project.
"""
module InflationObservatory

using Reexport
@reexport using GenieFramework
@reexport using HTTP
@reexport using StippleMakie

export BG_LAYOUT
# Export the BG layout for use in all applications.
include(joinpath(@__DIR__, "ui", "layouts", "bg.jl"))

export route_bonito_app
"""
    route_bonito_app(r::AbstractString, reactive_model, ui::Union{Function, AbstractString}; context = @__MODULE__, layout = BG_LAYOUT)

Create a Genie route for a Bonito app using StippleMakie.

# Arguments
- `r::AbstractString`: The route path as a string.
- `reactive_model`: The reactive model, typically defined using the `@app` macro from Stipple.
- `ui::Union{Function, AbstractString}`: The UI definition, either as a function returning HTML or as a string specifying the HTML file.

# Keyword Arguments
- `context`: The module context for the app (default: current module).
- `layout`: The layout to use for the app (default: `BG_LAYOUT`).

# Returns
- A Genie route handler for the specified Bonito app.
"""
function route_bonito_app(
        r::AbstractString,
        reactive_model,
        ui::Union{Function, AbstractString};
        context = @__MODULE__,
        layout = BG_LAYOUT
    )
    return route(r) do
        WGLMakie.Page()
        global model = @init reactive_model 
        html!(
            ui,
            layout = layout(head_content = [makie_dom(model)]),
            model = model, context = context
        )
    end
end

end # module InflationObservatory
