# We start this example by loading the necessary packages and data.
# Our goal is to create a reactive Makie figure to display the year-on-year inflation
# rate in Guatemala. We include a slider to select the date range and a
# data inspector to show values on hover.

using Mudie
using DataFramesMeta
using InflationFunctions
using CPIDataGT

# First, we load the CPI data for Guatemala and compute the year-on-year inflation rate.
CPIDataGT.load_data()

inflfn = InflationTotalCPI()
ts_df = DataFrame(
    date = infl_dates(GTDATA24),
    infl = inflfn(GTDATA24),
)
ts_df.x = datetime2rata.(ts_df.date)

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
function example_plot!(mf::MakieFigure)
    # Notice that we place our axis and components directly in the
    # figure's grid layout `mf.fig`. Since the figure is already
    # reactive, we simply populate it with the desired components.
    ax = Makie.Axis(mf.fig[1, 1])
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
    WGLMakie.lift(rs_h.interval) do dates
        Makie.xlims!(ax, datetime2rata.(dates)...)
    end
    # We also place the reactive label in the layout.
    Makie.Label(mf.fig[3, 1], labeltext1, tellwidth = false)
    # Finally, we add a data inspector to the axis to show data values on hover.
    WGLMakie.DataInspector(ax)
    # Return the updated MakieFigure.
    return mf
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
    # As stated in the `Stipple.jl` documentation, we can only modify reactive variables
    # inside handler blocks.
    @onchange isready begin
        init_makiefigures(__model__)
        # The viewport changes when the figure is ready to be written to.
        onready(fig1) do
            example_plot!(fig1)
        end
    end
end
