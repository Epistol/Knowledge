from socket import socket,AF_INET,SOCK_STREAM
def findContactByNom(liste,nom):
    for c in liste:
        if c==nom :
            return c
    pass

def findContactByTel(liste,tel):
    for c in liste:
        if c==tel :
            return c
    pass
ss = socket(AF_INET , SOCK_STREAM)
ss.bind(("192.168.28.167",1234))
ss.listen(5)
print("Serveur en ecoute")
socket , info = ss.accept()
while True:
    commande = socket.recv(16)
    commande = commande.decode[512]
    if commande =="1":
        nom = socket.recv(512)
        nom = nom.decode()
        c = findContactByNom(liste, nom)
        socket.send("012345678")
    