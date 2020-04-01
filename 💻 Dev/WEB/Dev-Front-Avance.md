# DEV FRONT AVANCÉ

Il y a un glossaire et une page de ressources à la fin.  \ N’hésitez pas à la remplir et la compléter ;)

## Introduction ECMAScript
### Points historiques



*   Brendan EICH → créateur du JS, ancien de Mozilla/Netscape. vers 1995
*   vrai nom du JavaScript à l’origine = LiveScript → à l’époque, le Java était un langage très répandu dont le nom a été emprunté pour intéresser les développeurs contemporains du LiveScript (Le JavaScript est donc purement un terme marketing)
*   Le JS a été inventé en quelques jours, d’où de nombreuses failles au début.

L’**ECMAScript** est un _standard_

→ “standard” : signifie validé par un comité comprenant un certains nombres d’acteurs

→ standard = avantage car synonyme de pérennité du fait des problématiques hors contexte industriel et commerciales


Depuis l’apparition de **node.js** (2009), l’ECMAScript a gagné en popularité et connaît une évolution rapide depuis plusieurs années.

→ node.js : produit open-source qui fait fonctionner la machine virtuelle appartenant à Google (V8), issu de la volonté d’ajouter des fonctionnalités “I/O” (input/output) qui dépasseraient le cadre d’un navigateur, tout en utilisant la syntaxe JS

→ node.js = VM (V8) + I//O (C++)

→ avantage majeur : code asynchrone, cad exécution de plusieurs processus simultanés en fonction du temps minimum requis par chaque processus et non en fonction de l’ordre d’apparition des processus

<span style="text-decoration:underline;"><span style="text-decoration:underline;">Remarque</span> : l’asynchronisme a permis la création du cloud computing (= [réplication](https://fr.wikipedia.org/wiki/R%C3%A9plication_(informatique)) des données pour accès rapide)

## Contexte d’évaluation d’ECMAScript

- Browser : JavaScript + interface graphique

- NodeJS : Outils sans interface graphique


Pour évaluer ECMAScript, nécessitait d’utiliser une machine virtuelle pour compiler le code dynamiquement en binaire (contrairement au langages comme le C qui nécessite une compilation manuelle).

Pour tous les langages utilisant une machine virtuelle, le code est compilé à la volée (voir Just in time). Le code est découpé en séquences répétées, analysé puis transformé en code machine.

Il est important de ne pas inscrire de logique dans le template HTML (Model) puisque ce rôle revient au Controller (représenté par ES); de même pour le style CSS (Vue).

DOM = standard du W3C au même titre que HTML et CSS. Permet de connecter HTML, CSS et ES.

La logique métier c’est les Controllers, une série de Controllers permet d’expliquer les logiques métiers de l’application (dur à expliquer).

 

## Fonctionnement d’une machine virtuelle

Les machines virtuelles fonctionnent sur des threads; dans le cas de l’ECMAScript, la machine virtuelle est “mono-threadé” : on ne peut pas lire ET écrire simultanément dans le même espace. Il y a donc un cycle permanent de rafraîchissement où chaque cycle doit se terminer pour permettre un nouveau rafraîchissement de la page.  \
→ 2 choses peuvent bloquer ce thread : trop d’éléments dans le DOM ou bien scripts lourds.

Programmation multi-thread -> très difficile, raison => il peut arriver qu’on écrive en même temps qu’on lise un même espace mémoire

Au début du cycle, VM lit le code pour le transformer en code machine jusqu’à fin d’un premier cycle pour générer DOM. Ce cycle a un taux de rafraîchissement environ égal à 60 fps (idéalement) = on essaie de tendre vers ce taux en optimisant le code.

// TIPS // Pour calculer le taux de rafraîchissement : 


```js
      let start = new Date()
      setInterval(
        function () {
          const end = new Date()
          console.log(end - start)
          start = end
        }, 0,
      )

```

## Callstack/ Pile d’appel

Cycle de fonctions utilisé pour emmagasiner plusieurs valeurs et garder une trace de l’endroit où chaque fonction retourne à la fin de son exécution 

[https://www.youtube.com/watch?v=PG9oKZdFb7w](https://www.youtube.com/watch?v=PG9oKZdFb7w) => la stack en américain

[https://blog.sessionstack.com/how-does-javascript-actually-work-part-1-b0bacc073cf](https://blog.sessionstack.com/how-does-javascript-actually-work-part-1-b0bacc073cf)

Génération du DOM, parsing CSS, exécution des scripts = synchrone, ce qui peut être bloquant → d’où la bonne pratique de déclarer ses scripts après le DOM.  \
→ deux nouveaux attributs `async` et `defer` : [http://www.growingwiththeweb.com/2014/02/async-vs-defer-attributes.html](http://www.growingwiththeweb.com/2014/02/async-vs-defer-attributes.html)

## Variables

Stockage d’une variable avec mot-clé `var` (et let) et valeur associée. Ex : var i = 2;

2 fonctionnalités d’une variable :

*   espace de stockage défini (`const`)
*   espace de stockage que l’on va faire varier 


 
**!**L’opérateur d’affectation `=` a plusieurs fonctionnalités en fonction des types de données affectées

*   primitives : chaîne, booléen, nombre, undefined, null
*   complexes : array, object, function

Avec les valeurs primitives, les valeurs sont copiées dans la mémoire

Ex : var i = 1; var j = i; i++; console.log(i, j) ⇒ réponse : i est égal à 2, j est égal à 1 \
Avec les valeurs complexes, on affecte une variable à une référence.

En ES, un array est de type ‘object’, ainsi lorsqu’on assigne une valeur de type array (=> object), on assigne en réalité la référence vers cet objet.

Ex: var i = [1,2] ; var j = i ; i.push(3); console.log(j) ⇒ i et j sont égaux à [1,2,3]

Ainsi, afin d’éviter des effets non désirés, on utilise en programmation fonctionnelle le concept d”’immutability”, qui implique que les fonctions retournent toujours un nouvel objet afin d’éviter de changer la référence, potentiellement utilisée à plusieurs endroits dans le code.

## Portée des variables

Portée = contexte d’évaluation des variables.

Deux types de valeurs en ES : global et local. \
→ affecter des variables globales est une mauvaise pratique

En ES5, pour faire en sorte qu’une variable reste locale, il faut la définir au sein d’une fonction (function). \
De façon à protéger l’ensemble des variables, on utilise les IIFE (Immediately Invoked Function Expression) ou Self Invoking Function, qui ne sont instanciées qu’une seule fois (singleton) :

( function() { … } )();  

<span style="text-decoration:underline;"><span style="text-decoration:underline;">Notion de **closure**</span> : chaque fonction crée un espace enclos propre et <span style="text-decoration:underline;"><span style="text-decoration:underline;">persistant</span> qu’on appelle closure. Cette closure est accessible par les espaces enclos créés à l’intérieur de celle-ci (closures “enfants”).

<span style="text-decoration:underline;"><span style="text-decoration:underline;">Namespace (en ES5)</span> : permet de partager un état / fonctionnalités à l’ensemble de l’application (tous les scripts partageront ce même objet).
	
```js
let hetic = hetic || {};
```
	
Puis dans la IIFE : 
```js
(function() 

{

  // ici on peut définir des variables / functions qui appartiendront à l’objet/namespace hetic qui sera partagé aux scripts appelés plus tard.

    hetic.test = ‘test’;

    hetic.testFunc = function(){};

});
```
! un des désavantages majeurs est que cela nécessite de conserver l’ordre d’appel des scripts



---


# Workflow ECMAScript

## Node & NPM

### Node



1. Installation
*   Homebrew ( [https://brew.sh/index_fr.html](https://brew.sh/index_fr.html) )
2. Appel de fichier js
*   taper dans la console et dans le dossier projet : node [nom du fichier.js]
*   (ou taper seulement node pour passer en mode REPL (Read Eval Print Loop))

<span style="text-decoration:underline;"><span style="text-decoration:underline;">NPM</span>



1. Installation
2. Initialisation d’un projet
*   créer un répertoire
*   taper “npm init” et suivre les instructions pour créer le package.json : bien renseigner la version du projet*

* **Notes pour la création d’un projet ES :**


*   <span style="text-decoration:underline;"><span style="text-decoration:underline;">Gestion de versions</span> : suivant le schéma SemVer (Semantic Versioning), les noms de version sont indiqués comme suit : [Majeure] . [Mineure] . [Patch] 

Ex : version 8.9.2 = version majeure 8, mineure 9, patch n°2


*   La license MIT est une licence open-source très permissive qui permet donc de modifier à souhait le projet (cf. [https://opensource.org/licenses](https://opensource.org/licenses))

<span style="text-decoration:underline;"><span style="text-decoration:underline;">Installation/désinstallation de package via npm (en local)</span>


```bash
npm install "nom du package" --save 
npm uninstall "nom du package" --save
```


`--save` rajoute le package au fichier package.json

On peut également utiliser `--save-dev` si le package est utilisé comme outil de développement

**<span style="text-decoration:underline;"><span style="text-decoration:underline;">Browserify</span>**

`npm install -g browserify` 

Installation globale avec `-g`, mais on peut dupliquer l’installation dans le dossier projet avec `--save` pour que le package soit inscrit dans le package.json

Pour utiliser browserify, on tape la commande suivante : 


```bash
browserify [mon fichier.js] -o [nom du fichier sortie.js]
```


`-o` correspond à l’option qui signifie “output”

Quel est l’intérêt ? → on peut utiliser “require” et les différents packages dans le navigateur. Sans cela, c’est impossible.

Pour corriger le problème : `zsh: command not found: browserify` (si package globale uniquement) :

[https://stackoverflow.com/questions/14803978/npm-global-path-prefix](https://stackoverflow.com/questions/14803978/npm-global-path-prefix)

**<span style="text-decoration:underline;"><span style="text-decoration:underline;">UglifyJS</span>**


```bash
npm install -g uglifyjs
```


installation global avec -g, faire une duplication dans le dossier en local. 

Ne pas oublier d’utiliser **<span style="text-decoration:underline;"><span style="text-decoration:underline;">uglifyify</span>** pour que browserify interprète uglify. 

Lancer la commande suivante : 


```bash
browserify -g uglifyify ./main.js > bundle.js 
```


**<span style="text-decoration:underline;"><span style="text-decoration:underline;">Babel (babelify dans l’exemple du cours avec Browserify) ``</span>**

Dans un premier temps, installer le package babel-preset-env (pour gérer compilation es6 à es5).


```bash
npm install --save-dev babel-preset-env
```


Dans un second temps, installer les packages babelify (pont babel vers browserify)et babel-core.


```bash
npm install --save-dev babelify babel-core
```


Puis lancer la commande suivante :


```bash
browserify main.js -o bundle.js -t [ babelify --presets [ env ] ]
```


**<span style="text-decoration:underline;"><span style="text-decoration:underline;">NPM Scripts</span>**

Dans le fichier `package.json`, on peut ajouter des commandes npm et configurer les actions à effectuer au lancement de npm (npm start)  \
ex : `"start": "browserify [mon fichier.js] -o [nom du fichier sortie.js]"`

**<span style="text-decoration:underline;"><span style="text-decoration:underline;">Exporter/modulariser du code grâce à l’objet module.exports</span>**

Utile pour exporter son propre code réutilisable, et permet de faire des déclarations publiques.

Permet de partager des modules de code au reste de l’application.

En exportant une fonction comme dans l’exemple dessous, on exporte une référence à la fonction.

Ex: 
```js
  var add = function(a, b) {
    return a + b;
  };
  module.exports = {
    add: add
  };
```


En programmation fonctionnelle on utilise le terme de composition (currying est une des formes de la composition), qui permet d’appeler plusieurs petits bouts de codes (code modulaire) comme dans l’exemple suivant :


```js
var divide = function(a, b) {
  return a / b;
};

// Les fichiers qui importent la fonction divideByTen auront accès à la fonction divide de ce module sans pouvoir l'appeler directement.

module.exports = {
  divideByTen: function(a) {
    return divide(a, 10);
  }
};
```


## LESS

## POO
Historiquement, avec la création du C (langage), les développeurs ont créé les fonctions pour factoriser du code. Cependant, cela ne suffisait pas et on a donc créé classes (packages, soit des groupes de fonctions ) à partir desquels on crée des objets.

Entre la classe et l’objet, on trouve l’instanciation, c’est-à-dire la création d’un nouvel objet (avec `new`) selon cette classe.

Ex. : `var a = new maClasse();`

 `    a.couleur = #000; ` → Ajout d’une propriété, qui n’interfère pas avec la class

La classe est un “template”, un ensemble de règles qui définit l’objet, mais à laquelle on va pouvoir ajouter d’autres règles grâce aux opérations. 

Une classe est constituée de propriétés (primitives ou complexes) et de méthodes (fonctions). Tous les objets instanciés auront le même template de propriétés. Ainsi quand on ajoute des propriétés à un objet on ne modifie pas le modèle de la classe a priori.

L’orienté objet ne prend son sens que lorsqu’on applique des design patterns pour structurer nos applications. Voir livre Design Patterns Tête la première

### Principes de la POO

#### 1 - L’héritage

D’un parent découle un enfant et toutes les propriétés du parent sont transmises à l’enfant pour éviter la redondance. C’est une façon de dupliquer son code de façon moins “encombrante”.

D’autres termes synonymes : spécialisation, dérivation. (à compléter)
#### 2 - L’encapsulation

Protection de l’accès de certaines valeurs pour qu’elles ne soient pas modifiables au delà du but auquel elles étaient allouées lors de leur création.

Rien n’empêche d’accéder/modifier une propriété d’un objet (par convention, on ajoute un “_” devant un attribut privé -> ‘`_roues = 4`’) . De plus comme en ES les variables ne sont pas typées, il faut dans les méthodes accesseurs vérifier le type de valeur (nombre, chaîne, booléen etc).

Il existe plusieurs types de méthodes accesseurs : 



*   explicites ( `audi.setRoues()` )"
*   object.defineProperties permet de défnir des accesseurs implicites : utilisant la virtual machine pour analyser les permissions d’écriture notamment

La fonction Object.defineProperties permet de créer des <span style="text-decoration:underline;"><span style="text-decoration:underline;">propriétés en lecture seule</span>par exemple : 

ex: 


```js
var student = {name: Steeuve}; 
Object.defineProperties(student, {
  "address": {
    "value": "27 bis rue due Progrès"
    "writable": false // writable: false -> address = propriété privée
  }
}); 	
```


Conserver l’encapsulation du code est important afin d’assurer la pérennité du code.

Attention à ne pas “briser l’encapsulation”, donner la possibilité de modifier une référence (array / object) en dehors des accesseurs.

ex :


```js
var maternelle = {
  eleves: [],
  getEleves: function() { // ici on retourne une référence au array eleves
     return this.eleves;
  },
  setEleve: function(eleve) {
    if (typeof eleve === 'string') {
      this.eleves.push(eleve);
    }
  }
};
maternelle.getEleves().push(true); // brisage d'encapsulation -> on a modifié la référence eleves.

// afin d'éviter cette faille, on peut utiliser la fonction Array.prototype.concat() qui retourne un nouvel array conservant ainsi l'encapsulation (beaucoup utilisé en programmation fonctionnelle).
…
getEleves: function() {
  return this.eleves.concat(); // on crée un nouvel array qui contient déja les nouvelles valeurs 
},
...
```


#### 3 - Polymorphisme

Signature de méthode : composition entre le nom d’une fonction, ses paramètres et son type de retour

**Le polymorphisme se base sur une signature de méthode identique pour effectuer des opérations internes différentes.** 

Exemple : 
```js
var Character = function(name) {
	// fonction constructor, est appelée à l'instanciation d'un objet
	this.name = name;
	this.move = function() {
    // mauvaise utilisation de la classe, car la VM réassigne des 
        registres pour une méthode move à chaque fois qu'on instancie un objet Character.	
    }
    this.x = 0;
    this.y = 0;
};

// Il faut utiliser le prototype pour pointer vers une même méthode partagée entre les instances de Character
Character.prototype.move = function(x, y) {
this.x += x;
this.y += y;
};

var Policeman = function(name) {
	this.name = name;
	// En ES6 : super(name)
	Character.apply(this, [name]);
	Character.call(this, name);
};

//Créer un clone de la valeur passée en paramètre mais en sens unique (seulement de Character vers Policeman, sinon problème de référence again)
// Ne pas écrire Policeman.prototype = new Character(); !!!
// ecrire Policeman.prototype = Character.prototype revient à copier la référence, on ne pourra pas ajouter de propriété pour Policeman sans affecter le prototype de Character.
Policeman.prototype = Object.create(Character.prototype);
Policeman.prototype.move = function(x, y) {
	console.log('Je bouge comme un Policeman'); 
this.x += x;
this.y += y;
};

var Thief = function(name){
	Character.apply(this, [name]);
};

Thief.prototype = Object.create(Character.prototype);
Thief.prototype.move = function(x, y) {
	console.log(this.name + "bouge masqué");
this.x += x;
this.y += y;
};

var Pedestrian = function(name){
	Character.apply(this, [name]);
};

Pedestrian.prototype = Object.create(Character.prototype);

var Game = function() {
	this.chars = [];
}

// méthode accesseur addCharacter
Game.prototype.addCharacter = function( c ) {
	if ( c instanceof Character ) { // Downcasting dangereux
		this.chars.push( c );
	}
}

Game.prototype.start = function() {
	var self = this; // permet d'avoir accès aux propriétés de Game (closure)
	this.int_id = setInterval(function() {
		var c;
		for (var i = 0, l=self.chars.length; i<l; i++) {
    	c = self.chars[i];
    	c.move(10, 8); // <---- POLYMORPHISME
    }
}, 500)
};

Game.prototype.stop = function() {
	clearInterval(this.int_id);
};
```


Pour lancer le jeu :


```js
var gameoflife = new Game();
gameoflife.start();
gameoflife.addCharacter(new Pedestrian("wilsaï"));
az
```


**!** Si un élément n’est pas dans un contexte objet, alors le this fait référence à l’objet Global Window


```js
var f = function() {
 console.log(this); // log l'objet Window
};
```


#### 4 - Composition

Possibilité d’associer un objet dans un autre. Exemple granularité forte : Policeman (voir 3.Polymorphisme) -> dépend de Character fortement.

Le but de la POO ( -> Avoir la granularité la plus légère possible (des objets les + indépendants possibles).

Ex Composition:


```js
var Moteur = function(carburant) {
  this.carburant = carburant;
};

var Voiture = function(carburant) {
  this.moteur = new Moteur(carburant);
};

Voiture.prototype.setMoteur = function(moteur) {
  this.moteur = moteur;
};
```

## Node & Meteor js

[http://ericpriou.net/formations/meteor/fr/](http://ericpriou.net/formations/meteor/fr/)

Meteor met en avant le principe d’isomorphisme -> même forme.

<span style="text-decoration:underline;"><span style="text-decoration:underline;">Pattern utilisé régulièrement utilisé jusqu’à 2011:</span>

Côté serveur :

*   couche de persistance (base de donnée)
*   Routing => accéder à du contenu
*   Controller -> Couche métier
*   Vue (générée dans le back-end)  => Template de vue (sera affiché au client)

<span style="text-decoration:underline;"><span style="text-decoration:underline;">Pattern post-2011:</span>

Client (partie applicative) => Single Page Application:

*   DOM Manipulation
*   UX
*   View Layer
*   Application logic
*   Routing

Back-end:

*   Persistence

<span style="text-decoration:underline;"><span style="text-decoration:underline;">Avec Meteor:</span>

Backend:


*   Persistence

Client:



*   DOM Manipulaiton
*   UX

Shared: 

*   View Layer
*   Application Logic
*   Routing

Meteor -> partager gestion de la vue, logique de l’application et le routing entre les deux couches front-end et back-end => D’où le terme isomorph. C’est entre autre un outil de scaffolding qui permet de créer une structure de base facilement, prête pour le développement et pour le déploiement. (avec la commande : meteor create {nom du projet})

Websocket : canal ouvert de façon permanente (port 80 = Port réservé requêtes HTTP) pour faire de l’échange de données en temps réel entre le client et le serveur.

#### Premier Principe: Isomorphisme

#### Deuxième principe: One language (JavaScript)

Cordova - > instancie au sein de l’application native une webview (DOM standard sans les boutons d’interaction propres au mobile)

La webview utilise un bridge de communication entre la partie native et la partie HTML => Ce qui permettra à l’application d’avoir accès à des fonctionnalités uniquement réservées aux applications natives - comme l’appareil photo, accéder aux contacts, accéder à la galerie photo de l’utilisateur, la boussole etc. (et ce par le biais de l’objet “camera”)

Pour utiliser mongoDB, sur un environnement METEOR, il suffit de faire à la racine de notre projet : meteor mongo 

(Show collections pour voir les tables)

#### Insérer des données

Pour insérer des données dans l’HTML, il faut créer des templates et les appeler grâce à des partials: 


```vue
<body>
	<h1>Liste</h1>
	{{students_ui}}
</body>

<template name="students_ui">
	<ul>
		{{#each all_students}}
		<li>{{name}}</li>
		{{/each}}
	</ul>
</template>
```


Et dans le `main.js`, il faut créer un lien entre les données et la variables `all_students` :


```js
Template.students_ui.helpers
(
    {
          all_students : function ()
 {
	return students.find();
     }  
    }
    );
```


Pour empêcher le client d’envoyer des données dans la base de donnée il faut retirer le package autopublish : 

meteor remove autopublish

## Sujets exercices JS



1. React.js
2. Meteor.js tutos (avec React.js)
3. Nodeschool → Projet Git-it pour apprendre et se perfectionner avec Git
4. Conception d’une application de gestion des élèves : gestion des profils, des compétences et des notes obtenues. Conception = wireframes, parcours utilisateurs etc.

**<span style="text-decoration:underline;"><span style="text-decoration:underline;">Exposés</span>**

**<span style="text-decoration:underline;"><span style="text-decoration:underline;">Sécurité de Meteor</span>**

Par défaut, non sécurisé : le client peut interagir avec la base de données.  \
1) Pour empêcher cela, deux packages à enlever : `autopublish` et `insecure`

2) Pour plus de sécurité : `allow` (false) + `deny` (true) 

3) Mais du coup, il faut rétablir le CRUD. \
Pour la lecture des données (read) : `publish` (côté server/) + `subscribe`(côté client/ pour pouvoir accéder aux données de la bdd)

Pour modifier/supprimer/ajouter : création de `méthodes` pour chaque action que l’on veut faire dans la base de données, tout en vérifiant le type de données, rôles d’utilisateur etc.

**<span style="text-decoration:underline;"><span style="text-decoration:underline;">Git / Github</span>**

Git = outil pour gestion de versions local ≠ Github = service, pour partager son travail et que les autres puissent le récupérer

**<span style="text-decoration:underline;"><span style="text-decoration:underline;">Meteor et sa structure applicative</span>**

Eager loading : chargement de tous les fichiers au démarrage de l’application.

Lazy loading : attend une action de l’utilisateur pour charger les fichiers nécessaires.

Toute la logique se trouve dans le dossier /imports

imports/startup : fichiers appelés au démarrage



**<span style="text-decoration:underline;"><span style="text-decoration:underline;">GLOSSAIRE</span>**

_(à compléter et définir)_

ECMAScript

Réplication

Asynchrone

Virtualisation 

Load Balancer (répartition de charges)

Downcasting

Scalability 

Cloud

Callback

**Machine virtuelle** : surcouche interprétant le code fourni pour qu’il soit lu/accessible sur n’importe quelle autre machine en convertissant dynamiquement le code en code machine

Single Page Application 

**Terminal :** application ouvrir shell

**Shell :** piloter système d’exploitation sans interface graphique (ligne de commande)

**Variable :** espace de stockage définit directement sur la RAM

**IIFE :** Immediately Invoked Function Expression (ou Self Invoking Function)

Closure

Namespace

Mutabilité

**Workflow :** dynamique de travail. Un bon workflow permet la pérennité de la codebase (code source)

Minification

**Composition** : réutilisation de différentes fonctions afin d’arriver à des fonctions modulaires et atomiques

**Downcasting**: Caster (vérifications, appels de méthodes) sur la Super Class (parent).

**Isomorphisme** : iso = même, morphisme = forme. L’un des principes utilisé par Meteor. Même logique et vues en front et en back. 1 seul code exécuté soit côté client, soit côté serveur, soit les deux.

**Réactivité** (framework) : modification automatique de l’interface graphique (vue) lors que les données évoluent en base de données (model), mise en place de la programmation fonctionnelle adaptée aux interfaces graphiques.

**Websocket** :  canal ouvert de façon permanente (port 80 = Port réservé requêtes HTTP) pour faire de l’échange de données en temps réel entre le client et le serveur.

**Partial** : Insertion d’un bloc de texte à l’intérieur du HTML


## RESSOURCES

[https://codecombat.com/](https://codecombat.com/) 

[https://scratch.mit.edu/projects/editor/?tip_bar=getStarted](https://scratch.mit.edu/projects/editor/?tip_bar=getStarted) 

Pour s’entraîner ! Si vous galérez un peu en JS :) 

Design Patterns - Tête la première :  [https://github.com/Symfomany/poo/blob/master/cours/Design%20patterns%20-%20T%C3%AAte%20la%20premi%C3%A8re.pdf](https://github.com/Symfomany/poo/blob/master/cours/Design%20patterns%20-%20T%C3%AAte%20la%20premi%C3%A8re.pdf) (pff…)

**<span style="text-decoration:underline;"><span style="text-decoration:underline;">METEOR</span>**
