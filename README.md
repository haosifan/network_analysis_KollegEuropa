# Workshop zur sozialen Netzwerkanalyse - Kolleg Europa

Dieses Projekt ist ein Workshop zur sozialen Netzwerkanalyse. Vorbereitet wurde er für das Kolleg Europa (Prag, 20.3.2019) der Studienstiftung des Deutschen Volkes. Der Workshop beinhaltet eine kurze Einführung in die statistische Programmiersprache R, eine optionale Einführung in die Pakete dplyr und ggplot2 aus dem tidyverse, eine Einführung in die Grundlagen der sozialen Netzwerkanalyse anhand des Pakets igraph, eine spezielle Einführung in die Unterklasse der Assoziationsnetzwerke/Two-Mode-Netzwerke und ein abschließendes konkretes Forschungsbeispiel anhand eines Netzwerk zur Reisediplomatie von EU-Staaten.

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
3. Einführung in die soziale Netzwerkanalyse
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
4. Two-Mode/affiliation-networks
	+ Affiliationsnetzwerke in igraph
	+ Adaption der Funktionen für Inzidenzmatritzen
	+ One-Mode-Projektionen des Two-Mode-Netzwerks
5. Analyse des Reisediplomatie-Netzwerks 

		
## Datensätze
hwd: 
gump: 
Reisediplomatie: