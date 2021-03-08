### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ a50474dc-8029-11eb-1dcd-1ba31bd7fcfd
begin
using HTTP, JSON
using DataFrames
using Dates
json_file = HTTP.get("https://api.covid19india.org/data.json")
str = String(json_file.body)
jobj = JSON.Parser.parse(str)
df = DataFrame(jobj["cases_time_series"])
select!(df,[:vals])
df.vals
final_df = DataFrame(dailyconfirmed= String[], dailydeceased=String[],dailyrecovered=String[],date=String[])

tmp = df.vals
for i = 2 : length(tmp)
    push!(final_df.dailyconfirmed, tmp[i][1])
    push!(final_df.dailydeceased, tmp[i][2])
    push!(final_df.dailyrecovered, tmp[i][4])
    push!(final_df.date, tmp[i][5])
end
final_df[!,:dailyconfirmed] = [parse(Int,x) for x in final_df[!,:dailyconfirmed]] 
final_df[!,:dailydeceased] = [parse(Int,x) for x in final_df[!,:dailydeceased]]
final_df[!,:dailyrecovered] = [parse(Int,x) for x in final_df[!,:dailyrecovered]]
final_df.date = Date.(final_df.date, "yyyy-mm-dd")
select!(final_df,[:dailyconfirmed,:dailydeceased,:dailyrecovered,:date])
end

# ╔═╡ e2768b60-802a-11eb-3243-9b67527abf59
using Plots

# ╔═╡ ec8a4c00-802e-11eb-24d8-33496668bb5c
using TimeSeries, Statistics

# ╔═╡ e794ee02-802a-11eb-25a7-1337bbc419fa
begin
	plot(final_df.date,final_df.dailyconfirmed,leg=false,background_color = RGB(0.2, 0.2, 0.2))
	title!("Increase in Confirmed")
	
end

# ╔═╡ 328623f4-802b-11eb-0c96-8f10fbb33e19
begin
	plot(final_df.date,final_df.dailydeceased,leg=false,background_color = RGB(0.2, 0.2, 0.2))
	title!("Increase in Deaths")
	
end

# ╔═╡ 4890a610-802b-11eb-08e0-691202471b7d
begin
	plot(final_df.date,final_df.dailyrecovered,leg=false,background_color = RGB(0.2, 0.2, 0.2))
	title!("Increase in Recovered")
	
end

# ╔═╡ 271a0836-802f-11eb-3e14-075fa4857c73
begin
	moving_average(vs,n) = [sum(@view vs[i:(i+n-1)])/n for i in 1:(length(vs)-(n-1))]
	x = final_df.dailyrecovered
	y = moving_average(x, 7)
	pushfirst!(y, 0.0)
	pushfirst!(y, 0.0)
	pushfirst!(y, 0.0)
	pushfirst!(y, 0.0)
	pushfirst!(y, 0.0)
	pushfirst!(y, 0.0)
	plot(final_df.date,y,leg=false,background_color = RGB(0.2, 0.2, 0.2))
	title!("Increase in Recovered (Simple Moving Average)")
end

# ╔═╡ 525f3c24-8030-11eb-15f7-cd6a7b366277
begin
	a = moving_average(final_df.dailydeceased, 7)
	pushfirst!(a, 0.0)
	pushfirst!(a, 0.0)
	pushfirst!(a, 0.0)
	pushfirst!(a, 0.0)
	pushfirst!(a, 0.0)
	pushfirst!(a, 0.0)
	plot(final_df.date,a,leg=false,background_color = RGB(0.2, 0.2, 0.2))
	title!("Increase in Deceased (Simple Moving Average)")
end

# ╔═╡ f20dc6be-8030-11eb-07af-e76530a1927a
begin
	b = moving_average(final_df.dailyrecovered, 7)
	pushfirst!(b, 0.0)
	pushfirst!(b, 0.0)
	pushfirst!(b, 0.0)
	pushfirst!(b, 0.0)
	pushfirst!(b, 0.0)
	pushfirst!(b, 0.0)
	plot(final_df.date,b,leg=false,background_color = RGB(0.2, 0.2, 0.2))
	title!("Increase in Recovered (Simple Moving Average)")
end

# ╔═╡ Cell order:
# ╠═a50474dc-8029-11eb-1dcd-1ba31bd7fcfd
# ╠═e2768b60-802a-11eb-3243-9b67527abf59
# ╠═e794ee02-802a-11eb-25a7-1337bbc419fa
# ╠═328623f4-802b-11eb-0c96-8f10fbb33e19
# ╠═4890a610-802b-11eb-08e0-691202471b7d
# ╠═ec8a4c00-802e-11eb-24d8-33496668bb5c
# ╠═271a0836-802f-11eb-3e14-075fa4857c73
# ╠═525f3c24-8030-11eb-15f7-cd6a7b366277
# ╠═f20dc6be-8030-11eb-07af-e76530a1927a
