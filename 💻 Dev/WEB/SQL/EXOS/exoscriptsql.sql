CREATE database 'TableU';

Create table 'utilisateur' (
'pseudo' varchar(45),
'nom' varchar(45),
'mdp' char(32),

PRIMARY KEY ('pseudo')
);

Create table 'message' (
'id' int(11),
'contenu' varchar(512),
'dateHeureEnvoi' DATETIME,
'expediteur' VARCHAR(45),
'destinataire' VARCHAR(45),

PRIMARY KEY ('id'),

CONSTRAINT 'fk-expedit-pseudo' FOREIGN KEY 'expediteur' 
	REFERENCES 'utilisateur' ('pseudo'),
    
CONSTRAINT 'fk-dest-pseudo' FOREIGN KEY 'destinataire' 
	REFERENCES 'utilisateur' ('pseudo')
  
);


CREATE table 'droits' (
'nomdroit' char(6),
'droit' char(1)
)




_________


GRANT 
	ALL PRIVILEGES
	ON msg.utilisateur
    TO mzuckerberg;
    
REVOKE
	SELECT (mdp)
    ON msg
	FROM mzuckerberg;
    
GRANT
	ALL privileges
    ON msg.message
    TO czisac;
    
grant
	SELECT
	ON msg.utilisateur
    TO www;
    
GRANT 
	SELECT, INSERT
    ON msg.message;
    TO www;
    
    
    
