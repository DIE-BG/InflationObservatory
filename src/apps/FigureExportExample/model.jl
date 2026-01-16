# We start this example by loading the necessary packages and data.
# Our goal is to create a reactive Makie figure to display the year-on-year inflation
# rate in Guatemala. We include a slider to select the date range and a
# data inspector to show values on hover.

using Mudie
using DataFramesMeta
using InflationFunctions
using CPIDataGT
using CairoMakie
using Dates, Random

# First, we load the CPI data for Guatemala and compute the year-on-year inflation rate.
CPIDataGT.load_data()

inflfn = InflationTotalCPI()
ts_df = DataFrame(
    date = infl_dates(GTDATA24),
    infl = inflfn(GTDATA24),
)
ts_df.x = datetime2rata.(ts_df.date)

const DOWNLOAD_STATE = Dict{String, Tuple{Date,Date}}()
const DOWNLOAD_LOCK  = ReentrantLock()

# In the reactive model, we expose the Makie figure that will hold the plot
# using `MakieFigure()`. Because this struct is mutable, we place our
# reactive WGLMakie figure in `fig1.fig` directly when the figure is ready.
"""
    example_plot!(mf::MakieFigure)

Create the example plot in the given MakieFigure.

# Arguments
- `mf::MakieFigure`: The MakieFigure to populate with the plot.
# Returns
- The updated MakieFigure.
"""
function example_plot!(mf::MakieFigure, token::String)
    # Notice that we place our axis and components directly in the
    # figure's grid layout `mf.fig`. Since the figure is already
    # reactive, we simply populate it with the desired components.
    ax = Makie.Axis(mf.fig[1, 1], title = "Inflatión total de Guatemala")
    l = tslines!(ax, ts_df.date, ts_df.infl)
    # The slider is also placed directly in the figure's layout.
    rs_h = WGLMakie.IntervalSlider(
        mf.fig[2, 1],
        range = ts_df.date,
        startvalues = (ts_df.date[1], ts_df.date[end])
    )
    # We control the reactivity of the slider by lifting its interval property.
    # The function `lift` creates a reactive binding that updates whenever
    # the underlying property changes.
    labeltext1 = WGLMakie.lift(rs_h.interval) do dates
        "$(dates[1]) to $(dates[2])"
    end

    # Update the download state when the interval changes
    WGLMakie.lift(rs_h.interval) do dates
        Makie.xlims!(ax, datetime2rata.(dates)...)

        lock(DOWNLOAD_LOCK) do
            DOWNLOAD_STATE[token] = (dates[1], dates[2])
        end
    end

    # We also place the reactive label in the layout.
    Makie.Label(mf.fig[3, 1], labeltext1, tellwidth = false)
    # Finally, we add a data inspector to the axis to show data values on hover.
    WGLMakie.DataInspector(ax)
    # Return the updated MakieFigure.
    return mf
end

# Function to create the png bytes for export
# We need to create a separate function because the WGLMakie figure 
# is not directly exportable.
"""
    export_fig_png_bytes!(d1::Date, d2::Date)

Create a statick plot to export.

# Arguments
- `d1::Date`: start date.
- `d2::Date`: end date.
# Returns
- The path of the figure that we might export.
"""
function export_fig_png_bytes(d1::Date, d2::Date)
    die_theme

    df = @subset(ts_df, :date .>= d1, :date .<= d2)

    fig = Figure(size = (1200, 650))
    ax = Axis(fig[1, 1], title = "Inflación Total Interanual")
    tslines!(ax, df.date, df.infl)

    # save to a temporary path
    path = tempname() * ".png"
    CairoMakie.save(path, fig)

    # return the path
    return read(path)
end

# Now we need to define the reactive model for this app.
@app reactive_model begin
    # We create the Makie figure with the `die_theme` applied. We do it
    # this way because setting the theme globally with `Makie.set_theme!`
    # does not persist across sessions in the Bonito app and breaks the
    # complete set of Bonito apps on the website.
    @out fig1 = Makie.with_theme(die_theme) do
        MakieFigure()
    end

    # Unique token to identify the download state
    @private dl_token = randstring(20)

    # URL for downloading the exported figure
    @out dl_url = ""

    # As stated in the `Stipple.jl` documentation, we can only modify reactive variables
    # inside handler blocks.
    @onchange isready begin
        init_makiefigures(__model__)
        dl_url = "/download/fig1?token=$(dl_token)"

        # Initialize the download state
        lock(DOWNLOAD_LOCK) do
            DOWNLOAD_STATE[dl_token] = (ts_df.date[1], ts_df.date[end])
        end

        # The viewport changes when the figure is ready to be written to.
        onready(fig1) do
            example_plot!(fig1, dl_token)
        end
    end
end
