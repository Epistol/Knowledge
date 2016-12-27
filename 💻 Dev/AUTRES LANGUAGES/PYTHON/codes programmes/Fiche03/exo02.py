class telephone :
    def __init__(self,numeroTel,typeTel):
        self._numeroTel=numeroTel
        self._typeTel=typeTel
    
    def getNumeroTel(self):
        return(self._numeroTel)

    def getTypeTel(self):
        return self._typeTel
    def __str__(self):
        return self._typeTel+" : "+self._numeroTel
    
class contact :
    def __init__(self,lePrenom,leNom,listeTelephone):
        self._prenom = lePrenom
        self._nom = leNom
        self._listeTelephone=[]
        
    
    def ajoutTel(self,telephone):
        self._listeTelephone.append(telephone)
    
    def __str__(self):
        chaine = (self._nom," ",self._prenom,": ")
        for t in self._listeTelephone:
            chaine+="\t"+t.__str__()
            return(chaine)
            
class EtudiantBoursier(contact):
    def __init__(self,nom,prenom,niveauB):
        contact.__init__(self,nom,prenom)
        self._niveauB = niveauB
    
    def __str__(self):
        chaine = contact.__str__(self)
        chaine += " lol : "+self._niveauB
        return chaine
