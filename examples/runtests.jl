using Knet, Base.Test
load_only = true

include("linreg.jl")
#@time @show test1 = linreg()
# 5.849552 seconds (5.34 M allocations: 294.703 MB, 1.52% gc time)
@time @show test1 = linreg()
# 0.718748 seconds (371.98 k allocations: 70.803 MB, 1.21% gc time)
@test test1  == (0.0005497372347062405,32.77256166946498,0.11244349406523031)

include("mnist2d.jl")
#@time @show test2 = mnist2d()
# 9.440711 seconds (7.31 M allocations: 325.879 MB, 1.97% gc time)
@time @show test2 = mnist2d()
# 6.499205 seconds (3.90 M allocations: 167.939 MB, 1.57% gc time)
@test test2  == (0.10628127f0,24.865438f0,3.5134742f0)

#@time @show test3 = mnist2d("--ysparse")
# 8.734357 seconds (4.86 M allocations: 220.274 MB, 2.35% gc time)
@time @show test3 = mnist2d("--ysparse")
# 7.720386 seconds (4.41 M allocations: 214.496 MB, 0.81% gc time)
# 8.057683 seconds (4.18 M allocations: 191.571 MB, 2.38% gc time)
@test test3  == (0.1062698f0,24.866688f0,3.513474f0)

#@time @show test4 = mnist2d("--xsparse")
# 13.243564 seconds (5.11 M allocations: 802.085 MB, 1.82% gc time)
@time @show test4 = mnist2d("--xsparse")
# 12.380252 seconds (4.39 M allocations: 770.236 MB, 1.87% gc time)
@test isapprox(test4[1], 0.10628127f0; rtol=0.005)
@test isapprox(test4[2], 24.865437f0; rtol=0.002)
@test isapprox(test4[3], 3.5134742f0; rtol=0.02)

#@time @show test5 = mnist2d("--xsparse --ysparse")
# 13.590826 seconds (5.14 M allocations: 839.147 MB, 1.24% gc time)
# 14.041564 seconds (4.68 M allocations: 794.398 MB, 2.26% gc time)
@time @show test5 = mnist2d("--xsparse --ysparse")
# 13.390442 seconds (5.01 M allocations: 832.642 MB, 1.24% gc time)
# 13.959991 seconds (4.68 M allocations: 793.600 MB, 2.24% gc time)
@test isapprox(test5[1], 0.10628127f0; rtol=0.005)
@test isapprox(test5[2], 24.865437f0; rtol=0.002)
@test isapprox(test5[3], 3.5134742f0; rtol=0.02)

include("mnist4d.jl")
#@time @show test6 = mnist4d()
# 18.867598 seconds (11.64 M allocations: 549.947 MB, 1.10% gc time)
@time @show test6 = mnist4d()
# 16.554756 seconds (9.08 M allocations: 437.540 MB, 1.07% gc time)
@test isapprox(test6[1], 0.050180204f0; rtol=.01)
@test isapprox(test6[2], 25.783848f0;   rtol=.01)
@test isapprox(test6[3], 9.420588f0;    rtol=.1)

include("mnistpixels.jl")
#@time @show test7 = mnistpixels()
# 10.806832 seconds (45.77 M allocations: 1.209 GB, 3.53% gc time)
@time @show test7 = mnistpixels()
# 8.877034 seconds (43.27 M allocations: 1.099 GB, 4.33% gc time)
# @test test7  == (0.1216,2.3023171f0,10.4108f0,30.598776f0)
# @test test7 == (0.12159999999999982,2.3023171f0,10.4108f0,30.598776f0) # switched to itembased
@test test7 == (0.12159999999999982,2.3023171f0,10.412794f0,30.598776f0) # measuring wnorm after update now

include("adding.jl")
#@time @show test8 = adding()
# 10.177291 seconds (17.07 M allocations: 740.969 MB, 2.08% gc time)
@time @show test8 = adding()
# 9.114330 seconds (16.23 M allocations: 704.629 MB, 1.80% gc time)
# @test test8  == (0.04885713f0, 5.6036315f0,3.805253f0) 
# @test test8  == (0.04885713f0, 5.6057444f0, 3.805253f0) # measuring wnorm after update now
@test test8 == (0.05627571f0,5.484082f0,4.1594324f0) # new generator

include("rnnlm.jl")
#@time @show test9 = rnnlm("ptb.valid.txt ptb.test.txt")
# 32.368835 seconds (22.35 M allocations: 2.210 GB, 1.56% gc time)
# 33.775630 seconds (24.94 M allocations: 2.281 GB, 2.40% gc time)
@time @show test9 = rnnlm("ptb.valid.txt ptb.test.txt")
# 29.791355 seconds (19.68 M allocations: 2.093 GB, 1.57% gc time)
# 30.592042 seconds (21.36 M allocations: 2.133 GB, 2.50% gc time)
@test isapprox(test9[1], 814.9780887272417;  rtol=.0001)
@test isapprox(test9[2], 541.2457922913605;  rtol=.0001)
@test isapprox(test9[3], 267.626257438979;   rtol=.005)
@test isapprox(test9[4], 120.16170771885587; rtol=.0001)
