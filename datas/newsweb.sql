-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- H�te : sql8614.phpnet.org:3306
-- G�n�r� le : mar. 31 mai 2022 � 14:18
-- Version du serveur : 10.3.34-MariaDB-1:10.3.34+maria~buster-log
-- Version de PHP : 7.3.31-1~deb10u1

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de donn�es : `newsweb`
--
DROP DATABASE IF EXISTS `newsweb`;
CREATE DATABASE IF NOT EXISTS `newsweb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `newsweb`;

-- --------------------------------------------------------

--
-- Structure de la table `permission`
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `idpermission` tinyint(3) UNSIGNED NOT NULL,
  `permissionname` varchar(45) NOT NULL,
  `permissionrole` tinyint(3) UNSIGNED NOT NULL COMMENT '0 => admin\n1 => contributor\n2 => commentator'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- D�chargement des donn�es de la table `permission`
--

INSERT INTO `permission` (`idpermission`, `permissionname`, `permissionrole`) VALUES
(1, 'Administrateur', 0),
(2, 'R�dacteur', 1),
(3, 'Membre', 2);

-- --------------------------------------------------------

--
-- Structure de la table `thearticle`
--

DROP TABLE IF EXISTS `thearticle`;
CREATE TABLE `thearticle` (
  `idthearticle` int(10) UNSIGNED NOT NULL,
  `thearticletitle` varchar(120) NOT NULL,
  `thearticleslug` varchar(120) NOT NULL,
  `thearticleresume` varchar(250) NOT NULL,
  `thearticletext` text NOT NULL,
  `thearticledate` datetime DEFAULT current_timestamp(),
  `thearticleactivate` tinyint(4) DEFAULT 0 COMMENT '0 => waiting\n1 => publish\n2 => deleted',
  `theuser_idtheuser` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- D�chargement des donn�es de la table `thearticle`
--

INSERT INTO `thearticle` (`idthearticle`, `thearticletitle`, `thearticleslug`, `thearticleresume`, `thearticletext`, `thearticledate`, `thearticleactivate`, `theuser_idtheuser`) VALUES
(1, 'Quoi de neuf dans PHP 8.1 : Fonctionnalit�s, changements, am�liorations et plus encore', 'quoi-de-neuf-dans-php-8-1-fonctionnalites-changements-ameliorations-et-plus-encore', 'Dans cet article, nous allons couvrir en d�tail les nouveaut�s de PHP 8.1.', 'Types d�intersection purs\r\nPHP 8.1 ajoute la prise en charge des types d�intersection. C�est similaire aux types d�union introduits dans PHP 8.0, mais leur utilisation pr�vue est exactement l�inverse.\r\n\r\nPour mieux comprendre son utilisation, rafra�chissons la fa�on dont les d�clarations de type fonctionnent en PHP.\r\n\r\nEssentiellement, vous pouvez ajouter des d�clarations de type aux arguments des fonctions, aux valeurs de retour et aux propri�t�s des classes. Cette affectation est appel�e indication de type et garantit que la valeur est du bon type au moment de l�appel. Sinon, une TypeError est imm�diatement �mise. En retour, cela vous aide � mieux d�boguer le code.\r\n\r\nCependant, la d�claration d�un type uniques a ses limites. Les types d�union vous aident � surmonter cela en vous permettant de d�clarer une valeur avec plusieurs types, et l�entr�e doit satisfaire au moins un des types d�clar�s.\r\n\r\nD�autre part, la RFC d�crit les types d�intersection comme ceci :\r\n\r\nUn � type d�intersection � exige qu�une valeur satisfasse plusieurs contraintes de type au lieu d�une seule.\r\n\r\n�les types d�intersection purs sont sp�cifi�s � l�aide de la syntaxe T1&T2&� et peuvent �tre utilis�s dans toutes les positions o� les types sont actuellement accept�s�\r\n\r\nNotez l�utilisation de l�op�rateur & (AND) pour d�clarer les types d�intersection. En revanche, nous utilisons l�op�rateur | (OR) pour d�clarer les types d�union.\r\n\r\nL�utilisation de la plupart des types standard dans un type d�intersection donnera un type qui ne pourra jamais �tre rempli (par exemple, integer et string). Par cons�quent, les types d�intersection ne peuvent inclure que des types de classe (c�est-�-dire des interfaces et des noms de classe).\r\n\r\nVoici un exemple de code montrant comment vous pouvez utiliser les types d�intersection :\r\n<pre>\r\nclasse A {\r\n    private Traversable&Countable $countableIterator;\r\n \r\n    public function setIterator(Traversable&Countable $countableIterator) : void {\r\n        $this->countableIterator = $countableIterator;\r\n    }\r\n \r\n    public function getIterator() : Traversable&Countable {\r\n        retourne $this->countableIterator;\r\n    }\r\n}</pre>\r\nDans le code ci-dessus, nous avons d�fini une variable countableIterator comme une intersection de deux types : Traversable et Countable. Dans ce cas, les deux types d�clar�s sont des interfaces.\r\n\r\nLes types d�intersection sont �galement conformes aux r�gles standard de variance PHP d�j� utilis�es pour la v�rification des types et l�h�ritage. Mais il existe deux r�gles suppl�mentaires concernant la fa�on dont les types d�intersection interagissent avec le sous-typage. Vous pouvez en savoir plus sur les r�gles de variance des types d�intersection dans sa RFC.\r\n\r\nDans certains langages de programmation, vous pouvez combiner les types Union et les types Intersection dans la m�me d�claration. Mais PHP 8.1 l�interdit. C�est pourquoi sa mise en �uvre est appel�e types d�intersection � purs �. Cependant, la RFC mentionne que c�est � laiss� comme une scope future �\r\n\r\nEnums\r\nPHP 8.1 ajoute enfin la prise en charge des enums (�galement appel�s �num�rations ou types �num�r�s). Il s�agit d�un type de donn�es d�fini par l�utilisateur, compos� d�un ensemble de valeurs possibles.\r\n\r\nL�exemple d��num�ration le plus courant dans les langages de programmation est le type bool�en, avec true et false comme deux valeurs possibles. C�est tellement courant qu�il est int�gr� dans de nombreux langages de programmation modernes.\r\n\r\nConform�ment � la RFC, les �num�rations en PHP seront limit�es aux � �num�rations d�unit�s � au d�part :\r\n\r\nLa port�e de cette RFC est limit�e aux � �num�rations d�unit�s �, c�est-�-dire aux �num�rations qui sont elles-m�mes une valeur, plut�t qu�une simple syntaxe fantaisiste pour une constante primitive, et qui n�incluent pas d�informations associ�es suppl�mentaires. Cette capacit� offre une prise en charge consid�rablement �largie pour la mod�lisation des donn�es, les d�finitions de types personnalis�es et le comportement de style monade. Les Enums permettent la technique de mod�lisation consistant � � rendre les �tats non valides irrepr�sentables �, ce qui conduit � un code plus robuste n�cessitant moins de tests exhaustifs.\r\n\r\nPour arriver � ce stade, l��quipe PHP a �tudi� de nombreux langages qui prennent d�j� en charge les �num�rations. Leur �tude a r�v�l� que l�on peut classer les �num�rations en trois groupes g�n�raux : Constantes fantaisistes, objets fantaisistes et types de donn�es alg�briques (ADT) complets. C�est une lecture int�ressante !\r\n\r\nPHP impl�mente les �num�rations � Fancy Objects �, et pr�voit de les �tendre aux ADT complets � l�avenir. Il est conceptuellement et s�mantiquement model� sur les types �num�r�s de Swift, Rust et Kotlin, bien qu�il ne soit pas directement model� sur aucun d�entre eux.\r\n\r\nLa RFC utilise la c�l�bre analogie des couleurs dans un jeu de cartes pour expliquer son fonctionnement :\r\n<pre>\r\nenum Suit {\r\ncase Hearts;\r\ncase Diamonds;\r\ncase Clubs;\r\ncase Spades;</pre>\r\n\r\nIci, l�enum Suit d�finit quatre valeurs possibles : Hearts, Diamonds, Clubs et Spades. Vous pouvez acc�der directement � ces valeurs en utilisant la syntaxe : Suit::Hearts, Suit::Diamonds, Suit::Clubs, et Suit::Spades.\r\n\r\nCette utilisation peut vous sembler famili�re, car les enums sont construits au-dessus des classes et des objets. Ils se comportent de mani�re similaire et ont presque les m�mes exigences. Les enums partagent les m�mes espaces de noms que les classes, les interfaces et les traits.\r\n\r\nLes enums mentionn�s ci-dessus sont appel�s Pure Enums.\r\n\r\nVous pouvez aussi d�finir des Enums Backed si vous voulez donner une valeur scalaire �quivalente � n�importe quel cas. Cependant, les backed enums ne peuvent avoir qu�un seul type, soit int soit string (jamais les deux).\r\n<pre>\r\nenum Suit: string {\r\ncase Hearts = \'H\';\r\ncase Diamonds = \'D\';\r\ncase Clubs = \'C\';\r\ncase Spades = \'S\';\r\n}</pre>\r\nDe plus, tous les diff�rents cas d�un backed enum doivent avoir une valeur unique. Et vous ne pouvez jamais m�langer les enums purs et backed.\r\n\r\nLa RFC approfondit les m�thodes d��num�ration, les m�thodes statiques, les constantes, les expressions constantes et bien plus encore. Les couvrir tous d�passe le cadre de cet article. Vous pouvez vous r�f�rer � la documentation pour vous familiariser avec toutes ses qualit�s.\r\n\r\nLe type de retour never\r\nPHP 8.1 ajoute un nouvel indice de type de retour appel� never. C�est tr�s utile pour les fonctions throw ou exit.\r\n\r\nSelon la RFC, les fonctions de redirection d�URL exit (explicitement ou implicitement) sont un bon exemple de son utilisation :\r\n<pre>\r\nfunction redirect(string $uri) : never {\r\n    header(\'Location : \' . $uri) ;\r\n    exit() ;\r\n}\r\n \r\nfonction redirectToLoginPage() : never {\r\n    redirect(\'/login\');\r\n}</pre>\r\n\r\nUne fonction d�clar�e never doit satisfaire trois conditions :\r\n\r\nL�instruction return ne doit pas �tre d�finie explicitement.\r\nL�instruction return ne doit pas �tre d�finie implicitement (par exemple, les instructions if-else).\r\nElle doit terminer son ex�cution avec une d�claration exit (explicitement ou implicitement).\r\nL�exemple de redirection d�URL ci-dessus montre une utilisation � la fois explicite et implicite du type de retour never.\r\n\r\nLe type never return partage de nombreuses similitudes avec le type void return. Ils garantissent tous deux que la fonction ou la m�thode ne renvoie pas de valeur. Cependant, il diff�re en appliquant des r�gles plus strictes. Par exemple, une fonction d�clar�e void peut toujours return sans valeur explicite, mais vous ne pouvez pas faire la m�me chose avec une fonction d�clar�e never.\r\n\r\nEn r�gle g�n�rale, utilisez void lorsque vous voulez que PHP continue � s�ex�cuter apr�s l�appel de la fonction. Choisissez never lorsque vous voulez le contraire.\r\n\r\nDe plus, never est d�fini comme un type � inf�rieur �. Par cons�quent, toute m�thode de classe d�clar�e never ne peut � jamais � changer son type de retour en quelque chose d�autre. Cependant, vous pouvez �tendre une m�thode d�clar�e void avec une m�thode d�clar�e never.\r\n\r\nInfo\r\nLa RFC originale indique le type de retour never comme noreturn, qui �tait un type de retour d�j� pris en charge par deux outils d�analyse statique de PHP, � savoir Psalm et PHPStan. Comme il a �t� propos� par les auteurs de Psalm et PHPStan eux-m�mes, ils ont conserv� sa terminologie. Cependant, en raison des conventions de nommage, l��quipe PHP a r�alis� un sondage sur noreturn vs never, dont never est sorti vainqueur. Par cons�quent, pour les versions PHP 8.1+, remplace toujours noreturn par never.', '2022-05-06 14:29:57', 1, 2),
(2, 'Javascript : H�ritage et cha�ne de prototype', 'javascript-heritage-et-chaine-de-prototype', 'JavaScript peut pr�ter � confusion lorsqu\'on est habitu� � manipuler des langages de programmation manipulant les classes (tels que Java ou C++).', 'JavaScript peut pr�ter � confusion lorsqu\'on est habitu� � manipuler des langages de programmation manipulant les classes (tels que Java ou C++).\r\n\r\nEn effet, JavaScript est un langage dynamique et ne poss�de pas de concept de classe � part enti�re (le mot-cl� class a certes �t� ajout� avec ES2015 mais il s\'agit uniquement de sucre syntaxique, JavaScript continue de reposer sur l\'h�ritage prototypique).\r\n\r\nEn ce qui concerne l\'h�ritage, JavaScript n\'utilise qu\'une seule structure : les objets. Chaque objet poss�de une propri�t� priv�e qui contient un lien vers un autre objet appel� le prototype. \r\n\r\nCe prototype poss�de �galement son prototype et ainsi de suite, jusqu\'� ce qu\'un objet ait null comme prototype. Par d�finition, null ne poss�de pas de prototype et est ainsi le dernier maillon de la cha�ne de prototype.\r\n\r\nLa majorit� des objets JavaScript sont des instances de Object qui est l\'avant dernier maillon de la cha�ne de prototype.\r\n\r\nBien que cette confusion (entre classe et prototype) soit souvent avanc�e comme l\'une des faiblesses de JavaScript, le mod�le prototypique est plus puissant que le mod�le classique et il est notamment possible de construire un mod�le classique � partir d\'un mod�le prototypique.\r\n\r\n<h3>H�ritage et cha�ne de prototype</h3>\r\n<h4>Propri�t� h�rit�es</h4>\r\nLes objets JavaScript sont des ensembles dynamiques de propri�t�s (les propri�t�s directement rattach�es � un objet sont appel�es propri�t�s en propre (own properties)). \r\n\r\nLes objets JavaScript poss�dent �galement un lien vers un objet qui est leur prototype. Lorsqu\'on tente d\'acc�der aux propri�t�s d\'un objet, la propri�t� sera recherch�e d\'abord sur l\'objet m�me, puis sur son prototype, puis sur le prototype du prototype et ainsi de suite jusqu\'� ce qu\'elle soit trouv�e ou que la fin de la cha�ne de prototype ait �t� atteinte.\r\n\r\n<pre>let f = function () {\r\n   this.a = 1;\r\n   this.b = 2;\r\n}\r\nlet o = new f(); // {a: 1, b: 2}\r\n\r\n// on ajoute des propri�t�s au prototype de la fonction\r\n// f\r\nf.prototype.b = 3;\r\nf.prototype.c = 4;</pre>', '2022-05-09 15:30:50', 1, 2),
(3, 'Programmation orient�e objet', 'programmation-orientee-objet', 'La programmation orient�e objet (POO), ou programmation par objet, est un paradigme de programmation informatique. \r\n\r\nElle consiste en la d�finition et l&#039;interaction de briques logicielles appel�es objets ; un objet repr�sente un concept, u', 'La programmation orient�e objet (POO), ou programmation par objet, est un paradigme de programmation informatique. \r\n\r\nElle consiste en la d�finition et l&#039;interaction de briques logicielles appel�es objets ; un objet repr�sente un concept, une id�e ou toute entit� du monde physique, comme une voiture, une personne ou encore une page d&#039;un livre. \r\n\r\nIl poss�de une structure interne et un comportement, et il sait interagir avec ses pairs. Il s&#039;agit donc de repr�senter ces objets et leurs relations ; l&#039;interaction entre les objets via leurs relations permet de concevoir et r�aliser les fonctionnalit�s attendues, de mieux r�soudre le ou les probl�mes. \r\n\r\nD�s lors, l&#039;�tape de mod�lisation rev�t une importance majeure et n�cessaire pour la POO. C&#039;est elle qui permet de transcrire les �l�ments du r�el sous forme virtuelle.\r\n\r\nLa programmation par objet consiste � utiliser des techniques de programmation pour mettre en �uvre une conception bas�e sur les objets. \r\n\r\nCelle-ci peut �tre �labor�e en utilisant des m�thodologies de d�veloppement logiciel objet, dont la plus connue est le processus unifi� (� Unified Software Development Process � en anglais), et exprim�e � l&#039;aide de langages de mod�lisation tels que le Unified Modeling Language (UML).\r\n\r\nLa programmation orient�e objet est facilit�e par un ensemble de technologies d�di�s :\r\n\r\nles langages de programmation (chronologiquement : Simula, LOGO, Smalltalk, Ada, C++, Objective C, Eiffel, Python, PHP, Java, Ruby, AS3, C#, VB.NET, Fortran 2003, Vala, Haxe, Swift) ;\r\nles outils de mod�lisation qui permettent de concevoir sous forme de sch�mas semi-formels la structure d&#039;un programme (Objecteering, UMLDraw, Rhapsody, DBDesigner�) ;\r\nles bus distribu�s (DCOM, CORBA, RMI, Pyro�) ;\r\n\r\nles ateliers de g�nie logiciel ou AGL (Visual Studio pour des langages Dotnet, NetBeans ou Eclipse pour le langage Java).\r\nIl existe actuellement deux grandes cat�gories de langages � objets :\r\n\r\nles langages � classes, que ceux-ci soient sous forme fonctionnelle (Common Lisp Object System), imp�rative (C++, Java) ou les deux (Python, OCaml) ;\r\nles langages � prototypes (JavaScript, Lua).\r\n\r\nEn implantant les Record Class de Hoare, le langage Simula 67 pose les constructions qui seront celles des langages orient�s objet � classes : classe, polymorphisme, h�ritage, etc. Mais c&#039;est r�ellement par et avec Smalltalk 71 puis Smalltalk 80, inspir� en grande partie par Simula 67 et Lisp, que les principes de la programmation par objets, r�sultat des travaux d&#039;Alan Kay, sont v�hicul�s : objet, encapsulation, messages, typage et polymorphisme (via la sous-classification) ; les autres principes, comme l&#039;h�ritage, sont soit d�riv�s de ceux-ci ou une implantation. Dans Smalltalk, tout est objet, m�me les classes. Il est aussi plus qu&#039;un langage � objets, c&#039;est un environnement graphique interactif complet.\r\n\r\n� partir des ann�es 1980, commence l&#039;effervescence des langages � objets : C++ (1983), Objective-C (1984), Eiffel (1986), Common Lisp Object System (1988), etc. Les ann�es 1990 voient l&#039;�ge d&#039;or de l&#039;extension de la programmation par objets dans les diff�rents secteurs du d�veloppement logiciel.\r\n\r\nDepuis, la programmation par objets n&#039;a cess� d&#039;�voluer aussi bien dans son aspect th�orique que pratique et diff�rents m�tiers et discours mercatiques � son sujet ont vu le jour :\r\n\r\nl&#039;analyse objet (AOO ou OOA en anglais) ;\r\nla conception objet (COO ou OOD en anglais) ;\r\nles bases de donn�es objet (SGBDOO) ;\r\nles langages objets avec les langages � prototypes ;\r\nou encore la m�thodologie avec MDA (Model Driven Architecture).\r\nAujourd&#039;hui, la programmation par objets est vue davantage comme un paradigme, le paradigme objet, que comme une simple technique de programmation. C&#039;est pourquoi, lorsque l&#039;on parle de nos jours de programmation par objets, on d�signe avant tout la partie codage d&#039;un mod�le � objets obtenu par AOO et COO.\r\n\r\nLa programmation orient�e objet a �t� introduite par Alan Kay avec Smalltalk. Toutefois, ses principes n&#039;ont �t� formalis�s que pendant les ann�es 1980 et, surtout, 1990. Par exemple le typage de second ordre, qui qualifie le typage de la programmation orient�e objet (appel� aussi duck typing), n&#039;a �t� formul� qu&#039;en 1995 par Cook.\r\n\r\nConcr�tement, un objet est une structure de donn�es qui r�pond � un ensemble de messages. Cette structure de donn�es d�finit son �tat tandis que l&#039;ensemble des messages qu&#039;il comprend d�crit son comportement :\r\n\r\nles donn�es, ou champs, qui d�crivent sa structure interne sont appel�es ses attributs ;\r\nl&#039;ensemble des messages forme ce que l&#039;on appelle l&#039;interface de l&#039;objet ; c&#039;est seulement au travers de celle-ci que les objets interagissent entre eux. La r�ponse � la r�ception d&#039;un message par un objet est appel�e une m�thode (m�thode de mise en �uvre du message) ; elle d�crit quelle r�ponse doit �tre donn�e au message.\r\nCertains attributs et/ou m�thodes (ou plus exactement leur repr�sentation informatique) sont cach�s : c&#039;est le principe d&#039;encapsulation. Ainsi, le programme peut modifier la structure interne des objets ou leurs m�thodes associ�es sans avoir d&#039;impact sur les utilisateurs de l&#039;objet.\r\n\r\nUn exemple avec un objet repr�sentant un nombre complexe : celui-ci peut �tre repr�sent� sous diff�rentes formes (cart�sienne (r�el, imaginaire), trigonom�trique, exponentielle (module, angle)). Cette repr�sentation reste cach�e et est interne � l&#039;objet. L&#039;objet propose des messages permettant de lire une repr�sentation diff�rente du nombre complexe. En utilisant les seuls messages que comprend notre nombre complexe, les objets appelants sont assur�s de ne pas �tre affect�s lors d&#039;un changement de sa structure interne. Cette derni�re n&#039;est accessible que par les m�thodes des messages.\r\n\r\nDans la programmation par objets, chaque objet est typ�. Le type d�finit la syntaxe (� Comment l&#039;appeler ? �) et la s�mantique des messages (� Que fait-il ? �) auxquels peut r�pondre un objet. Il correspond donc, � peu de chose pr�s, � l&#039;interface de l&#039;objet. Toutefois, la plupart des langages objets ne proposent que la d�finition syntaxique d&#039;un type (C++, Java, C#�) et rares sont ceux qui fournissent aussi la possibilit� de d�finir formellement sa s�mantique (comme dans le langage Eiffel avec sa conception par contrats).\r\n\r\nUn objet peut appartenir � plus d&#039;un type : c&#039;est le polymorphisme ; cela permet d&#039;utiliser des objets de types diff�rents l� o� est attendu un objet d&#039;un certain type. Une fa�on de r�aliser le polymorphisme est le sous-typage (appel� aussi h�ritage de type) : on raffine un type-parent en un autre type (le sous-type) par des restrictions sur les valeurs possibles des attributs. Ainsi, les objets de ce sous-type sont conformes au type parent. De ceci d�coule le principe de substitution de Liskov. Toutefois, le sous-typage est limit� et ne permet pas de r�soudre le probl�me des types r�cursifs (un message qui prend comme param�tre un objet du type de l&#039;appelant). Pour r�soudre ce probl�me, Cook d�finit en 1995 la sous-classification et le typage du second ordre qui r�git la programmation orient�e objet : le type est membre d&#039;une famille polymorphique � point fixe de types (appel�e classe). Les traits sont une fa�on de repr�senter explicitement les classes de types. (La repr�sentation peut aussi �tre implicite comme avec Smalltalk, Ruby, etc.).\r\n\r\nOn distingue dans les langages objets deux m�canismes du typage :\r\n\r\nle typage dynamique : le type des objets est d�termin� � l&#039;ex�cution lors de la cr�ation desdits objets (Smalltalk, Common Lisp, Python, PHP�) ;\r\nle typage statique : le type des objets est v�rifi� � la compilation et est soit explicitement indiqu� par le d�veloppeur lors de leur d�claration (C++, Java, C#, Pascal�), soit d�termin� par le compilateur � partir du contexte (Scala, OCaml�).\r\nDe m�me, deux m�canismes de sous-typage existent : l&#039;h�ritage simple (Smalltalk, Java, C#) et l&#039;h�ritage multiple (C++, Python, Common Lisp, Eiffel, WLangage).\r\n\r\nLe polymorphisme ne doit pas �tre confondu avec le sous-typage ou avec l&#039;attachement dynamique (dynamic binding en anglais).\r\n\r\nLa programmation objet permet � un objet de raffiner la mise en �uvre d&#039;un message d�fini pour des objets d&#039;un type parent, autrement dit de red�finir la m�thode associ�e au message : c&#039;est le principe de red�finition des messages (ou overriding en anglais).\r\n\r\nOr, dans une d�finition stricte du typage (typage du premier ordre), l&#039;op�ration r�sultant d&#039;un appel de message doit �tre la m�me quel que soit le type exact de l&#039;objet r�f�r�. Ceci signifie donc que, dans le cas o� l&#039;objet r�f�r� est de type exact un sous-type du type consid�r� dans l&#039;appel, seule la m�thode du type p�re est ex�cut�e :\r\n\r\nSoit un type Reel contenant une m�thode * faisant la multiplication de deux nombres r�els, soient Entier un sous-type de Reel, i un Entier et r un Reel, alors l&#039;instruction i * r va ex�cuter la m�thode * de Reel. On pourrait appeler celle de Entier gr�ce � une red�finition.\r\n\r\nPour r�aliser alors la red�finition, deux solutions existent :\r\n\r\nle typage du premier ordre associ� � l&#039;attachement dynamique (c&#039;est le cas de C++, Java, C#�). Cette solution induit une faiblesse dans le typage et peut conduire � des erreurs. Les relations entre type sont d�finies par le sous-typage (th�orie de Liskov) ;\r\nle typage du second ordre (duquel d�coulent naturellement le polymorphisme et l&#039;appel de la bonne m�thode en fonction du type exact de l&#039;objet). Ceci est possible avec Smalltalk et Eiffel. Les relations entre types sont d�finies par la sous-classification (th�orie F-Bound de Cook).\r\n\r\nLa structure interne des objets et les messages auxquels ils r�pondent sont d�finis par des modules logiciels. Ces m�mes modules cr�ent les objets via des op�rations d�di�es. Deux repr�sentations existent de ces modules : la classe et le prototype.\r\n\r\nLa classe est une structure informatique particuli�re dans le langage objet. Elle d�crit la structure interne des donn�es et elle d�finit les m�thodes qui s&#039;appliqueront aux objets de m�me famille (m�me classe) ou type. Elle propose des m�thodes de cr�ation des objets dont la repr�sentation sera donc celle donn�e par la classe g�n�ratrice. Les objets sont dits alors instances de la classe. C&#039;est pourquoi les attributs d&#039;un objet sont aussi appel�s variables d&#039;instance et les messages op�rations d&#039;instance ou encore m�thodes d&#039;instance. L&#039;interface de la classe (l&#039;ensemble des op�rations visibles) forme les types des objets. Selon le langage de programmation, une classe est soit consid�r�e comme une structure particuli�re du langage, soit elle-m�me comme un objet (objet non-terminal). Dans le premier cas, la classe est d�finie dans le runtime ; dans l&#039;autre, la classe a besoin elle aussi d&#039;�tre cr��e et d�finie par une classe : ce sont les m�ta-classes. L&#039;introspection des objets (ou � m�ta-programmation �) est d�finie dans ces m�ta-classes.\r\n\r\nLa classe peut �tre d�crite par des attributs et des messages. Ces derniers sont alors appel�s, par opposition aux attributs et messages d&#039;un objet, variables de classe et op�rations de classe ou m�thodes de classe. Parmi les langages � classes on retrouve Smalltalk, C++, C#, Java, etc.\r\n\r\nLe prototype est un objet � part enti�re qui sert de prototype de d�finition de la structure interne et des messages. Les autres objets de m�mes types sont cr��s par clonage. Dans le prototype, il n&#039;y a plus de distinction entre attributs et messages : ce sont tous des slots. Un slot est un label de l&#039;objet, priv� ou public, auquel est attach�e une d�finition (ce peut �tre une valeur ou une op�ration). Cet attachement peut �tre modifi� � l&#039;ex�cution. Chaque ajout d&#039;un slot influence l&#039;objet et l&#039;ensemble de ses clones. Chaque modification d&#039;un slot est locale � l&#039;objet concern� et n&#039;affecte pas ses clones.\r\n\r\nLe concept de trait permet de modifier un slot sur un ensemble de clones. Un trait est un ensemble d&#039;op�rations de m�me cat�gorie (clonage, persistance, etc.) transverse aux objets. Il peut �tre repr�sent� soit comme une structure particuli�re du langage, comme un slot d�di� ou encore comme un prototype. L&#039;association d&#039;un objet � un trait fait que l&#039;objet et ses clones sont capables de r�pondre � toutes les op�rations du trait. Un objet est toujours associ� � au moins un trait, et les traits sont les parents des objets (selon une relation d&#039;h�ritage). Un trait est donc un mixin dot� d&#039;une parent�. Parmi les langages � prototype on trouve Javascript, Self, Io, Slater, Lisaac, etc.\r\n\r\nDiff�rents langages utilisent la programmation orient�e objet, par exemple PHP, Python, etc.\r\n\r\nEn PHP la programmation orient�e objet est souvent utilis�e pour mettre en place une architecture MVC (Mod�le Vue Contr�leur), o� les mod�les repr�sentent des objets.\r\n\r\nLa mod�lisation objet consiste � cr�er un mod�le du syst�me informatique � r�aliser. Ce mod�le repr�sente aussi bien des objets du monde r�el que des concepts abstraits propres au m�tier ou au domaine dans lequel le syst�me sera utilis�.\r\n\r\nLa mod�lisation objet commence par la qualification de ces objets sous forme de types ou de classes sous l&#039;angle de la compr�hension des besoins et ind�pendamment de la mani�re dont ces classes seront mises en �uvre. C&#039;est ce que l&#039;on appelle l&#039;analyse orient�e objet ou OOA (acronyme de � Object-Oriented Analysis �). Ces �l�ments sont alors enrichis et adapt�s pour repr�senter les �l�ments de la solution technique n�cessaires � la r�alisation du syst�me informatique. C&#039;est ce que l&#039;on appelle la conception orient�e objet ou OOD (acronyme de � Object-Oriented Design �). � un mod�le d&#039;analyse peuvent correspondre plusieurs mod�les de conception. L&#039;analyse et la conception �tant fortement interd�pendants, on parle �galement d&#039;analyse et de conception orient�e objet (OOAD). Une fois un mod�le de conception �tabli, il est possible aux d�veloppeurs de lui donner corps dans un langage de programmation. C&#039;est ce que l&#039;on appelle la programmation orient�e objet ou OOP (en anglais � Object-Oriented Programming �).\r\n\r\nPour �crire ces diff�rents mod�les, plusieurs langages et m�thodes ont �t� mis au point. Ces langages sont pour la plupart graphiques. Les trois principaux � s&#039;imposer sont OMT de James Rumbaugh, la m�thode Booch de Grady Booch et OOSE de Ivar Jacobson. Toutefois, ces m�thodes ont des s�mantiques diff�rentes et ont chacune des particularit�s qui les rendent particuli�rement aptes � certains types de probl�mes. \r\n\r\nOMT offre ainsi une mod�lisation de la structure de classes tr�s �labor�e. Booch a des facilit�s pour la repr�sentation des interactions entre les objects. OOSE innove avec les cas d&#039;utilisation pour repr�senter le syst�me dans son environnement. La m�thode OMT pr�vaut sur l&#039;ensemble des autres m�thodes au cours de la premi�re partie de la d�cennie 1990.\r\n\r\n� partir de 1994, Booch et Jacobson, rapidement rejoints par Rumbaugh, d�cident d&#039;unifier leurs approches au sein d&#039;une nouvelle m�thode qui soit suffisamment g�n�rique pour pouvoir s&#039;appliquer � la plupart des contextes applicatifs. Ils commencent par d�finir le langage de mod�lisation UML (Unified Modeling Language) appel� � devenir un standard de l&#039;industrie. Le processus de normalisation est confi� � l&#039;Object Management Group (OMG), un organisme destin� � standardiser des technologies orient�es objet comme CORBA (acronyme de � Common Object Request Broker Architecture �), un intergiciel (� middleware � en anglais) objet r�parti.\r\n\r\n Rumbaugh, Booch et Jacobson s&#039;affairent �galement � mettre au point une m�thode permettant d&#039;une mani�re syst�matique et r�p�table d&#039;analyser les exigences et de concevoir et mettre en �uvre une solution logicielle � l&#039;aide de mod�les UML. Cette m�thode g�n�rique de d�veloppement orient� objet devient le processus unifi� (�galement connu sous l&#039;appellation anglo-saxonne de � Unified Software Development Process �). Elle est it�rative et incr�mentale, centr�e sur l&#039;architecture et guid�e par les cas d&#039;utilisation et la r�duction des risques. Le processus unifi� est de plus adaptable par les �quipes de d�veloppement pour prendre en compte au mieux les particularit�s du contexte.\r\n\r\nN�anmoins pour un certain nombre de concepteurs objet, dont Bertrand Meyer, l&#039;inventeur du langage orient� objet Eiffel, guider une mod�lisation objet par des cas d&#039;utilisations est une erreur de m�thode qui n&#039;a rien d&#039;objet et qui est plus proche d&#039;une m�thode fonctionnelle. Pour eux, les cas d&#039;utilisations sont rel�gu�s � des utilisations plut�t annexes comme la validation d&#039;un mod�le par exemple.\r\n\r\nTest', '2022-05-09 15:38:03', 1, 2),
(4, 'Tuto : appeler une API en PHP (r�ponses en JSON)', 'tuto-appeler-une-api-en-php-reponses-en-json', 'Dans ce petit tutoriel, je vais vous montrer comment d�velopper une application en PHP appelant une API qui va r�cup�rer le r�sultat de la requ�te en JSON', 'Les API sur Internet\r\n\r\nLes API sont un moyen d�acc�der aux donn�es d�un site sans avoir l�autorisation d�acc�der directement � la base de donn�es. Il y a beaucoup de portails s�curis�s permettant � vos applications web de manipuler les donn�es renvoy�es par ces sites.\r\n\r\nL�exemple parfait est Twitter, c�est d�ailleurs l�API de Twitter que nous allons utiliser dans ce tuto. Elle permet de lire la timeline d�une personne en particulier, de rechercher des statuts � partir d�un mot cl�, de modifier les param�tres de votre compte, etc. Nous nous limiterons � la partie la plus simple et facile � mettre en place pour introduire les API.\r\n\r\nPourquoi choisir JSON ?\r\n\r\nVous pouvez utiliser les API avec de nombreux langages et retourner les donn�es de plusieurs fa�ons. L�une d�elles est le JSON (JavaScript Object Notation). C�est un format de donn�es l�ger, facile � lire et � �crire et compatible avec pas mal de langages de d�veloppement. Sa structure est compos�e d�objets et de tableaux. Sa flexibilit� fait de JSON le parfait candidat pour retourner des donn�es.\r\n\r\nStructure du projet\r\n\r\nNotre application web va afficher les Tweets contenant le mot cl� de votre choix. La limite est de 10 tweets mais elle est param�trable lors de l�appel de l�API.\r\n\r\nLe projet va tourner autour de 2 fichiers : index.php dans lequel il y aura le formulaire de recherche et resultat.php dans lequel plusieurs actions seront effectu�es. Nous y reviendrons un peu plus tard. Il y a �galement un dossier nomm� cache qui contiendra les fichiers .json contenant les r�sultats des recherches. C�est un syst�me de cache tr�s simple bas� sur des fichiers. Il existe bien d�autres m�thodes de mise en cache (base de donn�es). A vous de voir ce qui vous convient le mieux.', '2022-05-13 11:51:21', 1, 1),
(5, 'Param�tres IMAP, POP et SMTP', 'parametres-imap-pop-et-smtp', 'Informations g�n�rales\r\nPOP ou IMAP ?\r\nPour lire vos e-mails depuis votre ordinateur, un smartphone ou une tablette, il existe deux protocoles :\r\n\r\nPOP : permet de lire les courriers �lectronique sur un seul appareil (les e-mails sont t�l�charg?', 'Informations g�n�rales\r\nPOP ou IMAP ?\r\nPour lire vos e-mails depuis votre ordinateur, un smartphone ou une tablette, il existe deux protocoles :\r\n\r\nPOP : permet de lire les courriers �lectronique sur un seul appareil (les e-mails sont t�l�charg�s sur votre ordinateur et supprim�s du serveur).\r\nIMAP : permet de lire les courriers �lectroniques sur plusieurs appareils.\r\nNous vous recommandons d�utiliser le protocole IMAP dans tous les cas figure.\r\n\r\nSSL, TLS, StartTLS ?\r\nSSL, et son rempla�ant TLS, sont des protocoles de chiffrement qui permettent d�emp�cher un tiers d�intercepter les donn�es transitant sur un r�seau.\r\nDans le cadre des serveurs de messagerie, cela vous garanti que votre mot de passe ou vos e-mails ne peuvent pas �tre intercept�s par une personne malveillante lorsque vous vous connectez sur nos serveurs pour lire ou envoyer des e-mails.\r\n\r\nVotre mot de passe peut toujours �tre d�rob� via un virus install� sur votre ordinateur, ou encore via un page de phishing.\r\n\r\nStartTLS, pour faire simple, est un moyen d�utiliser une connexion chiffr�e, sur un port normalement r�serv� � une connexion non chiffr�e. Si le serveur ne propose pas de chiffrement, la connexion sera quand m�me �tablie, mais non chiffr�e.\r\nCela permet de simplifier la configuration des logiciels de messagerie et indirectement de favoriser le chiffrement des connexions.', '2022-05-25 11:57:38', 1, 2),
(6, 'PHP 8.2 apportera de nouvelles fonctionnalit�s et les am�liorations de performances', 'php-8-2-apportera-de-nouvelles-fonctionnalits-et-les-amliorations-de-performances', 'PHP 8.2 sera probablement publi� � la fin de 2022, mais aucune date n&#039;a encore �t� fix�e. De nouvelles fonctionnalit�s, les am�liorations de performances, les modifications et les d�pr�ciations sont attendues.\r\n\r\nLes techniquement null ', 'PHP 8.2 sera probablement publi� � la fin de 2022, mais aucune date n&#039;a encore �t� fix�e. De nouvelles fonctionnalit�s, les am�liorations de performances, les modifications et les d�pr�ciations sont attendues.\r\n\r\nLes techniquement null et false pourraient �tre consid�r�s comme des types valides par eux-m�mes. Les exemples courants sont les fonctions int�gr�es de PHP, o� false est utilis� comme type de retour en cas d&#039;erreur. Par exemple, dans file_get_contents :\r\n\r\nCode :\r\n\r\nfile_get_contents(/* � */): string|false\r\n\r\nNotons que l&#039;utilisation de false dans un type union �tait d�j� possible ; mais en PHP 8.2, il peut �tre utilis� comme un type autonome :\r\n\r\nCode :\r\n\r\nfunction alwaysFalse(): false\r\n{\r\nreturn false;\r\n}\r\n\r\nSelon Brent Roose, de nombreux d�veloppeurs, dont lui-m�me, sont un peu m�fiants en regardant la RFC qui traite de True et False. � Elle ne prend pas en charge true en tant que type autonome, et les types ne devraient-ils pas repr�senter des cat�gories plut�t que des valeurs individuelles ? �, s�interroge-t-il. � Il s&#039;av�re qu&#039;il existe un concept appel� type unitaire dans les syst�mes de types, qui sont des types qui ne permettent qu&#039;une seule valeur. Mais est-ce vraiment utile, et est-ce que cela encourage la conception de logiciels propres ? Peut-�tre, peut-�tre pas. �, ajoute-til. Un type null autonome est un peu plus logique : null peut �tre consid�r� comme une cat�gorie en soi et pas seulement comme une valeur dans une cat�gorie.\r\n\r\nMod�le d&#039;objet null\r\n\r\nCode :\r\n\r\nclass Post\r\n{\r\npublic function getAuthor(): ?string { /* � */ }\r\n}\r\n\r\nclass NullPost extends Post\r\n{\r\npublic function getAuthor(): null { /* � */ }\r\n}\r\n\r\nIl est logique que NullPost::getAuthor() puisse dire qu&#039;il ne retournera jamais que null, au lieu de null ou string, ce qui n&#039;�tait pas possible auparavant.\r\n\r\nBrent Roose recommande d��viter d&#039;utiliser false comme un type autonome pour transmettre un �tat d&#039;erreur � je pense qu&#039;il y a de meilleures solutions pour r�soudre de tels probl�mes. �\r\n\r\nD�pr�ciation des propri�t�s dynamiques\r\n\r\nLes propri�t�s dynamiques sont d�pr�ci�es en PHP 8.2, et l�veront une ErrorException en PHP 9.0. Rappelons que les propri�t�s dynamiques sont des propri�t�s qui ne sont pas pr�sentes sur un objet, mais qui sont n�anmoins d�finies ou obtenues :\r\n\r\nCode :\r\n\r\nclass Post\r\n{\r\npublic string $title;\r\n}\r\n\r\n// �\r\n\r\n$post-&gt;name = &#039;Name&#039;;\r\n\r\nLes classes impl�mentant __get et __set fonctionneront toujours comme pr�vu :\r\n\r\nCode :\r\n\r\nclass Post\r\n{\r\nprivate array $properties = [];\r\n\r\npublic function __set(string $name, mixed $value): void\r\n{\r\n$this-&gt;properties[$name] = $value;\r\n}\r\n}\r\n\r\n// �\r\n\r\n$post-&gt;name = &#039;Name&#039;;\r\n\r\nPour Brent Roose, le PHP �tait autrefois un langage tr�s dynamique, mais il s&#039;est �loign� de cet �tat d&#039;esprit depuis un certain temps d�j�. Ce dernier pense que c&#039;est une bonne chose d&#039;adopter des r�gles plus strictes et de s&#039;appuyer sur l&#039;analyse statique partout o� cela est possible, car cela permet aux d�veloppeurs d&#039;�crire un meilleur code.\r\n\r\nRedact les param�tres dans les traces\r\n\r\nUne pratique courante dans toute base de code est d&#039;envoyer les erreurs de production � un service qui en garde la trace et notifie les d�veloppeurs lorsque quelque chose ne va pas. Cette pratique implique souvent l&#039;envoi de traces de pile par c�ble � un service tiers. Il y a cependant des cas o� ces traces de pile peuvent inclure des informations sensibles telles que des variables d&#039;environnement, des mots de passe ou des noms d&#039;utilisateur.\r\n\r\nPHP 8.2 permet de marquer ces � param�tres sensibles � avec un attribut, de sorte que l&#039;utilisateur n&#039;ait pas � se soucier de leur pr�sence dans les piles de traces lorsque quelque chose ne va pas. Voici un exemple tir� de la RFC :\r\n\r\nCode :\r\n\r\nfunction test(\r\n$foo,\r\n#[SensitiveParameter] $bar,\r\n$baz\r\n) {\r\nthrow new Exception(&#039;Error&#039;);\r\n}\r\n\r\ntest(&#039;foo&#039;, &#039;bar&#039;, &#039;baz&#039;);\r\nFatal error: Uncaught Exception: Error in test.php:8\r\nStack trace:\r\n#0 test.php(11): test(&#039;foo&#039;, Object(SensitiveParameterValue), &#039;baz&#039;)\r\n#1 {main}\r\nthrown in test.php on line 8\r\n\r\nD�pr�ciation partielle support�e par les callables\r\n\r\nUn autre changement, bien qu&#039;ayant un impact l�g�rement plus faible, est que les callablespartiellement support�s sont maintenant d�pr�ci�s �galement. Les callables partiellement support�s sont des callables qui peuvent �tre appel�s en utilisant call_user_func($callable), mais pas en appelant $callable() directement. La liste de ces types de callablesest assez courte, d&#039;ailleurs :\r\n&quot;self::method&quot;\r\n&quot;parent::method&quot;\r\n&quot;static::method&quot;\r\n[&quot;self&quot;, &quot;method&quot;]\r\n[&quot;parent&quot;, &quot;method&quot;]\r\n[&quot;static&quot;, &quot;method&quot;]\r\n[&quot;Foo&quot;, &quot;Bar::method&quot;]\r\n[new Foo, &quot;Bar::method&quot;]\r\n\r\n\r\nLa raison de ce choix ? Pour certains programmeurs, il s&#039;agit l� d&#039;un pas dans la bonne direction vers la possibilit� d&#039;utiliser callable pour les propri�t�s typ�es. C&#039;est bien expliqu� dans la RFC :\r\n\r\n� tous ces callables sont d�pendants du contexte. La m�thode � laquelle self::method fait r�f�rence d�pend de la classe � partir de laquelle l&#039;appel ou la v�rification de callability est effectu�. En pratique, cela vaut �galement pour les deux derniers cas, lorsqu&#039;ils sont utilis�s sous la forme [new Foo, &quot;parent::method&quot;].\r\n\r\nLa r�duction de la d�pendance contextuelle des callables est l&#039;objectif secondaire de ce RFC. Apr�s cette RFC, la seule d�pendance de port�e qui reste est la visibilit� de la m�thode : Foo::bar peut �tre visible dans une port�e, mais pas dans une autre. Si les callables devaient �tre limit�s aux m�thodes publiques � l&#039;avenir (tandis que les m�thodes priv�es devraient utiliser des callables de premi�re classe ou Closure::fromCallable() pour �tre rendues ind�pendantes de la port�e), alors le type callable deviendrait bien d�fini et pourrait �tre utilis� comme un type de propri�t�. Cependant, les modifications de la gestion de la visibilit� ne sont pas propos�es dans le cadre de ce RFC. �', '2022-05-31 10:44:10', 1, 1),
(7, 'La premi�re version EAP de RubyMine 2022.2 est disponible', 'la-premire-version-eap-de-rubymine-2022-2-est-disponible', 'A la mi-avril, JetBrains a annonc� la sortie de RubyMine 2022.1, la premi�re mise � jour majeure de cette ann�e pour son EDI pour le d�veloppement Web avec Ruby et Ruby on Rails. Au cas o� vous l&#039;aurez manqu�e, cette version a apport� un', 'A la mi-avril, JetBrains a annonc� la sortie de RubyMine 2022.1, la premi�re mise � jour majeure de cette ann�e pour son EDI pour le d�veloppement Web avec Ruby et Ruby on Rails. Au cas o� vous l&#039;aurez manqu�e, cette version a apport� un bon lot de nouveaut�s et am�liorations, y compris la prise en charge des nouvelles fonctionnalit�s Ruby et RBS, de nouvelles inspections et correctifs rapides, des am�liorations de l&#039;exp�rience utilisateur et bien plus.\r\n\r\nUn peu plus d&#039;un mois apr�s, JetBrains ouvre le programme d&#039;acc�s anticip� (EAP) � RubyMine 2022.2. Comme toujours, vous �tes invit�s � essayer les nouvelles fonctionnalit�s et faire des retours � JetBrains avant la sortie officielle. Mais avant, nous vous pr�sentons ici les principaux changements dans cette premi�re version EAP.\r\n\r\nD�bogueur\r\n\r\nJetBrains a am�lior� le d�bogueur de RubyMine pour le rendre plus robuste pour Ruby 3 et les versions ult�rieures du langage. � partir de cette version EAP, vous devriez �tre en mesure de d�boguer votre code Ruby 3 et d&#039;une version sup�rieure sans aucun probl�me majeur tout en utilisant toutes les fonctionnalit�s sophistiqu�es fournies dans l&#039;interface graphique. L&#039;�diteur de logiciels pour d�veloppeurs a �galement corrig� des probl�mes dans les impl�mentations pr�c�dentes du d�bogueur. Ainsi, si vous utilisez une ancienne version de Ruby (inf�rieure � 3.0), vous devriez �galement pouvoir d�boguer votre code dans RubyMine sans probl�me. Aucune action suppl�mentaire n&#039;est requise, car l&#039;EDI proposera automatiquement une impl�mentation de d�bogueur appropri�e.\r\n\r\nJetBrains a effectu� des tests internes pour d�terminer les performances du nouveau d�bogueur RubyMine lors de l&#039;ex�cution d&#039;un simple script Rails en mode d�bogage. Et l&#039;entreprise a d�couvert que ses performances sont proches du d�bogueur natif Ruby 3, sur lequel son nouveau d�bogueur est bas�. Les r�sultats varient de mani�re insignifiante en fonction du syst�me d&#039;exploitation, du processeur de la machine et du nombre de points d&#039;arr�t d�finis.\r\n\r\nL&#039;important est que, lors du d�bogage de configurations qui ont deux points d&#039;arr�t ou plus, le nouveau d�bogueur RubyMine est environ 5 fois plus rapide que le pr�c�dent pour Ruby 3, qui utilisait une impl�mentation open source .\r\n\r\nSelon les statistiques et enqu�tes de JetBrains, le d�bogueur de RubyMine est l&#039;une des fonctionnalit�s les plus utilis�es par les utilisateurs exp�riment�s. Ces am�liorations devraient donc �tre tr�s appr�ci�es.\r\n\r\nRBS\r\n\r\nDans cette version, JetBrains a continu� � am�liorer son support du langage RBS (Ruby Signature). � partir de cette version, les fonctionnalit�s de code insight de RubyMine v�rifient d�sormais les modificateurs de visibilit� public et private inline pour d�terminer la visibilit� des d�clarations d&#039;attributs et de m�thodes. JetBrains a �galement ajout� des modificateurs de visibilit� par m�thode � la vue Structure .', '2022-05-31 10:46:24', 1, 4),
(8, '5 mistakes that makes you a noob in PHP', '5-mistakes-that-makes-you-a-noob-in-php', 'Web Development is a huge industry itself in IT, And most of the time people start with PHP as a web developer. Teachers in colleges teach in a way such that students can understand the code and basics of scripting that how things work?\r\n\r\nBut as we ', 'Web Development is a huge industry itself in IT, And most of the time people start with PHP as a web developer. Teachers in colleges teach in a way such that students can understand the code and basics of scripting that how things work?\r\n\r\nBut as we grow, most of us not trying to learn the design pattern in PHP language, which makes the code base sucks! So, today I am going to show you what people think and what actually should happen while writing and managing code.\r\n\r\n#1 Using Lower Version of PHP\r\n\r\nThe first version was available sometime in early 1995 and was known as the Personal Home Page Tools. Later on 1st July 2004, PHP 5 was released. With this update, a lot of changes have been introduced. A lot of websites started to teach coding of PHP and features as well. But the most important thing in the history of programming is NULL safety, which destroyed and made a loss of millions of dollars.\r\n\r\nAs many developers were just newbies and never tried to figure out the other way + web development changes are being ignored due to high maintenance work, so these kinds of problems made developers switch to new projects without taking a break or upskilling, which cause a lot of outdated code in the world!\r\n\r\nPHP 8 has been introduced, but people still using lower versions like PHP 5. There are two reasons here:-\r\n\r\nPeople are lazy enough to upgrade the skills\r\nThey�re kind of stuck with the legacy codebase\r\nBut trust me PHP 7 introduced a lot of cool features, from PHP 7.3 (??) has introduced null safety through which we can avoid a lot of boilerplate conditions.\r\n\r\nFun Fact: MySql has been changed to Mysqli from PHP 5 and if(isset()) is changed to (??) for null safety in PHP 7, but people are still living in an imaginary world\r\n\r\n#2 No MVC Pattern in Core PHP\r\n\r\nPeople often have a complaint that they�re not able to structure Design Pattern out of the box and many articles and documentation don�t promote it. This makes confusion in the community about how to write code, which creates unstable code and creates conflicts.\r\n\r\nPeople include the connection.php file in every file and write queries on top of the PHP tag. Then starts while loop in HTML by opening and closing PHP tags in between. This is the traditional approach to writing code in PHP but can be improved by introducing class and object.\r\n\r\n#3 Handling Form Submission\r\n\r\nif(isset()) is used every time when we submit a form using the POST method. This is used to validate if the form really submitted or not, but this can be improved as well.\r\n\r\n#4 Using old syntax in newer versions\r\n\r\nNull safety is provided by almost every programming language nowadays, but people are not aware of it. They still use the old syntax of language which makes them write a lot of boilerplate code. This can be easily improved by following trends in working programming language and by referring latest answers in StackOverflow instead of the accepted ones.\r\n\r\nWe can use traits, constants, Inheritance, and Elvis Operator for null safety (??).\r\n\r\n#5 Not Using Laravel Framework\r\n\r\nIf you often feel stuck with core PHP, then it�s time to move to a new Powerful Framework called Laravel. It provides a lot of cool libraries and features out of the box. The framework makes life a lot easy and teaches us how to write well-maintained code.\r\n\r\n# Using Nested MySQL queries in PHP Loop ~ Very Dangerous (Bonus Mistake)\r\n\r\nSuppose we have to fetch the result from the database and according to that result we fetch the child results using a while loop using a nested MySQL query.\r\n\r\nTrust me this practice is very harmful.\r\n\r\nHere I touched the point in more detail and in a very interesting way.\r\n\r\nSo, these were my observations and point of view regarding the subject. I have literally seen people repeating the same thing again and again, without even thinking about why I am doing a lot of stuff. They don�t even think about how to improve the code and make it work in a few lines in a debug-friendly way.\r\n\r\nTest-Driven Development is also very popular, but with core PHP it�s difficult to implement. So, as a developer, our duty is to write maintainable code and choose the right framework so that in the future the project can be well maintained. People already following the rat race, so be upgraded.\r\n\r\nThanks!', '2022-05-31 10:47:28', 1, 4);

-- --------------------------------------------------------

--
-- Structure de la table `thearticle_has_thecomment`
--

DROP TABLE IF EXISTS `thearticle_has_thecomment`;
CREATE TABLE `thearticle_has_thecomment` (
  `thearticle_idthearticle` int(10) UNSIGNED NOT NULL,
  `thecomment_idthecomment` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- D�chargement des donn�es de la table `thearticle_has_thecomment`
--

INSERT INTO `thearticle_has_thecomment` (`thearticle_idthearticle`, `thecomment_idthecomment`) VALUES
(1, 1),
(1, 2),
(1, 3),
(6, 4);

-- --------------------------------------------------------

--
-- Structure de la table `thecomment`
--

DROP TABLE IF EXISTS `thecomment`;
CREATE TABLE `thecomment` (
  `idthecomment` int(10) UNSIGNED NOT NULL,
  `theuser_idtheuser` int(10) UNSIGNED DEFAULT NULL,
  `thecommenttext` varchar(850) NOT NULL,
  `thecommentdate` datetime DEFAULT current_timestamp(),
  `thecommentactive` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 => waiting\n1 => publish\n2 => deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- D�chargement des donn�es de la table `thecomment`
--

INSERT INTO `thecomment` (`idthecomment`, `theuser_idtheuser`, `thecommenttext`, `thecommentdate`, `thecommentactive`) VALUES
(1, 1, 'PHP c\'est de la merde, vive Python !!!', '2022-05-06 16:23:10', 1),
(2, 2, 'Esp�ce de Troll va....', '2022-05-06 16:23:39', 1),
(3, 1, 'Mais non, m�me JS est plus lisible!', '2022-05-06 16:24:46', 1),
(4, 5, 'Je ne vois pas trop l\'int�r�t', '2022-05-31 10:49:51', 1);

-- --------------------------------------------------------

--
-- Structure de la table `theimage`
--

DROP TABLE IF EXISTS `theimage`;
CREATE TABLE `theimage` (
  `idtheimage` int(10) UNSIGNED NOT NULL,
  `theimagename` varchar(45) NOT NULL,
  `theimagetype` varchar(5) NOT NULL,
  `theimageurl` varchar(100) NOT NULL,
  `theimagetext` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `theimage_has_thearticle`
--

DROP TABLE IF EXISTS `theimage_has_thearticle`;
CREATE TABLE `theimage_has_thearticle` (
  `theimage_idtheimage` int(10) UNSIGNED NOT NULL,
  `thearticle_idthearticle` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `thesection`
--

DROP TABLE IF EXISTS `thesection`;
CREATE TABLE `thesection` (
  `idthesection` smallint(5) UNSIGNED NOT NULL,
  `thesectiontitle` varchar(60) NOT NULL,
  `thesectionslug` varchar(60) NOT NULL,
  `thesectiondesc` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- D�chargement des donn�es de la table `thesection`
--

INSERT INTO `thesection` (`idthesection`, `thesectiontitle`, `thesectionslug`, `thesectiondesc`) VALUES
(9, 'HTML', 'html', 'HTML signifie � HyperText Markup Language � qu\'on peut traduire par � langage de balises pour l\'hypertexte �. Il est utilis� afin de cr�er et de repr�senter le contenu d\'une page web et sa structure.'),
(10, 'CSS', 'css', 'CSS est l\'un des langages principaux du Web ouvert et a �t� standardis� par le W3C.'),
(11, 'Javascript', 'javascript', 'JavaScript est au c�ur des langages utilis�s par les d�veloppeurs web. Une grande majorit� des sites web l\'utilisent, et la majorit� des navigateurs web disposent d\'un moteur JavaScript5 pour l\'interpr�ter.'),
(12, 'PHP', 'php', 'PHP: Hypertext Preprocessor, plus connu sous son sigle PHP, est un langage de programmation libre, principalement utilis� pour produire des pages Web dynamiques via un serveur HTTP.'),
(13, 'SQL', 'sql', 'SQL est un langage informatique normalis� servant � exploiter des bases de donn�es relationnelles. La partie langage de manipulation des donn�es de SQL permet de rechercher, d\'ajouter, de modifier ou de supprimer des donn�es dans les bases de donn�es relationnelles.'),
(14, 'Algorithmie G�n�rale', 'algorithmie-generale', 'L\'algorithmique est l\'�tude et la production de r�gles et techniques qui sont impliqu�es dans la d�finition et la conception d\'algorithmes, c\'est-�-dire de processus syst�matiques de r�solution d\'un probl�me permettant de d�crire pr�cis�ment des �tapes pour r�soudre un probl�me algorithmique'),
(15, 'Programmation', 'programmation', 'La programmation, appel�e aussi codage dans le domaine informatique, d�signe l\'ensemble des activit�s qui permettent l\'�criture des programmes informatiques. C\'est une �tape importante du d�veloppement de logiciels.'),
(16, 'Autre', 'autre', 'A propos du d�veloppement web');

-- --------------------------------------------------------

--
-- Structure de la table `thesection_has_thearticle`
--

DROP TABLE IF EXISTS `thesection_has_thearticle`;
CREATE TABLE `thesection_has_thearticle` (
  `thesection_idthesection` smallint(5) UNSIGNED NOT NULL,
  `thearticle_idthearticle` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- D�chargement des donn�es de la table `thesection_has_thearticle`
--

INSERT INTO `thesection_has_thearticle` (`thesection_idthesection`, `thearticle_idthearticle`) VALUES
(9, 4),
(11, 2),
(11, 3),
(11, 4),
(12, 1),
(12, 3),
(12, 4),
(12, 6),
(12, 8),
(14, 3),
(14, 8),
(15, 1),
(15, 2),
(15, 3),
(15, 4),
(15, 6),
(15, 7),
(15, 8),
(16, 5),
(16, 7);

-- --------------------------------------------------------

--
-- Structure de la table `theuser`
--

DROP TABLE IF EXISTS `theuser`;
CREATE TABLE `theuser` (
  `idtheuser` int(10) UNSIGNED NOT NULL,
  `theuserlogin` varchar(60) NOT NULL,
  `theuserpwd` varchar(255) NOT NULL,
  `theusermail` varchar(255) NOT NULL,
  `theuseruniqid` varchar(255) NOT NULL,
  `theuseractivate` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '0 => inactive\n1 => active\n2 => ban',
  `permission_idpermission` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- D�chargement des donn�es de la table `theuser`
--

INSERT INTO `theuser` (`idtheuser`, `theuserlogin`, `theuserpwd`, `theusermail`, `theuseruniqid`, `theuseractivate`, `permission_idpermission`) VALUES
(1, 'admin', '$2y$10$vBhjRuKwxfK1AXnTzMUHXOP2KMhwdkWd1N3VflFJTCvoG7AUZh4r6', 'michaeljpitz@gmail.com', '626fa6578dd31', 1, 1),
(2, 'Pierre', '$2y$10$.08wH0aufWao2s0D2yn1d.tJyH1rYpK/o5KKb538/SZNj8S3m/n0C', 'pierre.sandron@cf2m.be', '626fa6bf4f026', 1, 2),
(3, 'util1', '$2y$10$2YZpDKfAbRN0F.UE/I5hweERIN3CyWmSpo.W6p.rfM/yzuOurYSri', 'onsenfout@cahit.com', '628744bece71e5.27321545', 1, 3),
(4, 'Mike', '$2y$10$YHCv0MJ/VuJJ8MoQUigWHeKljKs5ydtjlB90OUcqeM9S8CrcPr4SO', 'michael.j.pitz@gmail.com', '6295d3558946e5.48558155', 1, 2),
(5, 'util2', '$2y$10$9LmEM27UJ.QXeCe5t3RZx.TI8aWaBX2QNVumEeFgkCyv9eu2Kthke', 'm.ichaeljpitz@gmail.com', '6295d3889b45e3.24254396', 1, 3),
(6, 'somebodytolove', '$2y$10$WsfZufSN6NxSsXfxCgu3luUoMmX0R86RMMLXsjoQ0fT6Yoze5ImC6', 'test@test.be', '6295d3ce76a0f7.09276035', 1, 3);

--
-- Index pour les tables d�charg�es
--

--
-- Index pour la table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`idpermission`),
  ADD UNIQUE KEY `permissionname_UNIQUE` (`permissionname`);

--
-- Index pour la table `thearticle`
--
ALTER TABLE `thearticle`
  ADD PRIMARY KEY (`idthearticle`),
  ADD UNIQUE KEY `thearticleslug_UNIQUE` (`thearticleslug`),
  ADD KEY `fk_thearticle_theuser1_idx` (`theuser_idtheuser`);

--
-- Index pour la table `thearticle_has_thecomment`
--
ALTER TABLE `thearticle_has_thecomment`
  ADD PRIMARY KEY (`thearticle_idthearticle`,`thecomment_idthecomment`),
  ADD KEY `fk_thearticle_has_thecomment_thecomment1_idx` (`thecomment_idthecomment`),
  ADD KEY `fk_thearticle_has_thecomment_thearticle1_idx` (`thearticle_idthearticle`);

--
-- Index pour la table `thecomment`
--
ALTER TABLE `thecomment`
  ADD PRIMARY KEY (`idthecomment`),
  ADD KEY `fk_thecomment_theuser1_idx` (`theuser_idtheuser`);

--
-- Index pour la table `theimage`
--
ALTER TABLE `theimage`
  ADD PRIMARY KEY (`idtheimage`),
  ADD UNIQUE KEY `theimagename_UNIQUE` (`theimagename`);

--
-- Index pour la table `theimage_has_thearticle`
--
ALTER TABLE `theimage_has_thearticle`
  ADD PRIMARY KEY (`theimage_idtheimage`,`thearticle_idthearticle`),
  ADD KEY `fk_theimage_has_thearticle_thearticle1_idx` (`thearticle_idthearticle`),
  ADD KEY `fk_theimage_has_thearticle_theimage1_idx` (`theimage_idtheimage`);

--
-- Index pour la table `thesection`
--
ALTER TABLE `thesection`
  ADD PRIMARY KEY (`idthesection`),
  ADD UNIQUE KEY `thesectionslug_UNIQUE` (`thesectionslug`);

--
-- Index pour la table `thesection_has_thearticle`
--
ALTER TABLE `thesection_has_thearticle`
  ADD PRIMARY KEY (`thesection_idthesection`,`thearticle_idthearticle`),
  ADD KEY `fk_thesection_has_thearticle_thearticle1_idx` (`thearticle_idthearticle`),
  ADD KEY `fk_thesection_has_thearticle_thesection1_idx` (`thesection_idthesection`);

--
-- Index pour la table `theuser`
--
ALTER TABLE `theuser`
  ADD PRIMARY KEY (`idtheuser`),
  ADD UNIQUE KEY `theuserlogin_UNIQUE` (`theuserlogin`),
  ADD UNIQUE KEY `theusermail_UNIQUE` (`theusermail`),
  ADD UNIQUE KEY `theuseruniqid_UNIQUE` (`theuseruniqid`),
  ADD KEY `fk_theuser_permission_idx` (`permission_idpermission`);

--
-- AUTO_INCREMENT pour les tables d�charg�es
--

--
-- AUTO_INCREMENT pour la table `permission`
--
ALTER TABLE `permission`
  MODIFY `idpermission` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `thearticle`
--
ALTER TABLE `thearticle`
  MODIFY `idthearticle` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `thecomment`
--
ALTER TABLE `thecomment`
  MODIFY `idthecomment` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `theimage`
--
ALTER TABLE `theimage`
  MODIFY `idtheimage` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `thesection`
--
ALTER TABLE `thesection`
  MODIFY `idthesection` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `theuser`
--
ALTER TABLE `theuser`
  MODIFY `idtheuser` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables d�charg�es
--

--
-- Contraintes pour la table `thearticle`
--
ALTER TABLE `thearticle`
  ADD CONSTRAINT `fk_thearticle_theuser1` FOREIGN KEY (`theuser_idtheuser`) REFERENCES `theuser` (`idtheuser`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Contraintes pour la table `thearticle_has_thecomment`
--
ALTER TABLE `thearticle_has_thecomment`
  ADD CONSTRAINT `fk_thearticle_has_thecomment_thearticle1` FOREIGN KEY (`thearticle_idthearticle`) REFERENCES `thearticle` (`idthearticle`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_thearticle_has_thecomment_thecomment1` FOREIGN KEY (`thecomment_idthecomment`) REFERENCES `thecomment` (`idthecomment`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `thecomment`
--
ALTER TABLE `thecomment`
  ADD CONSTRAINT `fk_thecomment_theuser1` FOREIGN KEY (`theuser_idtheuser`) REFERENCES `theuser` (`idtheuser`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Contraintes pour la table `theimage_has_thearticle`
--
ALTER TABLE `theimage_has_thearticle`
  ADD CONSTRAINT `fk_theimage_has_thearticle_thearticle1` FOREIGN KEY (`thearticle_idthearticle`) REFERENCES `thearticle` (`idthearticle`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_theimage_has_thearticle_theimage1` FOREIGN KEY (`theimage_idtheimage`) REFERENCES `theimage` (`idtheimage`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `thesection_has_thearticle`
--
ALTER TABLE `thesection_has_thearticle`
  ADD CONSTRAINT `fk_thesection_has_thearticle_thearticle1` FOREIGN KEY (`thearticle_idthearticle`) REFERENCES `thearticle` (`idthearticle`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_thesection_has_thearticle_thesection1` FOREIGN KEY (`thesection_idthesection`) REFERENCES `thesection` (`idthesection`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `theuser`
--
ALTER TABLE `theuser`
  ADD CONSTRAINT `fk_theuser_permission` FOREIGN KEY (`permission_idpermission`) REFERENCES `permission` (`idpermission`) ON DELETE SET NULL ON UPDATE NO ACTION;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
