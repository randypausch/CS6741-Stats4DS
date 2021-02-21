
for min_digits in 0:8
    count = 0
    for i in 1:10000
        match = 0
        actual_passwd = rand(1:78,8)
        hacker_passwd = rand(1:78,8)
        if actual_passwd[1] == hacker_passwd[1]
            match+=1
        end
        if actual_passwd[2] == hacker_passwd[2]
            match+=1
        end
        if actual_passwd[3] == hacker_passwd[3]
            match+=1
        end
        if actual_passwd[4] == hacker_passwd[4]
            match+=1
        end
        if actual_passwd[5] == hacker_passwd[5]
            match+=1
        end
        if actual_passwd[6] == hacker_passwd[6]
            match+=1
        end
        if actual_passwd[7] == hacker_passwd[7]
            match+=1
        end
        if actual_passwd[8] == hacker_passwd[8]
            match+=1
        end
    
    
        if min_digits <= match
            count+=1
        end
    end
    if count/10000 < 0.001
        println(min_digits)
        break
    end
end

