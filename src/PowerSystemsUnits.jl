__precompile__()
module PowerSystemsUnits

using Unitful
using Unitful: @unit, @derived_dimension, @dimension, @refunit, @u_str
import Unitful: ustrip, uconvert, Quantity, unit, W, hr, J, 𝐋, 𝐌, 𝐓

# Power Units
@derived_dimension PowerHour 𝐋^2*𝐌*𝐓^-2
@unit Wh "Wh" WattHour 3600J true

# Monetary Units
@dimension Money "Money" Currency
@refunit USD "USD" Currency Money false

include("aux.jl")

# Some gymnastics needed to get this to work at run-time.
# Sourced from https://github.com/ajkeller34/UnitfulUS.jl
const localunits = Unitful.basefactors
function __init__()
    merge!(Unitful.basefactors, localunits)
    Unitful.register(PowerSystemsUnits)
end

end
