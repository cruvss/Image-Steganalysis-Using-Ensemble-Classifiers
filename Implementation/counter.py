
with open('kodovsky.txt', 'r') as file:
    lines = file.readlines()
total_positive = 0
count=0

for line in lines:
    count+=1
    number = int(line.strip())
    if number > 0:
        total_positive += 1

print(f'% accuracy is: {(total_positive/count)*100}')
