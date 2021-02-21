
using StatsBase,Plots
#Emperical
test_probs = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
P = zeros(0)
p = zeros(0)
    for i in test_probs
        count = 0
        for j in 1:100000
            money = 10
            
            for k in 1:20
                money+=sample([-1,1],Weights([i,1-i]))
                if money == 0
                    count+= 1
                    break
                end
            end
            
        end
    
    append!(P,count/100000)
    append!(p,i)
    end
    plot(p,P,leg=false,background_color = RGB(0.2, 0.2, 0.2),xlabel="p",ylabel="Probability of going bankrupt")
    savefig("problem7.png")

    

print(p)
print(P)
