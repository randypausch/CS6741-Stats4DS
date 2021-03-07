### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ ac3bac72-7f23-11eb-2d4a-957388430de1
using DataFrames

# ╔═╡ df90f4ba-7f28-11eb-2d27-4b5ade988376
using DataStructures

# ╔═╡ e7c89148-7f36-11eb-2f27-938854956240
using Random

# ╔═╡ b8a713de-7f23-11eb-1b03-ad15acc7a071
import Pkg

# ╔═╡ 73dc859e-7f24-11eb-3c76-1f1fe9a1f880
Pkg.add("DataFrames")

# ╔═╡ 7a3d5f8a-7f29-11eb-2228-ffa6f9d93535
untidy_data = DataFrame(Symbol("religion") => ["Agnostic","Atheist","Buddhist","Catholic","Don’t know/refused","Evangelical Prot","Hindu","Historically Black Prot","Jehovah’s Witness","Jewish"],Symbol("\$0-20k") => [34, 120, 270, 125, 75, 19, 28, 2, 12,20],Symbol("\$20-30k") => [271, 122, 254, 122, 5123, 11, 262, 22, 9,100],Symbol("\$30-40k") => [271, 122, 254, 122, 5123, 11, 262, 22, 9,243],Symbol("\$40-50k") => [1000, 1222, 2347, 1578, 5759, 199, 229, 2023, 19123,22],Symbol("\$50-75k") => [100, 232, 4494, 555, 6060, 23213, 1422, 44566, 4646,36])


# ╔═╡ 47a06daa-7f34-11eb-0631-810013a9d761
 stacked_untidy = stack(untidy_data,[:"\$0-20k",:"\$20-30k",:"\$30-40k",:"\$40-50k",:"\$50-75k"],variable_name="income", value_name="frequency")

# ╔═╡ 92876a68-7f33-11eb-0dec-e5872825ea7d
sort!(stacked_untidy)

# ╔═╡ Cell order:
# ╠═b8a713de-7f23-11eb-1b03-ad15acc7a071
# ╠═73dc859e-7f24-11eb-3c76-1f1fe9a1f880
# ╠═ac3bac72-7f23-11eb-2d4a-957388430de1
# ╠═df90f4ba-7f28-11eb-2d27-4b5ade988376
# ╠═e7c89148-7f36-11eb-2f27-938854956240
# ╠═7a3d5f8a-7f29-11eb-2228-ffa6f9d93535
# ╠═47a06daa-7f34-11eb-0631-810013a9d761
# ╠═92876a68-7f33-11eb-0dec-e5872825ea7d
