pyarchinit_beta_test_2
======================

!!!!! ATTENZIONE !!!!

RICORDARSI DI FARE UNA COPIA DEL CODICE E NON SPOSTARE MAI LA CARTELLA O FILES DAL DROPBOX 



2012/07/09

Aggiunta l'ultima versione del plugin senza database.
Ha molti test non disabilitati che ne rendono precario l'uso al di fuori di Mac OS X
E' possibile installare solamente il database alfanumerico su postgres seguendo la doc del sito web.

2012/07/12

Aggiunto un progetto Qgis pyarchinit_qgis_project.qgs e una cartella layer attraverso il plugin Qconsolidate. Dopo che sar� depurato potr� essere importato per creare il DB.

Aggiunto il pacchetto degli stili da caricare dentro Qgis

Aggiunto la query sql per generare la tabella Geometry Columns

Aggiunte le query per le wiev

2012/07/13



Aggiornati gli stili

Aggiornata la versione del plugin con funzionalit� di stampa in automatico delle tavole delle US

E� in corso l�elaborazione del dataset per postgres

E� stata constatata l�effettiva impossibilit� di installare pygraphviz sotto windows per l�esportazione del matrix. Al momento chi volesse tale funzionalit�, � meglio che installi tutto sotto Linux (Testato su Ubuntu 10.04)


2012/07/14
	
Bug Scheda Inventario Materiali
1 - La scheda reperti non riesce ad essere avviata se al suo interno non sono presenti.
2 � Modificare la lista a tendina del lavato si/no in editable.

Da fare Scheda Inventario Materiali
Modifica del sistema di esportazione in pdf in corso per ceramica a vernice nera
ottimizzare il sistema di esportazione delle immagini
personalizzare il sistema di etichettatura del PDF in base al tipo di reperto schedato


Da fare Scheda US
Controllo record modificato come per Scheda Inventario Materiali

2012/09/19

Persiste il problema della creazione nuovo record in Periodizzazione: dopo aver salvato il record viene impostato a video il sito errato.
Modificare lo script del fillfields

2012/10/15

Inventario Materiali: la gui presenta la lista a tendina del sito in modalit� aperta, che permette di lasciare vuoto il campo e creare ID duplicati. Aggiungere un controllo sul campo sito e mettere in modalit� non editabile il campo sito.

2012/12/05

Problema col sistema di ricerca per i campi aperti

Aggiunto il sistema di inserimento di caratteri unicode

Test per il pull request
