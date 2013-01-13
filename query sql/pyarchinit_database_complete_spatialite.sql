--database basato su database spatialite

--##############################
-- TABELLA RIPARTIZIONI SPAZIALI
--##############################

CREATE TABLE pyarchinit_ripartizioni_spaziali (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    id_rs character varying(80),
    sito_rs character varying(80),
    tip_rip character varying,
    descr_rs character varying
);

SELECT AddGeometryColumn ('pyarchinit_ripartizioni_spaziali','the_geom',3004, 'POLYGON',2);

--##############################
-- TABELLA SITI
--##############################

CREATE TABLE pyarchinit_siti (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    id_sito character varying(80),
    sito_nome character varying(80),
    descr_sito character varying
);

SELECT AddGeometryColumn('pyarchinit_siti','the_geom',3004, 'POINT',2);


--##############################
-- TABELLA CAMPIONATURE
--##############################

CREATE TABLE pyarchinit_campionature
(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  id_campion integer,
  sito character varying(200),
  tipo_camp character varying(200),
  dataz character varying(200),
  cronologia integer,
  link_immag character varying(500),
  sigla_camp character varying
);


SELECT AddGeometryColumn('pyarchinit_campionature','the_geom',3004, 'POINT',2);



--##############################
-- TABELLA INDIVIDUI
--##############################

CREATE TABLE  pyarchinit_individui
(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  sito character varying(255),
  sigla_struttura character varying(255),
  note character varying(255),
  id_individuo integer
);


SELECT AddGeometryColumn('pyarchinit_individui','the_geom',3004, 'POINT',2);


--##############################
-- TABELLA UNITA STRATIGRAFICHE
--##############################

CREATE TABLE pyunitastratigrafiche
(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  area_s integer,
  scavo_s character varying(80),
  us_s integer,
  stratigraph_index_us integer DEFAULT 2,
  tipo_us_s character varying,
  rilievo_orginale character varying,
  disegnatore character varying,
  data date);

SELECT AddGeometryColumn('pyunitastratigrafiche','the_geom',3004, 'MULTIPOLYGON',2);


--##############################
-- TABELLA QUOTE US
--##############################


CREATE TABLE pyarchinit_quote
(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  sito_q character varying(80),
  area_q integer,
  us_q integer,
  unita_misu_q character varying(80),
  quota_q double precision,
  data character varying,
  disegnatore character varying,
  rilievo_originale character varying);

SELECT AddGeometryColumn('pyarchinit_quote','the_geom',3004, 'POINT',2);


--##############################
-- TABELLA LINEE DI RIFERIMENTO
--##############################

CREATE TABLE pyarchinit_linee_rif
(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  sito character varying(300),
  definizion character varying(80),
  descrizion character varying(80));


SELECT AddGeometryColumn('pyarchinit_linee_rif','the_geom',3004,'LINESTRING',2);


--##############################
-- TABELLA PUNTI DI RIFERIMENTO
--##############################

CREATE TABLE pyarchinit_punti_rif
(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  sito character varying(80),
  def_punto character varying(80),
  id_punto character varying(80),
  quota double precision,
  unita_misura_quota character varying,
  area integer);

SELECT AddGeometryColumn('pyarchinit_punti_rif', 'the_geom',3004,'POINT',2);

--##############################
-- TABELLA SEZIONI
--##############################

CREATE TABLE pyarchinit_sezioni
(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  id_sezione character varying(80),
  sito character varying(80),
  area integer,
  descr character varying(80));

SELECT AddGeometryColumn('pyarchinit_sezioni', 'the_geom',3004,'LINESTRING',2);

--##############################
-- TABELLA IPOTESI STRUTTURE
--##############################


CREATE TABLE pyarchinit_strutture_ipotesi
(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  scavo character varying(80),
  id_strutt character varying(80),
  per_iniz integer,
  per_fin integer,
  dataz_ext character varying(80),
  fase_iniz integer,
  fase_fin integer,
  descrizione character varying);

SELECT AddGeometryColumn('pyarchinit_strutture_ipotesi', 'the_geom',3004,'POLYGON',2);

--##############################
-- TABELLA THESAURUS SIGLE & DATA
--##############################

CREATE TABLE pyarchinit_thesaurus_sigle
(id_thesaurus_sigle INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
 nome_tabella character varying,
 sigla character(3),
 sigla_estesa character varying,
 descrizione character varying,
 tipologia_sigla character varying);


--########## DATA ##########

INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (11, 'struttura_table', 'VA ', 'Vasca', 'La sigla VA comprende ogni tipologia di vasca', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (12, 'struttura_table', 'ST ', 'Strada', 'La sigla ST comprende ogni tipologia di strada', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (13, 'struttura_table', 'TB ', 'Tomba', 'La sigla TB comprende ogni tipologia di tomba', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (15, 'struttura_table', 'SAR', 'Struttura Artigianale', 'La sigla SAR comprende qualsiasi tipo di struttura artigianale', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (14, 'struttura_table', 'SA ', 'Struttura Agricola', 'La sigla SA indica una struttura agricola', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (102, 'pyunitastratigrafiche', NULL, 'barba', 'utilizzata per caratterizzare la pendenza di una us', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (20, 'struttura_table', 'TOR', 'Torrione', 'La sigla TOR comprende i torrioni', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (103, 'pyunitastratigrafiche', NULL, 'cocciopesto', 'cocciopesto rinvenuto in scavo', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (22, 'struttura_table', 'RPA', 'Recinto per animali', 'La sigla RPA indica i recinti per animali', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (19, 'struttura_table', 'FIG', 'Figlinae', 'La sigla FIG indica figline', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (24, 'struttura_table', 'FOM', 'Fornace per mattoni', 'La sigla FOM indica la fornace per mattoni', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (25, 'struttura_table', 'FOF', 'Fornace per metalli', 'La sigla FOF indica la fornace per il metallo', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (23, 'struttura_table', 'CAL', 'Calcara', 'La sigla CAL indica la calcara', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (26, 'struttura_table', 'FOV', 'Fornace per il vetro', 'La sigla FOV indica la fornace per il vetro', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (28, 'struttura_table', 'MAG', 'Magazzino', 'La sigla MAG comprende ogni tipologia di magazzino', 'Tipologia di struttura');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (105, 'pyunitastratigrafiche', NULL, 'calce', 'utilizzata per calce sbriciolata all''interno di uno strato', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (106, 'pyunitastratigrafiche', NULL, 'tegola', 'utilizzata per le tegole rinvenute in scavo', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (108, 'pyunitastratigrafiche', NULL, 'pietra', 'pietre rinvenute in scavo', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (109, 'pyunitastratigrafiche', NULL, 'ghiaia', 'utilizzata per gli inclusi di ghiaia presenti in strato', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (110, 'pyunitastratigrafiche', NULL, 'ferro', 'ferro rinvenuto in scavo', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (111, 'pyunitastratigrafiche', NULL, 'curva di livello', 'utilizzata per indicare i cambiamenti di quota', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (112, 'pyunitastratigrafiche', NULL, 'mosaico', 'tessere di mosaico rinvenute in scavo', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (113, 'pyunitastratigrafiche', NULL, 'coppo', 'coppi rinvenuti in scavo', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (116, 'inventario_materiali_table', NULL, 'Medioadriatica', NULL, 'tipo reperto');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (74, 'us_table', NULL, 'Strato di pietre e ciottoli', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (75, 'us_table', NULL, 'Strato di pietre e laterizi', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (76, 'us_table', NULL, 'Strato di pietrisco', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (117, 'us_table', NULL, 'Riempimento di carboni e cenere', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (114, 'us_table', NULL, 'Strato di carbone e cenere', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (115, 'inventario_materiali_table', NULL, 'Sigillata africana', NULL, 'tipo reperto');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (118, 'us_table', NULL, 'Riempimento di argilla concotta', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (77, 'us_table', NULL, 'Strato di porfido', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (119, 'us_table', NULL, 'Riempimento di argilla', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (120, 'us-table', NULL, 'Riempimento di ceramica sbriciolata', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (121, 'pyunitastratigrafiche', NULL, 'ceramica sbriciolata', 'piccoli frammenti ceramici rinvenuti di sulla superficie di strato', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (31, 'us_table', NULL, 'Reperto ceramico', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (32, 'us_table', NULL, 'Assito di legno', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (123, 'pyunitastratigrafiche', NULL, 'anfora', 'definisce la presenza di frammenti di anfora', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (33, 'us_table', NULL, 'Elemento in pietra', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (34, 'us_table', NULL, 'Cavi', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (35, 'us_table', NULL, 'Reperto generico', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (36, 'us_table', NULL, 'Materiali eterogenei', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (135, 'pyunitastratigrafiche', NULL, 'terra', 'utilizzata per legante incoerente', 'tipo di caratterizzazione');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (136, 'us_table', NULL, 'Strato di ghiaia e sabbia ', NULL, 'definizione stratigrafica');
INSERT INTO pyarchinit_thesaurus_sigle (id_thesaurus_sigle, nome_tabella, sigla, sigla_estesa, descrizione, tipologia_sigla) VALUES (137, 'us_table', NULL, 'Strato di pietre e frammenti ceramici', NULL, 'definizione stratigrafica');