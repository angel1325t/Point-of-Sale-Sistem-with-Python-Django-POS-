n = 9
array = [2,1,3,4,6,8,5,9]

def find_missing_number(n,array):
    totalSum = n * ((n + 1) / 2)
    sum2 = 0
    for i in array:
        sum2 += i
    if totalSum != sum2:
        missingNumber = totalSum - sum2
        return f'el numero que falta es {missingNumber}'
    else:
        return f'no falta ningun numero'
print(find_missing_number(n,array))
