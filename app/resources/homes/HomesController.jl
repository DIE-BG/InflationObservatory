module HomesController
using Genie.Renderer.Html
# Build something great
function home()
    return html(
        path"app/resources/homes/views/home.jl.html";
        layout = path"app/layouts/app.jl.html"
    )
end
end
