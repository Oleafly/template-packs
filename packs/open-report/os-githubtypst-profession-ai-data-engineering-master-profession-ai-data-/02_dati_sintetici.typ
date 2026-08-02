= Dati sintetici

== Motivazione e approccio

Nel contesto di questo progetto, l'utilizzo di dati sanitari reali comporterebbe significative complessità legali ed etiche, 
in particolare legate al rispetto della privacy dei pazienti e alla conformità con normative rigorose come il GDPR. 
Per ovviare a queste problematiche e garantire la massima flessibilità nella fase di sviluppo e test, 
ho optato per la generazione di un dataset interamente sintetico.

Questa scelta mi ha permesso di disporre di una base dati verosimile e strutturata, necessaria per convalidare l'architettura Snowflake e le pipeline di ingestione, 
eliminando alla radice il rischio di esporre informazioni sensibili. La fase di generazione dei dati costituisce quindi il punto di partenza fondamentale dell'intero progetto, 
definendo il perimetro informativo su cui si baseranno tutte le analisi successive.

== Sorgente: healthdata-synthetic-generator e SDV

Per produrre il dataset, ho utilizzato un progetto esterno denominato "healthdata-synthetic-generator", basato sulla libreria Python *SDV (Synthetic Data Vault)*. 
SDV è uno strumento avanzato che consente di modellare dataset multi-tabella, apprendendo le distribuzioni statistiche e le relazioni dai dati originali (o da schemi definiti) 
per generare nuovi record che mantengono la coerenza referenziale e le proprietà statistiche.

Il generatore è stato configurato per rispettare regole di business specifiche e vincoli di integrità. 
Il codice sorgente e la documentazione tecnica del generatore sono disponibili al seguente link:
#link("https://github.com/fedevita/healthdata-synthetic-generator.git")[healthdata-synthetic-generator]

== Organizzazione per domini

Ho strutturato il dataset organizzandolo in tre domini logici distinti, per simulare la natura eterogenea dei sistemi informativi ospedalieri reali. 
Questa suddivisione riflette la necessità di consolidare fonti diverse all'interno del Data Warehouse:

- *EHR (Electronic Health Record)*: Contiene i dati clinici fondamentali, inclusi i dettagli sui pazienti, i ricoveri ospedalieri e le diagnosi associate.
- *ERP (Enterprise Resource Planning)*: Raccoglie i dati operativi e organizzativi, come la gestione dei reparti, l'anagrafica del personale e i turni di assegnazione.
- *IoT (Internet of Things)*: Include i dati generati dai dispositivi medici e le relative misurazioni dei parametri vitali.

== Dizionario dati

Di seguito riporto il dizionario dati completo, suddiviso per dominio, che descrive le entità generate e il significato di ciascun campo.

=== Dominio ERP

*1. Reparti ("reparti")*
Rappresenta le unità operative ospedaliere.
- *id_reparto* (PK): Identificatore univoco del reparto.
- *nome_reparto*: Nome o etichetta del reparto (categorico).
- *specialita*: Specialità clinica del reparto (es. Cardiologia, Neurologia, Oncologia, Pediatria, Pronto Soccorso, Terapia Intensiva, Ortopedia).

*2. Personale ("personale")*
Anagrafica dello staff medico e sanitario.
- *id_staff* (PK): Identificatore univoco del membro dello staff.
- *nome*: Nome proprio del membro dello staff.
- *cognome*: Cognome del membro dello staff.
- *ruolo*: Ruolo professionale (es. Infermiere, Medico, Tecnico, Terapista).
- *reparto*: Reparto o area di assegnazione (coerente con le specialità dei reparti).
- *tipo_impiego*: Tipologia di impiego (es. Tempo pieno, Part-time, Contratto).
- *email*: Indirizzo email aziendale dello staff.
- *telefono*: Numero di telefono dello staff.
- *id_licenza*: Identificativo professionale sintetico.
- *data_assunzione*: Data di assunzione.

*3. Assegnazioni ("assegnazioni")*
Gestisce l'assegnazione operativa del personale ai reparti.
- *id_assegnazione* (PK): Identificatore univoco dell'assegnazione.
- *id_staff* (FK): Riferimento allo staff (FK -> personale.id_staff).
- *id_reparto* (FK): Riferimento al reparto (FK -> reparti.id_reparto).
- *turno*: Turno di lavoro (es. Giorno, Notte, Sera).

=== Dominio IoT

*4. Dispositivi ("dispositivi")*
Inventario dei dispositivi medici IoT connessi.
- *id_dispositivo* (PK): Identificatore univoco del dispositivo.
- *id_reparto* (FK): Riferimento reparto di utilizzo/allocazione (FK -> reparti.id_reparto).
- *tipo_dispositivo*: Tipo dispositivo (es. ECG, Pulsossimetro, Sfigmomanometro, Termometro).
- *produttore*: Produttore del dispositivo.
- *modello*: Modello o codice del dispositivo.
- *numero_serie*: Numero di serie del dispositivo.
- *stato*: Stato operativo (es. Attivo, Manutenzione, Ritirato).
- *data_acquisto*: Data di acquisto.
- *data_ultima_calibrazione*: Data dell'ultima calibrazione (con vincolo >= data_acquisto).

*5. Parametri Vitali ("parametri_vitali")*
Registro delle misurazioni vitali sparse effettuate dai dispositivi.
- *id_misurazione* (PK): Identificatore della misurazione.
- *id_paziente* (FK): Riferimento paziente (FK -> pazienti.id_paziente).
- *id_dispositivo* (FK): Riferimento dispositivo (FK -> dispositivi.id_dispositivo).
- *data_misurazione*: Data e ora della misurazione.
- *frequenza_cardiaca*: Battiti per minuto (intero).
- *saturazione_ossigeno*: SpO2 in percentuale (intero).
- *pressione_sistolica*: Pressione sistolica (intero).
- *pressione_diastolica*: Pressione diastolica (intero).
- *temperatura_c*: Temperatura corporea in °C (float).
- *frequenza_respiratoria*: Atti respiratori al minuto (intero).
- *glicemia_mg_dl*: Glicemia in mg/dL (intero).

_Nota tecnica:_ I campi dei parametri vitali sono popolati condizionalmente in base al *tipo di dispositivo* associato. 
Ad esempio, un Termometro valorizzerà esclusivamente il campo `temperatura_c`, lasciando gli altri a `NULL`. 
Questa scelta rende il dataset realistico e introduce valori mancanti (missing values) che dovranno essere gestiti nelle fasi di analisi.

=== Dominio EHR

*6. Pazienti ("pazienti")*
Anagrafica centrale dei pazienti.
_Identificativi:_
- *id_paziente* (PK): Identificatore univoco del paziente.
- *codice_fiscale*: Identificativo nazionale sintetico.

_Anagrafica:_
- *nome*: Nome.
- *cognome*: Cognome.
- *sesso*: Sesso biologico (F o M).
- *data_nascita*: Data di nascita.
- *stato_civile*: Stato civile (celibe/nubile, sposato/a, divorziato/a, vedovo/a).
- *lingua_primaria*: Lingua primaria (es. it).
- *gruppo_sanguigno*: Gruppo sanguigno (A+, A-, B+, B-, AB+, AB-, O+, O-).

_Contatto e indirizzo:_
- *citta*: Città di residenza (trattabile come PII).
- *indirizzo*: Indirizzo stradale.
- *cap*: CAP.
- *paese*: Paese di residenza.
- *email*: Email personale.
- *telefono*: Telefono personale.

_Assicurazione:_
- *compagnia_assicurativa*: Provider assicurativo.
- *piano_assicurativo*: Piano sottoscritto (basic, standard, premium).
- *id_assicurazione*: Identificativo polizza.

_Contatto emergenza:_
- *contatto_emergenza_nome*: Nome contatto emergenza.
- *contatto_emergenza_telefono*: Telefono contatto emergenza.

_Misure fisiche:_
- *altezza_cm*: Altezza in cm.
- *peso_kg*: Peso in kg.

_Nota sulla privacy:_ Diversi campi della tabella "pazienti" (in particolare contatti e indirizzi) costituiscono informazioni identificabili personalmente (PII). 
La gestione degli accessi e la protezione di questi dati verranno affrontate specificamente nelle sezioni relative alla sicurezza (RBAC e conformità GDPR).

*7. Ricoveri ("ricoveri")*
Storico delle ospedalizzazioni.
- *id_ricovero* (PK): Identificatore ricovero.
- *id_paziente* (FK): Riferimento paziente (FK -> pazienti.id_paziente).
- *id_reparto* (FK): Riferimento reparto (FK -> reparti.id_reparto).
- *data_ricovero*: Data e ora ricovero.
- *data_dimissione*: Data e ora dimissione (con vincolo >= data_ricovero).
- *durata_degenza_giorni*: Durata degenza in giorni (tra 1 e 30).
- *tipo_ricovero*: Tipo di ricovero (Emergenza, Elettivo, Urgente).
- *provenienza_ricovero*: Provenienza (PS, Invio, Trasferimento).
- *esito_dimissione*: Esito alla dimissione (Domicilio, Trasferimento, Riabilitazione, Deceduto).

*8. Diagnosi ("diagnosi")*
Dettaglio delle diagnosi associate ai ricoveri.
- *id_diagnosi* (PK): Identificatore diagnosi.
- *id_ricovero* (FK): Riferimento ricovero (FK -> ricoveri.id_ricovero).
- *codice_icd10*: Codice ICD10 (categorico).
- *gravita*: Livello di gravità (bassa, media, alta).

== Relazioni e integrità referenziale

La struttura del dataset si basa su solide relazioni gerarchiche che vengono applicate già nella pipeline di campionamento sintetico e 
i cui vincoli di integrità (chiavi esterne e domini) sono stati validati:

- `reparti.id_reparto` -> `assegnazioni.id_reparto`
- `reparti.id_reparto` -> `dispositivi.id_reparto`
- `reparti.id_reparto` -> `ricoveri.id_reparto`
- `pazienti.id_paziente` -> `ricoveri.id_paziente`
- `pazienti.id_paziente` -> `parametri_vitali.id_paziente`
- `personale.id_staff` -> `assegnazioni.id_staff`
- `dispositivi.id_dispositivo` -> `parametri_vitali.id_dispositivo`
- `ricoveri.id_ricovero` -> `diagnosi.id_ricovero`

Queste relazioni sono il prerequisito fondamentale per il modello Snowflake, permettendo analisi incrociate tra domini diversi.

== Ruoli, permessi e predisposizione per integrazione Snowflake

In questa fase, ho impostato l'infrastruttura di storage cloud su Amazon S3 e definito il modello di sicurezza per la futura integrazione con Snowflake.
Ho adottato un approccio architetturale basato su principi di sicurezza enterprise: utilizzo di un bucket completamente privato, 
autenticazione tramite ruolo IAM (senza credenziali statiche) e applicazione rigorosa del principio del *least privilege*.

Questa configurazione garantisce che la separazione tra lo strato di storage (Data Lake) e lo strato di computazione (Data Warehouse) avvenga in modo sicuro e controllato.

=== Bucket S3 e struttura interna dei dati

Ho creato un bucket S3 dedicato nella regione AWS *`eu-central-1`* (Francoforte), denominandolo esplicitamente *`healthcare-data-prod-eu`*.
Il bucket è configurato con il blocco totale dell'accesso pubblico ("Block Public Access" attivo).

Ho strutturato i dati internamente utilizzando una gerarchia di cartelle (prefix) che riflette l'organizzazione logica del dataset, facilitando la futura ingestione automatizzata:

#figure(
  ```text
healthcare-data-prod-eu/
└── snowflake/
    └── raw/
        ├── ehr/
        │   ├── pazienti/
        │   ├── ricoveri/
        │   └── diagnosi/
        ├── erp/
        │   ├── reparti/
        │   ├── personale/
        │   └── assegnazioni/
        └── iot/
            ├── dispositivi/
            └── parametri_vitali/
```,
  caption: "Struttura delle cartelle nel bucket S3"
)

Ogni directory foglia (es. `pazienti/`) contiene esclusivamente i file dati (Parquet) relativi a quella specifica entità, garantendo omogeneità di schema.

=== Ruolo IAM dedicato a Snowflake

Per abilitare l'accesso sicuro da parte di Snowflake, ho creato un ruolo IAM (Identity and Access Management) dedicato nel mio account AWS, denominato *`snowflake_s3_readonly_role`*.
Questo ruolo è stato progettato per essere "assumibile" da un'entità esterna fidata (il servizio Snowflake) e non possiede permessi diretti di login o chiavi di accesso.

=== Policy IAM (Least Privilege)

Al ruolo ho associato una policy IAM custom, denominata *`snowflake_s3_raw_read_policy`*, che definisce esattamente quali azioni sono permesse.
La policy concede esclusivamente i permessi di lettura (`s3:GetObject`) e di listing (`s3:ListBucket`), restringendoli rigorosamente al bucket di produzione e al path specifico dei dati grezzi.

Ecco la definizione della policy applicata:

#figure(
  ```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::healthcare-data-prod-eu",
                "arn:aws:s3:::healthcare-data-prod-eu/snowflake/raw/*"
            ]
        }
    ]
}
```,
  caption: "Policy IAM (least privilege)"
)

Questa configurazione impedisce qualsiasi operazione di scrittura o cancellazione e nega l'accesso a qualsiasi altra risorsa AWS non esplicitamente indicata.

=== Trust policy del ruolo IAM (predisposta con placeholder)

Per completare la configurazione di sicurezza, il ruolo IAM necessita di una "Trust Relationship" che autorizzi specificamente l'account Snowflake ad assumerlo.
Poiché l'account Snowflake non è ancora stato collegato, ho predisposto la Trust Policy utilizzando dei placeholder espliciti per i valori che verranno generati lato Snowflake:

#figure(
  ```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "<SNOWFLAKE_IAM_USER_ARN>"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "<SNOWFLAKE_EXTERNAL_ID>"
        }
      }
    }
  ]
}
```,
  caption: "Trust Policy del ruolo IAM (con placeholder)"
)

I valori `<SNOWFLAKE_IAM_USER_ARN>` (l'identità utente IAM di Snowflake) e `<SNOWFLAKE_EXTERNAL_ID>` (un identificativo univoco per la sicurezza cross-account) 
verranno recuperati eseguendo il comando `DESC INTEGRATION` su Snowflake e aggiornati in questa policy in un secondo momento.