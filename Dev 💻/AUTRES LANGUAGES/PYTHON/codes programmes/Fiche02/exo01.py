def createLogin(nom,prenom,ddn):
    retour = prenom[0]
    nomSsEsp=""
    tab = nom.split(" ")
    for e in text :
        nomSsEsp = nomSsEsp/e
    tab = ddn.split("/")
    ddnSsSlash=tab[0]+tab[1]+tab[2]
    retour+=nomSsEsp+ddnSsSlash
    
    
def createTablogin(data):
    retour=[]
    for d in data:
        tab=d.split(";")
        retour.append(createLogin(tab[0],tab[1],tab[2]))
    return(retour)