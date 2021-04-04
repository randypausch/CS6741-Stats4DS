### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ f0e7e790-956d-11eb-01d1-8ff0eda34435
begin
	using Plots
	using StatsBase, Statistics, Distributions
end

# ╔═╡ fde78bf8-956d-11eb-073c-93a55c69af24
begin
hist=vcat( [0 for i in 1:1000],[1 for i in 1:1200],[2 for i in 1:1300], [3 for i in 1:1350],
       [4 for i in 1:1400], [5 for i in 1:1500],[6 for i in 1:600],[6 for i in 1:400], [7 for i in 1:200], [8 for i in 1:250],
       [9 for i in 1:150], [10 for i in 1:150], [11 for i in 1:120], [12 for i in 1:90], [13 for i in 1:50], [14 for i in 1:30], [15 for i in 1:15])
 

h = fit(Histogram,hist)
mo = mode(hist)
me = mean(hist)
med = median(hist)
plot!(h,label=false)
plot!([me for t in 1:1600], 1:1600, line=3, color=:black,label="Mean")
plot!([mo for t in 1:1600], 1:1600, line=3, color=:green,label="Mode")
plot!([med for t in 1:1600], 1:1600, line=3, color=:blue,label="Median")
end



# ╔═╡ Cell order:
# ╠═f0e7e790-956d-11eb-01d1-8ff0eda34435
# ╠═fde78bf8-956d-11eb-073c-93a55c69af24
