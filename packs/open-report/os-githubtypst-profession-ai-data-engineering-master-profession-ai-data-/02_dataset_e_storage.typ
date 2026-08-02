#import "../utils.typ": *

= Dataset e Storage

== Resource Group (rg-cinedata-project)
Per prima cosa ho creato un nuovo Resource Group denominato `rg-cinedata-project`, selezionando la regione `(Europe) Italy North`, in modo da raggruppare tutte le risorse del progetto in un unico contenitore logico.

1.  Ho effettuato l'accesso al #link("https://portal.azure.com")[Portale di Azure].
2.  Nella barra di ricerca in alto ho digitato `Resource groups` e ho selezionato il servizio *Resource groups*.
3.  Ho cliccato su *+ Create*.
4.  Nella scheda *Basics* ho compilato i campi:
  -   *Subscription*: ho selezionato la mia sottoscrizione attiva.
  -   *Resource group*: ho inserito `rg-cinedata-project`.
  -   *Region*: ho selezionato `(Europe) Italy North`.
5.  Ho cliccato su *Review + create* e poi su *Create*.

== Il Dataset
Il dataset di partenza è il file `moviesDB.csv`, che contiene informazioni grezze sui film.
Le colonne di interesse per la nostra elaborazione sono i titoli, i generi e le recensioni numeriche.

== Creazione e Configurazione dello Storage
Ho creato uno Storage Account dedicato al progetto, nello stesso Resource Group e nella stessa Region.

1.  Nella barra di ricerca del Portale di Azure ho digitato `Storage accounts` e ho selezionato il servizio *Storage accounts*.
2.  Ho cliccato su *+ Create*.
3.  Nella scheda *Basics* ho configurato:
  -   *Subscription*: la mia sottoscrizione attiva.
  -   *Resource group*: ho selezionato `rg-cinedata-project`.
  -   *Storage account name*: ho inserito `stcinedataproject`.
  -   *Region*: ho selezionato `(Europe) Italy North`.
  -   *Performance*: ho selezionato `Standard`.
  -   *Redundancy*: ho selezionato `LRS`.
4.  Ho lasciato le impostazioni non richieste ai valori di default e ho verificato che fossero abilitati:
  -   *Secure transfer required*
  -   *Minimum TLS version*
5.  Ho cliccato su *Review + create* e poi su *Create*.
6.  A deployment completato ho cliccato su *Go to resource* per aprire lo Storage Account `stcinedataproject`.

== Gestione dei Container
Dalla pagina panoramica del mio Storage account, ho configurato i container per separare i dati grezzi da quelli elaborati.

1.  Nel menu laterale sinistro, sotto la sezione "Data storage", ho cliccato su *Containers*.
2.  Ho cliccato sul pulsante *+ Container* in alto.
3.  Nel pannello laterale, nel campo *Name* ho inserito `input`.
4.  Nel campo *Public access level* ho selezionato *Private (no anonymous access)*.
4.  Ho cliccato su *Create*.
5.  Ho ripetuto l'operazione:
  -   *+ Container* → *Name*: `output` → *Public access level*: *Private* → *Create*.

Prima di procedere, ho verificato che il container `output` fosse vuoto.

#figure(
  image("../assets/blob_container_output_empty.png", width: 90%),
  caption: "Container Output vuoto prima dell'esecuzione della pipeline",
)

== Caricamento del Dataset (Upload)
Successivamente, ho caricato il file sorgente nel sistema.

1.  Ho cliccato sul nome del container `input` appena creato.
2.  Nella barra degli strumenti in alto, ho selezionato *Upload*.
3.  Nel pannello di caricamento, ho cliccato sull'icona della cartella per sfogliare i miei file locali.
4.  Ho selezionato il file `moviesDB.csv` dal mio computer.
5.  Ho verificato che non fossero selezionate opzioni non richieste nella sezione *Advanced* (ho lasciato i default).
6.  Ho cliccato sul pulsante *Upload* in basso.

Una volta completato il caricamento, ho visto il file comparire nella lista dei blob.

#figure(
  image("../assets/blob_container_input.png", width: 90%),
  caption: "Container Input con il file moviesDB.csv caricato",
)

Per assicurarmi che il file fosse stato recepito correttamente dal sistema, ho cliccato sul nome del file `moviesDB.csv` per aprirne i dettagli. Nella scheda *Properties*, ho controllato la dimensione e i metadati di sistema standard (come il `Content-Type` e il `Last Modified`).

#figure(
  image("../assets/blob_input_file_properties.png", width: 90%),
  caption: "Proprietà del file moviesDB.csv (size, last modified, metadata)",
)
