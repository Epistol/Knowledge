

from Fiche02.exo02 import etudiant, EtudiantBoursier
from Fiche02.exo02 import telephone
if __name__ == '__main__':
    e1 = EtudiantBoursier("TOTO","titi",'0677696437')
    e1.ajoutTel(telephone("Mobile","0677569431"))
    print(e1.__str__())