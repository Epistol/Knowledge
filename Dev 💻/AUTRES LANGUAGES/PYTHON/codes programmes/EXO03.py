from anydbm import *
import dbm
if __name__ == '__main__' :
    dbmfile = dbm.open("testfilename.txt",'c')
    dbmfile['F1'] = 'Orange'
    dbmfile['F2'] = 'Abricot'
    close()
