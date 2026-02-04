module TotalInflation

using DrWatson
@quickactivate :InflationObservatory


include(srcdir("apps", "TotalInflation", "model.jl"))

ui() = ParsedHTMLString(
    Genie.Renderer.Html.template(
        srcdir("apps", "TotalInflation", "ui.jl.html");
        context = @__MODULE__
    )
)

end # module TotalInflation