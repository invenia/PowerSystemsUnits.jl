using Compat.Dates
using Compat.Test
using PowerSystemsUnits

using Unitful: @u_str


@testset "PowerSystemsUnits.jl" begin
    @testset "Units" begin
        @testset "Period Time Types" begin
            time_stamps = collect(now()-Dates.Day(1):Dates.Hour(1):now())
            offsets = time_stamps - time_stamps[1]

            x = PowerSystemsUnits.dt2umin(Dates.Minute.(offsets))
            y = (offsets)u"minute"
            @test x == y
        end
    end
end
