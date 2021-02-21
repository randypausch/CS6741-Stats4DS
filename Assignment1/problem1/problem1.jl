
sum = 0
y = zeros(0)
for i in 1:1000
    global sum+= rand(Int64)
    append!(y,sum/i)
    
end
using Plots
x= 1:1000
plot(x,y,leg=false,background_color = RGB(0.2, 0.2, 0.2))
title!("Law of large numbers")
savefig("problem1.png")
