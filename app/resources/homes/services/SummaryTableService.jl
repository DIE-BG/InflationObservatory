"""
## SummaryTableService.jl

This module generates a summary table of inflation measures for the two most
recent months and the difference between them.
"""
module SummaryTableService
export summary_table

using CPIDataGT
using InflationFunctions: InflationTotalCPI, InflationWeightedMean, InflationPercentileEq, InflationPercentileWeighted, InflationEnsemble
using Printf
using DataFramesMeta: @chain
# we need to format the dates in Spanish for the table headers, so we use
# Mudie.SPANISH_GT locale and we define a helper function dates_fmt with the
# desired format "U yyyy" (e.g., "Enero 2024")
using Mudie: SPANISH_GT
Dates.LOCALES["spanish"] = SPANISH_GT
dates_fmt(d::Date) = Dates.format.(d, "U yyyy", locale = "spanish")

CPIDataGT.load_data()

# this defines the list of inflation measures that will be included in the
# summary table
ENSEMBLE = InflationEnsemble(
    InflationTotalCPI(),
    InflationWeightedMean(),
    InflationPercentileEq(50),
    InflationPercentileWeighted(50),
)

# we use custom names for each inflation measure in the table
NAMES = [
    "Inflación Total",
    "Media Ponderada",
    "Percentil 50 Equiponderado",
    "Percentil 50 Ponderado",
]

# we need to extract the date for the past and current year-over-year inflation
# and formatting them for the table headers
DATES = @chain GTDATA24 begin
    infl_dates
    _[(end - 1):end]
    dates_fmt.(_)
end

# extract the year-over-year inflation values for the two most recent months
v = @chain GTDATA24 begin
    ENSEMBLE
    _[(end - 1):end, :]
    _'
end
# compute the difference between the two months
v_diff = diff(v, dims = 2)

# construct the summary table as a dictionary with headers and rows
HEADERS = Dict(
    :measures => "",
    :last_yoy => DATES[1],
    :current_yoy => DATES[2],
    :difference => "Diferencia",
)

ROWS = Vector{Dict{Symbol, String}}(undef, size(v, 1))
for i in 1:size(v, 1)
    ROWS[i] = Dict(
        :measures => NAMES[i],
        :last_yoy => @sprintf("%.2f%%", v[i, 1]),
        :current_yoy => @sprintf("%.2f%%", v[i, 2]),
        :difference => @sprintf("%.2f%%", v_diff[i, 1]),
    )
end

# this is the structure that we are going to export
summary_table = Dict(
    :headers => HEADERS,
    :rows => ROWS,
)

end # SummaryTableService module
