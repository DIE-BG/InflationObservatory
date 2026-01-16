"""
This module sets up the Makie example app for the Inflation Observatory project.
It loads the reactive model and UI components for the app.
"""
module FigureExportExample

# DrWatson is used for project management and environment activation.
using DrWatson
@quickactivate :InflationObservatory

using Genie.Router, Genie.Requests
using HTTP

# Load the reactive model for the Makie example app.
include(srcdir("apps", "FigureExportExample", "model.jl"))

# Load the UI layout for the Makie example app.
include(srcdir("apps", "FigureExportExample", "ui.jl"))
ui() = UI

# Define a route to download the exported figure as a PNG file.
route("/download/fig1") do
    token = getpayload(:token, "")  # query param ?token=...
    token == "" && return HTTP.Response(400, "Missing token")

    # Obtain the dates range
    range = lock(DOWNLOAD_LOCK) do
        get(DOWNLOAD_STATE, token, nothing)
    end

    range === nothing && return HTTP.Response(404, "Invalid or expired token")

    # Use the range to create and export the figure
    d1, d2 = range
    bytes = export_fig_png_bytes(d1, d2)

    return HTTP.Response(
        200,
        [
            "Content-Type" => "image/png",
            "Content-Disposition" => "attachment; filename=\"inflacion_total.png\""
        ],
        bytes
    )
end

end # module ExportExample