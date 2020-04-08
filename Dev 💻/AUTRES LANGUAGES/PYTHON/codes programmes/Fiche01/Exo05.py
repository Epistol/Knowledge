data = ["medassi;anthony;sio1","naudier;nans;sio1"]
entete = "nom;prenom;classe"
dico=dict()
tEntete=entete.split(";")
for d in data:
    tD=d.split(";")
    for i,e in enumerate(tD):
        if tEntete[i] in dico.keys():
            dico[tEntete[i]]+=";"+e
        else :
            dico[tEntete[i]]=e
print(dico)