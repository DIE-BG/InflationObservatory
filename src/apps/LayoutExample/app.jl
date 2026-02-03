module LayoutExample

using DrWatson
@quickactivate :InflationObservatory


include(srcdir("apps", "LayoutExample", "model.jl"))

ui() = ParsedHTMLString(
    Genie.Renderer.Html.template(
        srcdir("apps", "LayoutExample", "ui.jl.html");
        context = @__MODULE__
    )
)

end # module LayoutExample
