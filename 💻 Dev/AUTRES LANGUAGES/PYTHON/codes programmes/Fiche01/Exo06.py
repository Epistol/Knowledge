from random import *
penal=0
testnbre = 0
nbre=randrange(0,100,1)
nbreessaye=[]
while nbre!=testnbre :
    testnbre=int(input("Saisissez un nombre entre 1 et 100 : "))
    if int(testnbre)<int(nbre) :
        print("Trop petit!")
        
    if int(testnbre)>int(nbre) :
        print("trop grand!")
print("Gagne!")
print(nbreessaye)
