module InflationObservatory
using Genie

const up = Genie.up
export up

function main()
    return Genie.genie(; context = @__MODULE__)
end

end
