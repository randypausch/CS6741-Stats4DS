### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ c0a96708-952b-11eb-197d-5db4deb2d254
using Distributions

# ╔═╡ dd8d4bd2-952b-11eb-301d-ade6d691bfd6
begin
	x = rand(Uniform(0,1),10)
	sum(x)
end

# ╔═╡ 67310b9a-9567-11eb-2bab-1975c2b89529
begin
	plotss=[]
	plt=[]
	function Question2(N)
		empty!(plotss)
		empty!(plt)
		function KLDiv(array, mu, sigma)
			normalDiscrete=[pdf(Normal(mu, sigma),x) for x in range]
			summ=0
			for i in 1:length(range)
			   if array[i]>0
				 summ+=array[i]*log2(array[i]/ normalDiscrete[i])
			   end
			end
			return summ/num
		end
		
		function fitData(distArr, kp)
			μ=sum([i*kp[i] for i in range])/(num-1)
			σ=sqrt(sum([i^2*kp[i] for i in range])/(num-1) - μ^2)
			push!(KLD, KLDiv(distArr, μ, σ))
			push!(plotss, plot!(x->x, x->pdf(Normal(μ, σ), x), range, label=false))
		end
		
		uf=Uniform(0,1)
		step=0.005
		num=1/step + 1
		range=-5:step:10
		keep=Dict()
		KLD=[]
		
		
		initt=[pdf(uf,k) for k in range]
		initdict=Dict([(k, pdf(uf,k)) for k in range])
		push!(plotss, plot(range, initt, label=false))
		fitData(initt,initdict)
		
		idx=1:length(range)
		conv(x) = sum([pdf(uf,x-k)*pdf(uf,k) for k in range])
		arr=conv.(range)/num
		for go in idx
		    keep[range[go]]=arr[go]
		end
		push!(plotss, plot!(range, arr, label=false))
		fitData(arr,keep)
		
		
		
		arr1=[]
		keep1=keep
		conv1(x) = sum([keep1[k]*pdf(uf,x-k) for k in range])
		for j in 2:N
		  arr1=conv1.(range)/num
		  for go in idx
		    keep1[range[go]]=arr1[go]
		  end	
		  push!(plotss, plot!(range, arr1, label=false))
		  fitData(arr1,keep1)
		end
		
		push!(plt, plot(2:N, KLD[2:N], title="kl-divergence plot",label=false, line=2, color=:black, ylabel="KL-divergence values", xlabel="number of disbritutions convoluted"))
		print(KLD)
	end
end

# ╔═╡ Cell order:
# ╠═c0a96708-952b-11eb-197d-5db4deb2d254
# ╠═dd8d4bd2-952b-11eb-301d-ade6d691bfd6
# ╠═67310b9a-9567-11eb-2bab-1975c2b89529
