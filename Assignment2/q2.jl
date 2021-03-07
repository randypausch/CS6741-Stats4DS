### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 9567ca70-7f56-11eb-3397-dbfc29985bf0
using DataFrames

# ╔═╡ a007f3c4-7f56-11eb-199d-253f08ffd266
using Distributions

# ╔═╡ a2165816-7f56-11eb-04f9-b7fbbd1f04f2
using Random

# ╔═╡ a88f71de-7f56-11eb-2f1b-1dbcc6730b00
begin
   temp = Uniform(0, 40)
 
   names_of_column = ["id" => repeat(["MX17004"], 24), "year" => repeat([2010], 24), "month" => vec(repeat(1:12, 1, 2)'), "element" => repeat(["tmax", "tmin"], 12)]
   [push!(names_of_column, "d_$i" => Vector{Union{Missing, Float32}}(missing, 24)) for i = 1:31]
   untidy_data = DataFrame(names_of_column)
 
   for i = 1:2:24
       days = rand(1:31, rand(10:31, 1)[1])
       for d in days
           min_temp, max_temp = extrema(rand(temp, 2))
           untidy_data[i,4+d] = max_temp
           untidy_data[i+1,4+d] = min_temp
       end
   end
  
end


# ╔═╡ d561ccdc-7f56-11eb-25f3-cfec5aa2f567
untidy_data

# ╔═╡ e08be554-7f56-11eb-2cbf-459dddfb1473
begin
   function append_0(date)
       date = string(date)
       if length(date)==1
           date = "0"*date
       end
       return date
   end
tidy_data = sort(dropmissing(stack(untidy_data)), :month)
   tidy_data.year = string.(tidy_data.year)
   select!(tidy_data,:id,:year, :month => ByRow(append_0) => :month, :element, :variable => ByRow(x -> append_0(x[3:end])) => :day, :value)
 
   sort!(tidy_data, [:month, :day])
  
   tidy_data.day .= tidy_data.year .* "-" .* tidy_data.month .* "-" .* tidy_data.day
   select!(tidy_data, :id, :day => :date, :element, :value)
  
   dfs = []
   for elem in unique(tidy_data[:,:element])
       push!(dfs, select(tidy_data[tidy_data[!, :element] .== elem, :], :id, :date, :value => elem))
   end
   tidy_data = rightjoin(dfs[1], dfs[2], on=[:date, :id])
  
  
end


# ╔═╡ f4698310-7f56-11eb-00c3-7d51a4424cdd
tidy_data

# ╔═╡ Cell order:
# ╠═9567ca70-7f56-11eb-3397-dbfc29985bf0
# ╠═a007f3c4-7f56-11eb-199d-253f08ffd266
# ╠═a2165816-7f56-11eb-04f9-b7fbbd1f04f2
# ╠═a88f71de-7f56-11eb-2f1b-1dbcc6730b00
# ╠═d561ccdc-7f56-11eb-25f3-cfec5aa2f567
# ╠═e08be554-7f56-11eb-2cbf-459dddfb1473
# ╠═f4698310-7f56-11eb-00c3-7d51a4424cdd
