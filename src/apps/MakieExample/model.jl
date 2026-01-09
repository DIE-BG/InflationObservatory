# In this file we define the reactive model for the Landing app, meaning,
# all the `@in`, `@out`, and other reactive constructs used in the app.
@app MakieDemo begin
    @out fig1 = MakieFigure()
    @out fig2 = MakieFigure()
    @in hello = false

    @onbutton hello @notify "Hello World!"

    @onchange isready begin
        init_makiefigures(__model__)
        # the viewport changes when the figure is ready to be written to
        onready(fig1) do
            Makie.scatter(fig1.fig[1, 1], (0:4).^3)
            Makie.heatmap(fig2.fig[1, 1], rand(5, 5))
            Makie.scatter(fig2.fig[1, 2], (0:4).^3)
        end
    end
end