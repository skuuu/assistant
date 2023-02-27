
DROP TABLE IF EXISTS page;

CREATE TABLE page (
  page_id int NOT NULL,
  page_namespace int NOT NULL DEFAULT 0,
  page_title varchar(255) NOT NULL DEFAULT '',
  page_is_redirect int NOT NULL DEFAULT 0,
  page_is_new int NOT NULL DEFAULT 0,
  page_random float NOT NULL DEFAULT 0,
  page_touched varchar(255) NOT NULL,
  page_links_updated varchar(14) DEFAULT NULL,
  page_latest int NOT NULL DEFAULT 0,
  page_len int NOT NULL DEFAULT 0,
  page_content_model varchar(32) DEFAULT NULL,
  page_lang varchar(35) DEFAULT NULL,
  PRIMARY KEY (page_id)
);

INSERT INTO page VALUES (1,0,'January',0,0,0.778582929065,'20210104200951','20230104200951',8620715,22188,'wikitext',NULL),(2,0,'Jan',0,0,0.123830928525,'20220104200939','20230104200951',8346993,13247,'wikitext',NULL),(3,2,'February',0,0,0.851943655802,'20220814003040',NULL,1207184,982,'wikitext',NULL),(4,3,'Pluto',0,0,0.0888320259232,'20220711115424','20220711115011',6029103,2272,'wikitext',NULL),(5,2,'Dwarf_planet',0,0,0.921240379532,'20160824111128',NULL,36363,234,'wikitext',NULL),(6,0,'Charon',0,0,0.318740796912,'20230115073203','20230115073320',8513395,7828,'wikitext',NULL),(8,0,'A',0,0,0.124816980737,'20230104200939','20230104200955',8586863,3242,'wikitext',NULL),(9,0,'Air',0,0,0.310179459076,'20230113054642','20230113054759',8639261,4345,'wikitext',NULL),(11,4,'Administrators',0,0,0.0128889214307,'20230119195009','20230119195009',8647899,13352,'wikitext',NULL),(12,0,'Autonomous_communities_of_Spain',0,0,0.265801862472,'20230103195057','20221102095315',7973423,2801,'wikitext',NULL);

DROP TABLE IF EXISTS category;
CREATE TABLE category (
  cat_id int NOT NULL,
  cat_title varchar(255) NOT NULL DEFAULT '',
  cat_pages int NOT NULL DEFAULT 0,
  cat_subcats int NOT NULL DEFAULT 0,
  cat_files int NOT NULL DEFAULT 0,
  PRIMARY KEY (cat_id),
  UNIQUE (cat_title)
);

INSERT INTO category VALUES (1,'Month',2,0,0),(2,'Planet',52,50,0),(4,'South_Korea',25,16,0),(6,'1780s',20,18,0),(7,'Matter',27,3,0),(8,'2007',21,16,0),(10,'Germany',46,22,0),(11,'1985',17,11,0),(13,'\"Politics_of\"_templates',5,0,0),(14,'0s',12,5,0),(15,'0s_BC',12,11,0),(16,'0s_BC_births',4,0,0),(17,'0s_births',3,2,0),(18,'1',2,1,0),(20,'100',2,1,0),(21,'1000',3,1,0),(22,'1000s',16,15,0),(23,'1000s_births',8,2,0),(24,'1000s_deaths',5,1,0),(25,'1001',1,0,0),(26,'1002',2,1,0),(27,'1003',2,0,0),(28,'1004',3,2,0),(29,'1004_births',1,0,0),(30,'1004_deaths',1,0,0),(31,'1005',1,0,0),(32,'1008',1,0,0),(33,'1009',1,0,0),(34,'100_BC',1,1,0),(35,'100_BC_births',1,0,0),(36,'100s',12,11,0),(37,'100s_BC',4,3,0),(38,'100s_BC_births',2,2,0),(39,'100s_deaths',4,1,0),(40,'101',1,0,0),(41,'1010s',14,13,0),(42,'1010s_births',6,4,0),(43,'1010s_deaths',3,3,0),(44,'1012',2,1,0),(45,'1014',3,2,0),(46,'1014_deaths',1,0,0),(47,'1015',2,1,0);

DROP TABLE IF EXISTS pagelinks;

CREATE TABLE pagelinks (
  pl_from int NOT NULL DEFAULT 0,
  pl_namespace int NOT NULL DEFAULT 0,
  pl_title VARCHAR(255) NOT NULL DEFAULT '',
  pl_from_namespace int NOT NULL DEFAULT 0,
  PRIMARY KEY (pl_from,pl_namespace,pl_title)
);

INSERT INTO pagelinks VALUES (1,0,'Jan',0),(1,0,'February',0),(4,0,'Dwarf_planet',0),(4,0,'Charon',0),(266430,0,'!Hero',0),(266430,0,'!Hero_(album)',0),(4391,0,'!Kung_language',0),(912800,0,'!Kung_language',0),(303624,0,'!New_Spirit!',0),(4391,0,'!Xóõ_language',0),(188948,0,'\"21_Guns\"',0),(305376,0,'\"30_Something\"_Working_Group',0),(609614,0,'\"A\"_Is_for_Alibi',0),(762341,0,'\"Bad_Day\"_(song)',0),(31702,0,'\"Barbecue_Babylon\"',0),(513675,0,'\"Big_Ed\"_Wilkes',0),(46168,0,'\"Buffy_the_Vampire_Slayer\"_(BFI_TV_Classics_S.)',0),(765127,0,'\"C\"_Bantu_languages',0),(239220,0,'\"Conejo\"_Jolivet',0);


DROP TABLE IF EXISTS categorylinks;

CREATE TABLE categorylinks (
  cl_from int NOT NULL DEFAULT 0,
  cl_to varchar(255) NOT NULL DEFAULT '',
  cl_sortkey varchar(230) NOT NULL DEFAULT '',
  cl_timestamp timestamp NOT NULL DEFAULT now(),
  cl_sortkey_prefix varchar(255) NOT NULL DEFAULT '',
  cl_collation varchar(32) NOT NULL DEFAULT '',
  cl_type varchar NOT NULL DEFAULT 'page',
  PRIMARY KEY (cl_from,cl_to)
);

INSERT INTO categorylinks VALUES (1,'Month','January','2010-03-30 02:04:12','','uppercase','page'),(2,'Month','Jan','2021-09-26 20:17:24','','uppercase','page'),(3,'Month','February','2005-12-16 17:16:44','','uppercase','page'),(4,'Planet','Pluto','2022-09-29 11:44:47','','uppercase','page'),(5,'Planet',' Dwarf_planet','2012-03-13 13:04:28',' ','uppercase','page'),(6,'Planet','Charon','2022-09-29 11:44:47','','uppercase','page'),(6,'Articles_with_permanently_dead_external_links','ART','2022-09-29 11:44:47','','uppercase','page'),(6,'Basic_English_850_words','ART','2012-02-11 23:17:17','','uppercase','page');

