
using Distributions

#With replacement case:

n = 5
p = 4/52

a = [Binomial(n,p)]
for i in 0:5
    println(pdf.(a, i))
end

#Without replacement case:
println("Without replacement")
for i in 0:5 
    result = (binomial(4,i)* binomial(48,(5-i)))/binomial(52,5)
    println(result)
end

