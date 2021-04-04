### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 0b76f804-9568-11eb-3d46-21bc7ca93e95
begin
	using Distributions
	using QuadGK
	
end

# ╔═╡ b00f6d48-9567-11eb-35ac-73236f8400ea
percentile(n, d)=quadgk(x->pdf(d,x), (-Inf, n)...)[1]

# ╔═╡ 2de13db4-9568-11eb-22c0-076adb09d50c
begin
		range = [i for i in -100:0.1:100]
		function OneSidedTail(x)
			x=100-x
			    for i in range
			        if(percentile(i, TDist(10))>=x/100)
			            return i
					end
				end
		end
end

# ╔═╡ 0098a062-9569-11eb-2767-2f7dfe6ce62b
OneSidedTail(95)

# ╔═╡ 54818d4c-9569-11eb-08f7-172eecee1055


# ╔═╡ Cell order:
# ╠═0b76f804-9568-11eb-3d46-21bc7ca93e95
# ╠═b00f6d48-9567-11eb-35ac-73236f8400ea
# ╠═2de13db4-9568-11eb-22c0-076adb09d50c
# ╠═0098a062-9569-11eb-2767-2f7dfe6ce62b
# ╠═54818d4c-9569-11eb-08f7-172eecee1055
