# Workshop zur sozialen Netzwerkanalyse - Kolleg Europa

Dieses Projekt ist ein Workshop zur sozialen Netzwerkanalyse. Vorbereitet wurde er für das Kolleg Europa (Prag, 20.3.2019) der Studienstiftung des Deutschen Volkes (https://www.studienstiftung.de/europa/). Der Workshop beinhaltet eine kurze Einführung in die statistische Programmiersprache R, eine optionale Einführung in die Pakete dplyr und ggplot2 aus dem tidyverse, eine Einführung in die Grundlagen der sozialen Netzwerkanalyse anhand des Pakets igraph, eine spezielle Einführung in die Unterklasse der Assoziationsnetzwerke/Two-Mode-Netzwerke und ein abschließendes konkretes Forschungsbeispiel anhand eines Netzwerks zur Reisediplomatie von EU-Staaten.

Speziell dieses abschließende Beispiel ist work-in-progress und stellt das Projekt der Arbeitsgruppe "Europa politisch denken" des Kollegs dar. In diesem Skript sind lediglich erste Analysen und Einblicke in das Netzwerk vorgestellt.

## Inhalte

1. Einführung in R (script_R_introduction.Rmd)
	+ Objektklassen in R
	+ Funktionen
	+ Zusatzfunktionen durch Pakete
	+ data.frames
	+ Einlesen von Dateien
2. Einführung in dplyr und ggplot2 - optional (script_introduction_tidyverse.Rmd)
	+ Pipes in R
	+ Verbs in dplyr
	+ ggplot2
		+ geoms
		+ log scales
		+ additional aesthetics
		+ faceting
		+ labels
3. Einführung in die soziale Netzwerkanalyse (script_sna_introduction.Rmd)
	+ Formate für die Netzwerkanalyse
		+ edge lists
		+ adjancency matrix
	+ Zentralitätsmaße
	+ Subgroups/Cliquen
	+ Community Detection
	+ Merkmale des gesamten Netzwerks
		+ edge density
		+ diameter
		+ average path length
	+ network randomizations
	+ Netzwerkvisualisierung
4. Two-Mode/affiliation-networks (script_affiliation_example.Rmd)
	+ Affiliationsnetzwerke in igraph
	+ Adaption der Funktionen für Inzidenzmatritzen
	+ One-Mode-Projektionen des Two-Mode-Netzwerks
5. Analyse des Reisediplomatie-Netzwerks (script_analysis_reisediplomatie.Rmd)

		
## Datensätze

**hwd**

Der hwd-Datensatz enthält ein Affiliationsnetzwerk, mit dem die Technik verdeutlicht werden kann. hwd steht mutmaßlich für Hollywood Data: Schauspieler sind durch die Filme miteinander verbunden, in denen sie zusammen auftreten. Das hwd-Dataset ist ein zweigeteiltes Graph-Objekt von igraph. Die Daten stammen ursprünglich von IMDB (www.imdb.com). Der Datensatz enthält die zehn beliebtesten Filme (von IMBD-Nutzern bewertet) für jedes Jahr von 1999 bis 2014 und die ersten zehn Schauspieler, die auf der IMDB-Seite jedes Films aufgeführt sind. Zusätzlich zu den Film- und Schauspielernamen hat jeder Film das Jahr seiner Veröffentlichung, seine IMDB-Benutzerbewertung und die MPAA-Filmbewertung (d. H. G, PG, PG-13 und R) als Knoteneigenschaft gespeichert.
Ursprünglich war der Datensatz im UserNetR-Paket zu finden. Da dieses Paket nicht mehr geupdated wird, wurde der Datensatz selber aus dem GitHub-Repo (https://github.com/DougLuke/UserNetR) geladen und hier lokal zur Verfügung gestellt.

**gump**

Zur Veranschaulichung der allgemeinen SNA nutzen wir das ```Forest Gump Network```: Each edge of the network indicates that those two characters were in at least one scene of the movie together. Therefore this network is undirected. Das Netzwerk ist Teil des Datacamp-Kurses Network Analysis in R und konnte über die Projektseite bezogen werden (https://www.datacamp.com/courses/network-analysis-in-r)

**Reisediplomatie**

Das Netzwerk befindet sich im Aufbau. Für das Jahr 2018 wurde nachverfolgt, welche Länder der EU28 diplomatische Reisen in welche anderen Länder unternommen haben. Aktuell befinden sich auch noch EU28 unter den Gastgeberländern. Aktuell gibt es neben dem EU-Land und dem Gastgeberland noch folgende zusätzlichen Attribute:
* Offizielle Position des Besuchers (1=Regierungschef/in; 2=Außenminister/in)
* Name des Besuchers
* Offizielle Position des/der Gesprächspartners/in im Gastland (1=Regierungschef/in; 2=Außenminister/in; 3=Sonstiges)
* Teilnehmende Akteure anderer Länder (Name & Land)
* Name des Gastgebers
* Ankunftsdatum
* Abreisdatum
* Aufenthaltsdauer
* Politikfelder/Themen der Reise
* Abschlussdokument (1=Ja; 2=Nein)
* Bearbeitet von (Kürzel)
* Quellen

## Literatur und Ressourcen

Für die Erstellung dieses Workshops wurde sich hauptsächlich auf die folgenden Ressourcen bezogen:

* Gabor Csardi; Tamas Nepusz (2006): The igraph software package for complex network research. In: InterJournal Complex Systems, S. 1695. Online verfügbar unter http://igraph.org.
* James Curley: Network Analysis in R. Interactive Datacamp Course. Hg. v. Datacamp. Datacamp. Online verfügbar unter https://www.datacamp.com/courses/network-analysis-in-r.
* Jansen, Dorothea (2003): Einführung in die Netzwerkanalyse. Grundlagen, Methoden, Forschungsbeispiele. 2., erw. Aufl. Opladen: Leske + Budrich (UTB Sozialwissenschaft, 2241).
* Luke, Douglas A. (2015): A user's guide to network analysis with R. Cham: Springer International Publishing (Use R!).
* Phil Murphy; Brendan Knapp: Bipartite/Two-Mode Networks. Online verfügbar unter https://rpubs.com/pjmurphy/317838.
* Scott, John; Carrington, Peter J. (Hg.) (2011): The SAGE handbook of social network analysis. Los Angeles, Calif.: SAGE Publ.
