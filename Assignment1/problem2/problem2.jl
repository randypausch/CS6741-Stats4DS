
using StatsBase
n = 0 
sum = 0
for j in 1:10000
    cards = sample(1:52,5,replace=true)#Set replace=false for without repalcement
    #Assuming 49, 50, 51, and 52 are Jacks
    success = zeros(0)
    for i in cards
        
        if i >=49
            append!(success,i)
        end
    end
    if length(success) == n
        global sum+=1
    end
end
print(sum/10000)