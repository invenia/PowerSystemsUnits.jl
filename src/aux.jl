import Base: round, mean, *, convert

using Missings
using Base.Dates

export round, mean, asqtype, ustrip, fustrip

round(x::AbstractArray{<:Quantity}, r::Int) = round(ustrip(x), r) * unit(eltype(x))
round{T<:Quantity}(x::T, r::Int) = round(ustrip(x), r) * unit(x)
mean(x::AbstractArray{<:Quantity}, r::Int) = mean(ustrip(x), r) * unit(eltype(x))
asqtype{T<:Unitful.Units}(x::T) = typeof(1.0*x)
#ustrip{T<:Unitful.Quantity}(x::DataArrays.DataArray{T}) = map(t -> ustrip(t), x)
ustrip(x::Missings.Missing) = x
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
