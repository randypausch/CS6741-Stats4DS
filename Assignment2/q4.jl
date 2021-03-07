### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 4abd0200-7f5c-11eb-31a7-a54c8bb36460
using HTTP, JSON

# ╔═╡ d564ddf6-7f5c-11eb-1f53-9581dcecfe8b
using DataFrames

# ╔═╡ 6bd5f7d4-7f5f-11eb-0f8e-01c3d8200f6f
using JSONTables

# ╔═╡ 07d72b30-7f68-11eb-1617-394dcd086e1f
using Dates

# ╔═╡ d123626c-7f70-11eb-3887-15b276f6f224
using Query

# ╔═╡ 5e3bae06-7f5c-11eb-1952-c3534921e99f
json_file = HTTP.get("https://api.covid19india.org/data.json")

# ╔═╡ 7af2fb78-7f5c-11eb-1f79-07ad6898af00
str = String(json_file.body)

# ╔═╡ 90d728b0-7f5c-11eb-22e4-4b0304bf6bb9
jobj = JSON.Parser.parse(str)

# ╔═╡ 13652b3e-7f61-11eb-31b8-7db9f0b319c3
df = DataFrame(jobj["cases_time_series"])

# ╔═╡ 28c16d0c-7f62-11eb-3c93-0b0738a580ca
select!(df,[:vals])

# ╔═╡ e1f21e20-7f62-11eb-38f9-034fbe3c983d
df.vals


# ╔═╡ b239f7bc-7f66-11eb-3b4b-1554df9ff989
final_df = DataFrame(dailyconfirmed= String[], dailydeceased=String[],dailyrecovered=String[],date=String[])

# ╔═╡ 550c20b4-7f67-11eb-0596-2b8fa941efaa
tmp = df.vals

# ╔═╡ a83a7aac-7f66-11eb-302d-75eabaf9fba0
for i = 2 : length(tmp)
    push!(final_df.dailyconfirmed, tmp[i][1])
    push!(final_df.dailydeceased, tmp[i][2])
    push!(final_df.dailyrecovered, tmp[i][4])
    push!(final_df.date, tmp[i][5])
end

# ╔═╡ f27839aa-7f67-11eb-1506-37fdbfcbfd4e


# ╔═╡ e92a824c-7f65-11eb-1c82-ad422e7cba28
final_df

# ╔═╡ 9b9dc118-7f67-11eb-239c-9f78995d1ea6
final_df

# ╔═╡ 4221bc6a-7f68-11eb-1983-77ecabf16246
final_df[!,:dailyconfirmed] = [parse(Int,x) for x in final_df[!,:dailyconfirmed]] 

# ╔═╡ 2c67b5dc-7f68-11eb-01c5-49dad72c46d5
final_df[!,:dailydeceased] = [parse(Int,x) for x in final_df[!,:dailydeceased]]

# ╔═╡ 1cb355b0-7f68-11eb-3261-97f330e6b9e2
final_df[!,:dailyrecovered] = [parse(Int,x) for x in final_df[!,:dailyrecovered]]

# ╔═╡ 11d5adf0-7f68-11eb-057e-ed23fe29c372
select!(final_df,[:dailyconfirmed,:dailydeceased,:dailyrecovered,:date])

# ╔═╡ 01561d84-7f68-11eb-001f-63dc622e6eb3
final_df.date = Date.(final_df.date, "yyyy-mm-dd")

# ╔═╡ 470ef5e8-7f6e-11eb-06d1-a5052d2db49d
final_df |>
          @groupby(yearmonth(_.date)) |>
          @map({YearMonth=key(_), sumconfirmed=sum(_.dailyconfirmed), sumrecovered=sum(_.dailyrecovered), sumdeceased=sum(_.dailydeceased)}) |>
          DataFrame


# ╔═╡ 1b3f22a4-7f70-11eb-051f-cd27de6b22e8


# ╔═╡ Cell order:
# ╠═4abd0200-7f5c-11eb-31a7-a54c8bb36460
# ╠═d564ddf6-7f5c-11eb-1f53-9581dcecfe8b
# ╠═6bd5f7d4-7f5f-11eb-0f8e-01c3d8200f6f
# ╠═5e3bae06-7f5c-11eb-1952-c3534921e99f
# ╠═7af2fb78-7f5c-11eb-1f79-07ad6898af00
# ╠═90d728b0-7f5c-11eb-22e4-4b0304bf6bb9
# ╠═13652b3e-7f61-11eb-31b8-7db9f0b319c3
# ╠═28c16d0c-7f62-11eb-3c93-0b0738a580ca
# ╠═e1f21e20-7f62-11eb-38f9-034fbe3c983d
# ╠═b239f7bc-7f66-11eb-3b4b-1554df9ff989
# ╠═550c20b4-7f67-11eb-0596-2b8fa941efaa
# ╠═a83a7aac-7f66-11eb-302d-75eabaf9fba0
# ╠═f27839aa-7f67-11eb-1506-37fdbfcbfd4e
# ╠═e92a824c-7f65-11eb-1c82-ad422e7cba28
# ╠═9b9dc118-7f67-11eb-239c-9f78995d1ea6
# ╠═4221bc6a-7f68-11eb-1983-77ecabf16246
# ╠═2c67b5dc-7f68-11eb-01c5-49dad72c46d5
# ╠═1cb355b0-7f68-11eb-3261-97f330e6b9e2
# ╠═11d5adf0-7f68-11eb-057e-ed23fe29c372
# ╠═07d72b30-7f68-11eb-1617-394dcd086e1f
# ╠═01561d84-7f68-11eb-001f-63dc622e6eb3
# ╠═d123626c-7f70-11eb-3887-15b276f6f224
# ╠═470ef5e8-7f6e-11eb-06d1-a5052d2db49d
# ╠═1b3f22a4-7f70-11eb-051f-cd27de6b22e8
