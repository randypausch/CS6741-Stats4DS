### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# ╔═╡ 35d99446-b0f5-11eb-3117-879d60cb4704
begin
    using StatsBase
    using Statistics
    using Distributions
    using Random
	using LaTeXStrings
	using StatsPlots

end


# ╔═╡ 1ff2118d-7527-4241-a015-d3d8aaaf904c
Random.seed!(0)

# ╔═╡ caa60ee4-8cd9-4637-90fc-65d6dfb883d0
md"### Solution 1.(a). Monte-Carlo Estimation"


# ╔═╡ 44e61f85-3c3d-40ca-8ccd-f953b48e2eb6
 coin_toss_outcome = ['H', 'T']

# ╔═╡ fe6099c5-e4ab-4f5e-95fc-607229c19007
begin
    #=
    Experiment- 
        Toss coin 50 times and record the no. of 'H'. 
        If no. of H > 30, decision is 'approved' (i.e., set to True).
    
    Perform the above experiment multiple times.
    =#
    experiment_record = []
    for _ in 1:10^7
        push!(experiment_record, rand(coin_toss_outcome, 50)) # Toss coin 50 times.
    end
    experiment_record
end


# ╔═╡ 7aaa626b-fb6e-425e-876a-605fd156fec4
begin
    nb_heads_record = []
    for outcome in experiment_record
        nb_heads = count(x->x=='H', outcome)
        push!(nb_heads_record, nb_heads)
    end
    nb_heads_record
end


# ╔═╡ 3258c1eb-b8d7-4bc5-ba39-4a6844ee2c59
 nb_commits = count(x->(x>=30), nb_heads_record)


# ╔═╡ aaef0827-856b-4451-acd0-7ca596c59849
req_prob = nb_commits / size(experiment_record, 1)

# ╔═╡ 8c7b3f50-067c-46db-9ef1-9e0c645a6c37
md"### Solution 1.(b). Binomial Distribution"


# ╔═╡ 7ec68e6a-59da-4945-831c-ec3b30b51648
D_binomial = Binomial(50, 0.5)


# ╔═╡ dab47f28-5f61-4a2b-9175-5d20283c2618
req_prob_bin = sum(pdf(D_binomial, 30:50))


# ╔═╡ 42d7bbd1-3244-40f3-9493-e6d0227a5e43
md"### Monte-Carlo Estimation Q2"


# ╔═╡ 12ff5d5a-2263-4342-a1c6-e0415df7f476
function compute_probability(p)
    #=
    Experiment- 
        Toss coin 50 times and record the no. of 'H'. 
        If no. of H > 30, decision is 'approved' (i.e., set to True).
    
    Perform the above experiment multiple times and compute prob. of
    going ahead with the decision.
    =#
    coin_toss_outcome = ['H', 'T']
    coin_outcome_weights = [p, 1-p]
    
    experiment_record = []
    for _ in 1:10^5
        # Toss coin 50 times.
        push!(
            experiment_record, 
            sample(
                coin_toss_outcome, Weights(coin_outcome_weights), 
                50, replace=true
            )
        )
    end
    
    # Count the number of heads observed in each experiment.
    nb_heads_record = []
    for outcome in experiment_record
        nb_heads = count(x->x=='H', outcome)
        push!(nb_heads_record, nb_heads)
    end
    
    nb_commits = count(x->(x>=30), nb_heads_record)
    req_prob = nb_commits / size(experiment_record, 1)
    
    return req_prob
end


# ╔═╡ 0958ff5c-995a-4fdd-9e84-73056f9a5267
begin
    prob_heads_mc = 0
    prob_going_ahead_mc = 0
    for p in 0.0:0.01:1.0
        req_prob = compute_probability(p)
        if req_prob >= 0.50
            prob_heads_mc = p
            prob_going_ahead_mc = req_prob
            break
        end
    end
    prob_heads_mc, prob_going_ahead_mc
end


# ╔═╡ 298b9d80-8eda-473a-85b5-c85e29b81372
md"### Binomial Distribution"

# ╔═╡ 17049ff9-1030-401a-9f5c-3c12b5c343e0
begin
    prob_heads_bin = 0
    prob_going_ahead_bin = 0
    for p in 0.0:0.01:1.0
        D_binomial = Binomial(50, p)
        req_prob = sum(pdf(D_binomial, 30:50))
        if req_prob >= 0.50
            prob_heads_bin = p
            prob_going_ahead_bin = req_prob
            break
        end
    end
    prob_heads_bin, prob_going_ahead_bin
end


# ╔═╡ 0f9bd75d-7fdf-4d07-868b-01d928b62cb4
md"### Q3"

# ╔═╡ f7b98ed2-de9f-4542-a380-7c98fc09a20b
begin
    N = 50
    pr = [1 - cdf(Normal(100*n, 30*(n^0.5)), 3000) for n = 1:N]
    n_min = findfirst(pr .>= 0.95)
    
    plot(1:N, pr, line=(2, :red), label=false)
    plot!(1:N, 0.95*ones(N,), line=(2, :dash, :blue), label=false)
    plot!([n_min, n_min], [0, 0.95], line=(2, :dot, :orange), label=false)
    plot!(ylabel=L"$\mathrm{Pr}(X \geq 3000)$")
    plot!(xlabel="n")
    xticks!([0, 10, 20, 30, n_min, 40, 50])
end


# ╔═╡ 924089d8-1e86-4d42-9ec4-9d7c329bc9d4
md"### Q4"

# ╔═╡ fc0e9ba5-703c-4f65-ad70-8e746d0ecc57
begin
    function check_skew_kurt(X, d)
        sample_skew = skewness(X, mean=mean(d))
        sample_kurt = kurtosis(X, mean=mean(d))
        return [abs(sample_skew - skewness(Normal(0,1))), abs(sample_kurt - kurtosis(Normal(0,1)))]
    end
    
    function plot_dist(d, n)
        X = [sum((rand(d, n) .- mean(d)) / (std(d) * (n^0.5))) for _ = 1:100000]
        displot = histogram(X, label="Sample Distribution", normalize=true)
        plot!(
            Normal(0,1), 
            label="Standard Normal", 
            line=(4, :red), 
            title=latexstring("n = $n")
        )
    end
    
    function run_for_n(d, N)
        skew_diff, kurt_diff = [], []
        for n = 1:N
            X = [sum((rand(d, n) .- mean(d)) / (std(d) * (n^0.5))) for _ = 1:100000]
 
            sample_skew = skewness(X)
            sample_kurt = kurtosis(X)
            push!(skew_diff, abs(sample_skew - skewness(Normal(0,1))))
            push!(kurt_diff, abs(sample_kurt - kurtosis(Normal(0,1))))
        end
        
        n_fin = max(findfirst(kurt_diff .< 0.1), findfirst(skew_diff .< 0.1))
        plt = plot(1:N, skew_diff, label="Skewness", line=(2, :green))
        plot!(1:N, kurt_diff, label="Kurtosis", line=(2, :orange))
        plot!(title="Absolute Error in Skewness and Kurtosis")
        plot!(1:N, 0.1*ones(size(skew_diff)), label=false, line=(1, :dash, :blue))
        plot!([n_fin, n_fin], [0, 0.1], line=(1, :dash, :red), label=false)
        plot!(ylims= (0,0.2))
        xticks!([0, n_fin, 25, 50, 75, 100])
        return plt, n_fin 
    end
end


# ╔═╡ 442b97f2-4dac-44de-bc1f-1d8405017177
md"👉 Unif(0,1)"


# ╔═╡ 87058a02-6c2e-4ba1-91af-30ce46a452e6
begin
    plt_1, n_fin_1 = run_for_n(Uniform(0,1), 100);
    plt_1
end


# ╔═╡ b089137e-d6bd-4729-bc15-ac6da759f8f1
plot_dist(Uniform(0,1), n_fin_1)

# ╔═╡ 51bd4eb3-44dc-41b8-bb75-c9367f26b296
md"👉 Binomial(100,0,1)"

# ╔═╡ 7adb14ff-eed3-4dd2-839f-4ca305091326
begin
    plt_2, n_fin_2 = run_for_n(Binomial(100,0.01), 100);
    plt_2
end


# ╔═╡ fc9e2497-f439-4888-9330-694f07cfee00
plot_dist(Binomial(100,0.01), n_fin_2)

# ╔═╡ 47b43eac-5710-4f11-b2b9-210ef8715578
md"👉 Binomial(10,0.5)"

# ╔═╡ 49748eff-3490-4caf-be0f-84d2b5f00f3d
begin
    plt_3, n_fin_3 = run_for_n(Binomial(10,0.5), 100);
    plt_3
end


# ╔═╡ a7595584-d32c-42fd-8251-f99fa2653ca8
plot_dist(Binomial(10,0.5), n_fin_3)

# ╔═╡ fbbe1ccf-52dd-4617-a359-e326c7676d37
md"👉$\chi^2(3)$"


# ╔═╡ f5f8ae88-bbcb-42da-8e06-2830129f80cc
begin
    plt_4, n_fin_4 = run_for_n(Chi(3), 100);
    plt_4
end


# ╔═╡ 97bcb7bd-a212-4141-8fa8-aa48a5ca3d5c
plot_dist(Chi(3), n_fin_4)

# ╔═╡ d5d615a1-f459-45cf-9163-8cf113b9eb1f
md"### Q5"

# ╔═╡ e0d58963-91ef-4f93-8cdb-d2dcb7936bc5
begin
	n_vals= 2:100
	nn_for_sig = []
	for nn in n_vals
		sig_vals_2 = 0.1:0.001:10
		pr_vals_2 = [cdf(Chi(nn-1),((nn-1)*5/(2*sig^2))) for sig in sig_vals_2]
		push!(nn_for_sig, sig_vals_2[pr_vals_2 .> 0.9][end]^2)
	end
	nn_for_sig
	plot(n_vals, nn_for_sig,line=(2,:red),label=false,xlabel=L"$n$",ylabel=L"$\sigma^2$")
end

# ╔═╡ fb7ebad2-87be-4128-9c0f-c997da3e7165
nn_for_sig

# ╔═╡ Cell order:
# ╠═35d99446-b0f5-11eb-3117-879d60cb4704
# ╠═1ff2118d-7527-4241-a015-d3d8aaaf904c
# ╠═caa60ee4-8cd9-4637-90fc-65d6dfb883d0
# ╠═44e61f85-3c3d-40ca-8ccd-f953b48e2eb6
# ╠═fe6099c5-e4ab-4f5e-95fc-607229c19007
# ╠═7aaa626b-fb6e-425e-876a-605fd156fec4
# ╠═3258c1eb-b8d7-4bc5-ba39-4a6844ee2c59
# ╠═aaef0827-856b-4451-acd0-7ca596c59849
# ╠═8c7b3f50-067c-46db-9ef1-9e0c645a6c37
# ╠═7ec68e6a-59da-4945-831c-ec3b30b51648
# ╠═dab47f28-5f61-4a2b-9175-5d20283c2618
# ╠═42d7bbd1-3244-40f3-9493-e6d0227a5e43
# ╠═12ff5d5a-2263-4342-a1c6-e0415df7f476
# ╠═0958ff5c-995a-4fdd-9e84-73056f9a5267
# ╠═298b9d80-8eda-473a-85b5-c85e29b81372
# ╠═17049ff9-1030-401a-9f5c-3c12b5c343e0
# ╠═0f9bd75d-7fdf-4d07-868b-01d928b62cb4
# ╠═f7b98ed2-de9f-4542-a380-7c98fc09a20b
# ╠═924089d8-1e86-4d42-9ec4-9d7c329bc9d4
# ╠═fc0e9ba5-703c-4f65-ad70-8e746d0ecc57
# ╠═442b97f2-4dac-44de-bc1f-1d8405017177
# ╠═87058a02-6c2e-4ba1-91af-30ce46a452e6
# ╠═b089137e-d6bd-4729-bc15-ac6da759f8f1
# ╠═51bd4eb3-44dc-41b8-bb75-c9367f26b296
# ╠═7adb14ff-eed3-4dd2-839f-4ca305091326
# ╠═fc9e2497-f439-4888-9330-694f07cfee00
# ╠═47b43eac-5710-4f11-b2b9-210ef8715578
# ╠═49748eff-3490-4caf-be0f-84d2b5f00f3d
# ╠═a7595584-d32c-42fd-8251-f99fa2653ca8
# ╠═fbbe1ccf-52dd-4617-a359-e326c7676d37
# ╠═f5f8ae88-bbcb-42da-8e06-2830129f80cc
# ╠═97bcb7bd-a212-4141-8fa8-aa48a5ca3d5c
# ╠═d5d615a1-f459-45cf-9163-8cf113b9eb1f
# ╠═e0d58963-91ef-4f93-8cdb-d2dcb7936bc5
# ╠═fb7ebad2-87be-4128-9c0f-c997da3e7165
