using Genie.Router
using InflationObservatory.WelcomesController
#route("/") do
#serve_static_file("welcome.html")
#end
route("/", WelcomesController.welcome)
