### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ a815c414-9500-11eb-124f-e71d493c6444
using Distributions
using QuadGK

# ╔═╡ a85399c0-94ff-11eb-1e43-6d70bf4f7933
KL(P,Q) =quadgk(x->pdf(P,x)*log(pdf(P,x)/pdf(Q,x)),(-37:37)...)[1]
#Not doing for infinite limits, because the integrants produce nan after this limit.

# ╔═╡ eebe9488-9503-11eb-267f-4bd54c90db10
begin
	# x = [a for a in -1000:1000]
	q = Normal(0,1)
	for i in 1:5
		p = TDist(i)
		println(KL(p,q))
	end
end

# ╔═╡ Cell order:
# ╠═a85399c0-94ff-11eb-1e43-6d70bf4f7933
# ╠═a815c414-9500-11eb-124f-e71d493c6444
# ╠═eebe9488-9503-11eb-267f-4bd54c90db10
