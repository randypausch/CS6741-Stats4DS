
using StatsBase,Plots
#Emperical
test_probs = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
P = zeros(0)
p = zeros(0)
    for i in test_probs
        count = 0
        for j in 1:10000
            money = 10
            for k in 1:20
                money+=sample([-1,1],Weights([i,1-i]))
            end
            if money >= 10
                count+= 1
            end
        end
    append!(P,count/10000)
    append!(p,i)
    end
    plot(p,P,leg=false,background_color = RGB(0.2, 0.2, 0.2),xlabel="p",ylabel="P")
    savefig("problem6_emperical.png")
#Theoretical
using Distributions
probs(p) = sum([binomial(20,k)*(p^k)*(1-p)^(20-k) for k in 0:10])
plot(probs,0.00001,0.9999,leg=false,background_color = RGB(0.2, 0.2, 0.2),xlabel="p",ylabel="P")
savefig("problem6_theoretical.png")
# test_probs = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
# for i in test_probs
#     println(probs(i))

# end
