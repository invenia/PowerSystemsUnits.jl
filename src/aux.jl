import Base: round, mean, *, convert

using Missings
using Base.Dates

export round, mean, asqtype, ustrip, fustrip

"""
    round(x::AbstractArray{<:Unitful.Quantity}, r::Int)
    round{T<:Unitful.Quantity}(x::T, r::Int)

Extends the round operation to work with Arrays of Uniful quantities.
"""
round(x::AbstractArray{<:Quantity}, r::Int) = round(ustrip(x), r) * unit(eltype(x))
round{T<:Quantity}(x::T, r::Int) = round(ustrip(x), r) * unit(x)

"""
    mean(x::AbstractArray{<:Unitful.Quantity}, r::Int) = mean(ustrip(x), r) * unit(eltype(x))

Extends the mean operation to work with Uniful quantities.
"""
mean(x::AbstractArray{<:Quantity}, r::Int) = mean(ustrip(x), r) * unit(eltype(x))

"""
    asqtype{T<:Unitful.Units}(x::T) = typeof(1.0*x)

A helper function to convert from the "dimensions" of a Unitful quantity to the "quantities",
as they are treated separately.

"""
asqtype{T<:Unitful.Units}(x::T) = typeof(1.0*x)
#ustrip{T<:Unitful.Quantity}(x::DataArrays.DataArray{T}) = map(t -> ustrip(t), x)

"""

    ustrip(x::Missings.Missing) = x

Extends the unitful ustrip function to work with Missings.Missings

"""
ustrip(x::Missings.Missing) = x

"""
    fustrip{T<:Any}(x::Array{T}) = map(t -> ustrip(t), x)

Operation to strip the units an Parametric Array{T} Type. Needed for operating on DataFrames?

"""
fustrip{T<:Any}(x::Array{T}) = map(t -> ustrip(t), x)

*(x::Unitful.Units, y::Number) = *(y, x)

# Handle working with `Period`s
*(x::Unitful.Units, y::Period) = *(y, x)
*(x::Period, y::Unitful.Units) = convert(y, x)
function convert(a::Unitful.Units, x::Period)
    sec = Dates.value(Dates.Second(x))
    uconvert(a, (sec)u"s")
end

#@dimension USD "USD" Dollar
#@refunit 💵 "💵" Dollar USD false

# Exist to test that (offsets)u"hr" should work the same way
dt2umin(t::AbstractArray{Dates.Minute}) = Dates.value.(t).*u"minute"
