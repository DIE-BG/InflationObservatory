module WelcomesController
using Genie.Renderer.Html
# Build something great
function welcome()
    return html(
        path"app/resources/welcomes/views/welcome.jl.html";
        layout = path"app/layouts/app.jl.html"
    )

end
end
