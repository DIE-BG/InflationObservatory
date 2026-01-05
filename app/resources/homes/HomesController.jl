module HomesController
using Revise
using Genie.Renderer.Html
includet(joinpath(@__DIR__, "services", "SummaryTableService.jl"))
using ..SummaryTableService: summary_table
# Build something great
function home()
    return html(
        path"app/resources/homes/views/home.jl.html";
        layout = path"app/layouts/app.jl.html",
        summary_table = summary_table
    )
end
end # HomesController module
