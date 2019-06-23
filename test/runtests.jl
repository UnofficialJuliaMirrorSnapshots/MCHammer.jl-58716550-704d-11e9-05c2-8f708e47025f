using MCHammer
using Distributions
using Random

if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

@testset "Correlating Values" begin
    Random.seed!(1)
    TestMatrix = rand(Normal(),1000,5)
     test_r = cormat(TestMatrix)
     @test test_r[1,2] == 0.04501199701199701
 end

 @testset "Covariance Values" begin
     Random.seed!(1)
     TestMatrix = rand(Normal(),1000,5)
      test_r = covmat(TestMatrix)
      @test test_r[5,5] == 1.027673689237494
end

@testset "Correlating Distributions" begin
    Random.seed!(1)
    n_trials = 1000
    sample_data = [rand(LogNormal(0, 0.5),n_trials) rand(Normal(3,2),n_trials) rand(Gamma(1, 0.5),n_trials) rand(LogNormal(0, 0.5),n_trials) rand(Normal(3,2),n_trials) rand(Gamma(1, 0.5),n_trials)]

    test_cmatrix = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0;0 0 0 1 0.75 -0.7; 0 0 0 0.75 1 -0.95; 0 0 0 -0.7 -0.95 1 ]

    Random.seed!(1)
    test_r = cormat(corvar(sample_data, n_trials, test_cmatrix))
    @test test_r[3,4] == 0.01943957543957544

end

@testset "GetCertainty" begin
    Random.seed!(1)
    test = rand(Normal(),1000)
    @test GetCertainty(test, 0, 1) == 0.502
end

# @testset "fractiles" begin
#     Random.seed!(1)
#     test = rand(Normal(),1000)
#     @test fractiles(test) == "11×2 Array{Any,2}:
#  "P0.0"    -3.882
#  "P10.0"   -1.34325
#  "P20.0"   -0.860748
#  "P30.0"   -0.526089
#  "P40.0"   -0.274806
#  "P50.0"    0.00474446
#  "P60.0"    0.218685
#  "P70.0"    0.472055
#  "P80.0"    0.800966
#  "P90.0"    1.2504
#  "P100.0"   3.12432"
# end

@testset "truncate" begin
    Result_1 = truncate_digit(0.667)
    Result_2 = truncate_digit(0.661)
    @test  Result_1 == Result_2
end

@testset "GBMM" begin
    Random.seed!(1)
    test_r = GBMM(100000, 0.05,0.05,12)
    @test test_r[12,1] == 195258.14301210243
end


@testset "GBMMfit" begin
    Random.seed!(1)
    historical = rand(Normal(10,2.5),1000)
    test_r = GBMMfit(historical, 12)
    @test test_r[12,1] == 2.1886864479965875

end
