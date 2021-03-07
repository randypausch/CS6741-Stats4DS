### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 2f861a1a-7f4f-11eb-15c4-3948395d66e1
using DataFrames

# ╔═╡ 307ee33e-7f4f-11eb-3e71-ddd42eb4f5a8
using Distributions

# ╔═╡ 307fcba8-7f4f-11eb-311a-f12c93215499
using Random

# ╔═╡ 370534d8-7f4f-11eb-02dc-d72878ef6a4c
untidy_data = DataFrame(id=[1,1,1,1,1,1,1,2,2,2,3,3,3,3,3],year =[2000,2000,2000,2000,2000,2000,2000,2000,2000,2000,2000,2000,2000,2000,2000],artist=["2 Pac","2 Pac","2 Pac","2 Pac","2 Pac","2 Pac","2 Pac","2 Ge+her","2 Ge+her","2 Ge+her","3 Doors Down","3 Doors Down","3 Doors Down","3 Doors Down","3 Doors Down"],time=[4.22,4.22,4.22,4.22,4.22,4.22,4.22,3.15,3.15,3.15,3.53,3.53,3.53,3.53,3.53],track=["Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","The Hardest Part Of ...","The Hardest Part Of ...","The Hardest Part Of ...","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite"],date=["2000-02-26","2000-03-04","2000-03-11","2000-03-18","2000-03-25","2000-04-01","2000-04-08","2000-09-02","2000-09-09","2000-09-16","2000-04-08","2000-04-15","2000-04-22","2000-04-29","2000-05-06"],week=[1,2,3,4,5,6,7,1,2,3,1,2,3,4,5],rank=[87,82,72,77,87,94,99,91,87,92,81,70,68,67,66])
select(untidy_data,[:year,:artist,:time,:track,:date,:week,:rank])
# ╔═╡ 29bf1578-7f57-11eb-13ed-2fedb5c0e8d4
tidy_data_1 = select(untidy_data,[:id,:artist,:track,:time])



# ╔═╡ 5b4d78dc-7f59-11eb-0667-bbb7e01a2896
unique(tidy_data_1)

# ╔═╡ 1e2c1f8e-7f5a-11eb-22d4-5f0b4df1e7c1
tidy_data_2 = select(untidy_data,[:id,:date,:rank])

# ╔═╡ Cell order:
# ╠═2f861a1a-7f4f-11eb-15c4-3948395d66e1
# ╠═307ee33e-7f4f-11eb-3e71-ddd42eb4f5a8
# ╠═307fcba8-7f4f-11eb-311a-f12c93215499
# ╠═370534d8-7f4f-11eb-02dc-d72878ef6a4c
# ╠═29bf1578-7f57-11eb-13ed-2fedb5c0e8d4
# ╠═5b4d78dc-7f59-11eb-0667-bbb7e01a2896
# ╠═1e2c1f8e-7f5a-11eb-22d4-5f0b4df1e7c1
