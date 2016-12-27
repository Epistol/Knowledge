from socket import AF_INET,SOCK_STREAM,socket

sc = socket(AF_INET,SOCK_STREAM)
sc.connect(("192.168.28.167",1234))
while True :
    print("1- Rechercher contact par")
    print("2- Rechercher contact tél")
    print("3- Ajouter contact")
    reponse = str(input("Saisissez 1, 2 ou 3"))
    if reponse == "1" :
        
    sc.send("1 ".encode())
    sc.send(nom.encode())
    tel = sc.recv(512)
