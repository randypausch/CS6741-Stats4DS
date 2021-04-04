### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 990bd6cc-9544-11eb-0af4-97f5f5e9ac00
using Distributions

# ╔═╡ 570b8ce2-954c-11eb-3a58-eba395096032
using PyPlot, StatsBase

# ╔═╡ d3b447aa-954e-11eb-39a7-a9cf3fb02f1a
using Plots

# ╔═╡ 01b1f896-9545-11eb-0956-b9c620d1f4f9
uniform_dataset = rand(Uniform(0,1), 10000, 30)
# print(size(uniform_dataset))


# ╔═╡ 439adcd6-9546-11eb-14cb-af70ed2b4ce0
	begin
	ranges = zeros(0)
		for row in 1:size(uniform_dataset, 1)
			current_row=(uniform_dataset[row,:])
			range = (findmax(current_row)[1] - findmin(current_row)[1])
			append!(ranges, range)
		end
	end

# ╔═╡ 1bad06ec-954e-11eb-085f-6dd3583096ed
h = fit(Histogram,ranges,nbins=30)

# ╔═╡ 3bc7ee28-954f-11eb-3d23-1fe0820a398c
plot!(h,label=false)

# ╔═╡ 91764afa-9550-11eb-0b4b-a7fa23fd66a6
mo = mode(ranges)

# ╔═╡ c7d674ba-9550-11eb-1b34-8ba67a1b01e2
me = mean(ranges)

# ╔═╡ 1575c6de-9552-11eb-3917-7bd0e08cbd0b
med = median(ranges)

# ╔═╡ 293e400a-9553-11eb-22bf-fd91ae77ae7f
begin
plot!([me for t in 1:2200], 1:2200, line=3, color=:black,label=false)
plot!([mo for t in 1:2200], 1:2200, line=3, color=:green,label=false)
plot!([med for t in 1:2200], 1:2200, line=3, color=:blue,label=false)
end

# ╔═╡ Cell order:
# ╠═990bd6cc-9544-11eb-0af4-97f5f5e9ac00
# ╠═01b1f896-9545-11eb-0956-b9c620d1f4f9
# ╠═439adcd6-9546-11eb-14cb-af70ed2b4ce0
# ╠═570b8ce2-954c-11eb-3a58-eba395096032
# ╠═1bad06ec-954e-11eb-085f-6dd3583096ed
# ╠═d3b447aa-954e-11eb-39a7-a9cf3fb02f1a
# ╠═3bc7ee28-954f-11eb-3d23-1fe0820a398c
# ╠═91764afa-9550-11eb-0b4b-a7fa23fd66a6
# ╠═c7d674ba-9550-11eb-1b34-8ba67a1b01e2
# ╠═1575c6de-9552-11eb-3917-7bd0e08cbd0b
# ╠═293e400a-9553-11eb-22bf-fd91ae77ae7f
