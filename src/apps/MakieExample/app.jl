"""
This module defines the basic Makie reactive app for the Inflation Observatory.
"""
module MakieExample

# We use DrWatson for project management.
using DrWatson
@quickactivate :InflationObservatory

# We have to load the GenieFramework with `@genietools` to use its web functionalities.
using GenieFramework
@genietools

using StippleMakie
Stipple.enable_model_storage(false)

# We include the background layout for this app.
include(srcdir("ui", "layouts", "bg.jl"))
# ------------------------------------------------------------------------------------------------

# WGLMakie uses a separate server to serve the websocket connections for the figures.
# If you are serving your Genie app to external users, you might need to set this port explicitly.
# configure_makie_server!(listen_port = 8001)

# If you have only one port available, you can use the built-in proxy server to serve both the Genie app and the WGLMakie server
# on the same port. The proxy server will forward requests to the appropriate backend based on the URL path.
# The proxy server will listen on port 8080 by default. You can change this by providing the `port` argument.

# In order to use a proxy server, Makie needs to be configured to use a proxy URL.
# When using an external proxy, you have to set a valid proxy URL.
# If you are using the built-in proxy server, `start_proxy()` autmatically sets "/_makie_" as the proxy URL.
# You can change this by providing the `proxy_url` argument.

# Example settings for a pmanual proxy configuration:
# proxy_host and proxy_port will be taken from the Genie configuration.
# configure_makie_server!(proxy_url = "/_makie_")
# configure_makie_server!(listen_port = 8001, proxy_url = "/makie")
# configure_makie_server!(listen_port = 8001, proxy_url = "/makie", proxy_port = 8081)

# start the proxy server (if required)
startproxy()
# startproxy(8080)

# the `model.jl` file contains the reactive logic for this app.
include(joinpath(@__DIR__, "model.jl"))

# in this case we are defining the UI in a julia script, using the clases
# provided by Stipple and StippleMakie.
include(joinpath(@__DIR__, "ui.jl"))
ui() = UI

"""
    main(r::AbstractString)

The main function for the Landing app.

This is the function that later we call from `/app.jl` to render the landing page
in the correct route. We don't define the route here because we prefer to keep all route
definitions in a single file.
"""
function main(r::AbstractString)
    return route(r) do
        WGLMakie.Page()
        global model = @init MakieDemo
        html!(ui, layout = BG_LAYOUT(head_content = [makie_dom(model)]), model = model, context = @__MODULE__)
    end
end
end # module Landing
