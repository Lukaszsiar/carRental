CLEAR SCREEN;
------------------
--KASOWANIE TABEL;
------------------

DELETE FROM UBEZPIECZENIE;
drop table UBEZPIECZENIE;
--
DELETE FROM PRZEGLAD;
drop table PRZEGLAD;
--
DELETE FROM AUTO;
drop table AUTO;
--
DELETE FROM CENA;
drop table CENA;
--
DELETE FROM ODDZIAL;
drop table ODDZIAL;
--
DELETE FROM WYPOZYCZENIA;
drop table WYPOZYCZENIA;
--
DELETE FROM KLIENT;
drop table KLIENT;
--
DELETE FROM JAZDY_PRAWA;
drop table JAZDY_PRAWA;
--
DELETE FROM OSOBA;
drop table OSOBA;
--
DELETE FROM ZAMIESZKANIA_MIEJSCE;
drop table ZAMIESZKANIA_MIEJSCE;

------------------
--TWORZENIE TABEL
------------------



CREATE TABLE ZAMIESZKANIA_MIEJSCE(
ZAMI_ID				NUMBER(4)	NOT NULL,
ZAMI_KRAJ			VARCHAR2(40),
ZAMI_WOJEWODZTWO	VARCHAR2(40),
ZAMI_KOD_POCZTOWY	NUMBER(5),
ZAMI_MIASTO			VARCHAR2(40)
);

--++PRIMARY KEY++
alter table ZAMIESZKANIA_MIEJSCE
add constraint CSR_PK_ZAMIESZKANIA_MIEJSCE
primary key(ZAMI_ID);

----------------------------------------------------------------------

CREATE TABLE OSOBA(
OSOB_ID				NUMBER(4)		NOT NULL,
OSOB_IMIE			VARCHAR2(40)	,
OSOB_NAZWISKO		VARCHAR2(40)	,
OSOB_PESEL			NUMBER(11)		,
ZAMI_ID_f			NUMBER(4)		NOT NULL
);

--++PRIMARY KEY++
alter table OSOBA
add constraint CSR_PK_OSOBA
primary key(OSOB_ID);

--++FOREIGN KEY++
alter table OSOBA add constraint CSR_FK_OSOBA
foreign key (ZAMI_ID_f)
references ZAMIESZKANIA_MIEJSCE(ZAMI_ID);

----------------------------------------------------------------------

CREATE TABLE JAZDY_PRAWA(
JAZD_ID				NUMBER(4)		NOT NULL,
JAZD_NR				NUMBER(15)		,
JAZD_WAZNE_DO		DATE			,
JAZD_KATEGORIA		VARCHAR(3)		
);

--++PRIMARY KEY++
alter table JAZDY_PRAWA
add constraint CSR_PK_JAZDY_PRAWA
primary key(JAZD_ID);

----------------------------------------------------------------------

CREATE TABLE KLIENT(
KLIE_ID			NUMBER(4)		NOT NULL,
KLIE_DATA_START	DATE			,
KLIE_ZNIZKI		NUMBER(5)		
);

--++PRIMARY KEY++
alter table KLIENT
add constraint CSR_PK_KLIENT
primary key(KLIE_ID);

----------------------------------------------------------------------

CREATE TABLE WYPOZYCZENIA(
WYPO_ID				NUMBER(4)		NOT NULL,
WYPO_DATA_START		DATE			,
WYPO_DATA_STOP		DATE			,
KLIE_ID_f			NUMBER(4)		NOT NULL
);

--++PRIMARY KEY++
alter table WYPOZYCZENIA
add constraint CSR_PK_WYPOZYCZENIA
primary key(WYPO_ID);

--++FOREIGN KEY++
alter table WYPOZYCZENIA add constraint CSR_FK_WYPOZYCZENIA
foreign key (KLIE_ID_f)
references KLIENT(KLIE_ID);

----------------------------------------------------------------------

CREATE TABLE ODDZIAL(
ODDZ_ID				NUMBER(4)		NOT NULL,
ODDZ_WOJEWODZTWO	VARCHAR2(40)	,
ODDZ_KOD_POCZTOWY	NUMBER(5)		,
ODDZ_MIEJSCOWOSC	VARCHAR2(40)	
);

--++PRIMARY KEY++
alter table ODDZIAL
add constraint CSR_PK_ODDZIAL
primary key(ODDZ_ID);

----------------------------------------------------------------------

CREATE TABLE CENA(
CENA_ID				NUMBER(4)		NOT NULL,
CENA_ZA_DOBE		NUMBER(5)		
);

--++PRIMARY KEY++
alter table CENA
add constraint CSR_PK_CENA
primary key(CENA_ID);

----------------------------------------------------------------------

CREATE TABLE AUTO(
AUTO_ID					NUMBER(4)		NOT NULL,
AUTO_MODEL				VARCHAR2(40)	,
AUTO_KOLOR				VARCHAR2(40)	,
AUTO_KAT_WYMAGANA		VARCHAR2(40)	,
AUTO_NR_REJESTRACYJNY	VARCHAR2(40)	,
AUTO_DOSTEPNOSC			VARCHAR2(40)	,
CENA_ID_f				NUMBER(4)		NOT NULL,
WYPO_ID_f				NUMBER(4)		NOT NULL
);

--++PRIMARY KEY++
alter table AUTO
add constraint CSR_PK_AUTO
primary key(AUTO_ID);

--++FOREIGN KEY++
alter table AUTO add constraint CSR_FK_AUTO
foreign key (CENA_ID_f)
references CENA(CENA_ID);

--++FOREIGN KEY++
alter table AUTO add constraint CSR_FK_AUTO2
foreign key (WYPO_ID_f)
references WYPOZYCZENIA(WYPO_ID);

----------------------------------------------------------------------

CREATE TABLE PRZEGLAD(
PRZE_ID				NUMBER(4)		NOT NULL,
PRZE_KOSZT			NUMBER(7)		,
PRZE_DATA			DATE			,
PRZE_WAZNOSC		DATE			,
AUTO_ID_f			NUMBER(4)		NOT NULL
);

--++PRIMARY KEY++
alter table PRZEGLAD
add constraint CSR_PK_PRZEGLAD
primary key(PRZE_ID);

--++FOREIGN KEY++
alter table PRZEGLAD add constraint CSR_FK_PRZEGLAD
foreign key (AUTO_ID_f)
references AUTO(AUTO_ID);

----------------------------------------------------------------------

CREATE TABLE UBEZPIECZENIE(
UBEZ_ID				NUMBER(4)		NOT NULL,
UBEZ_NR_POLISY		NUMBER(12)		,
UBEZ_DATA_START		DATE			,
UBEZ_DATA_STOP		DATE
);

--++PRIMARY KEY++
alter table UBEZPIECZENIE
add constraint CSR_PK_UBEZPIECZENIE
primary key(UBEZ_ID);

----------------------------------------------------------------------

------------------
--SEKWENCJE
------------------

DROP SEQUENCE SEQ_ZAMIESZKANIA_MIEJSCE;
DROP SEQUENCE SEQ_OSOBA;
DROP SEQUENCE SEQ_JAZDY_PRAWA;
DROP SEQUENCE SEQ_KLIENT;
DROP SEQUENCE SEQ_WYPOZYCZENIA;
DROP SEQUENCE SEQ_ODDZIAL;
DROP SEQUENCE SEQ_CENA;
DROP SEQUENCE SEQ_AUTO;
DROP SEQUENCE SEQ_PRZEGLAD;
DROP SEQUENCE SEQ_UBEZPIECZENIE;



CREATE SEQUENCE SEQ_ZAMIESZKANIA_MIEJSCE INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_OSOBA INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_JAZDY_PRAWA INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_KLIENT INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_WYPOZYCZENIA INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_ODDZIAL INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_CENA INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_AUTO INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_PRZEGLAD INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
--
CREATE SEQUENCE SEQ_UBEZPIECZENIE INCREMENT BY 1 
START WITH 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;


------------------
--TRIGGERY
------------------

create or replace trigger T_BI_ZAMIESZKANIA_MIEJSCE
before insert on ZAMIESZKANIA_MIEJSCE
for each row
begin
	if :new.ZAMI_ID is NULL then
		SELECT SEQ_ZAMIESZKANIA_MIEJSCE.nextval INTO :new.ZAMI_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_OSOBA
before insert on OSOBA
for each row
begin
	if :new.OSOB_ID is NULL then
		SELECT SEQ_OSOBA.nextval INTO :new.OSOB_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_JAZDY_PRAWA
before insert on JAZDY_PRAWA
for each row
begin
	if :new.JAZD_ID is NULL then
		SELECT SEQ_JAZDY_PRAWA.nextval INTO :new.JAZD_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_KLIENT
before insert on KLIENT
for each row
begin
	if :new.KLIE_ID is NULL then
		SELECT SEQ_KLIENT.nextval INTO :new.KLIE_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_WYPOZYCZENIA
before insert on WYPOZYCZENIA
for each row
begin
	if :new.WYPO_ID is NULL then
		SELECT SEQ_WYPOZYCZENIA.nextval INTO :new.WYPO_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_ODDZIAL
before insert on ODDZIAL
for each row
begin
	if :new.ODDZ_ID is NULL then
		SELECT SEQ_ODDZIAL.nextval INTO :new.ODDZ_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_CENA
before insert on CENA
for each row
begin
	if :new.CENA_ID is NULL then
		SELECT SEQ_CENA.nextval INTO :new.CENA_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_AUTO
before insert on AUTO
for each row
begin
	if :new.AUTO_ID is NULL then
		SELECT SEQ_AUTO.nextval INTO :new.AUTO_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_PRZEGLAD
before insert on PRZEGLAD
for each row
begin
	if :new.PRZE_ID is NULL then
		SELECT SEQ_PRZEGLAD.nextval INTO :new.PRZE_ID FROM dual;
	end if;
end;
/

--

create or replace trigger T_BI_UBEZPIECZENIE
before insert on UBEZPIECZENIE
for each row
begin
	if :new.UBEZ_ID is NULL then
		SELECT SEQ_UBEZPIECZENIE.nextval INTO :new.UBEZ_ID FROM dual;
	end if;
end;
/

--INSERTY I SELEKTY
INSERT INTO 
ODDZIAL(ODDZ_MIEJSCOWOSC, ODDZ_WOJEWODZTWO)
VALUES ('Krakow','Malopolskie');
INSERT INTO 
ODDZIAL(ODDZ_MIEJSCOWOSC, ODDZ_WOJEWODZTWO)
VALUES ('Krakow','Malopolskie');
INSERT INTO 
ODDZIAL(ODDZ_MIEJSCOWOSC, ODDZ_WOJEWODZTWO)
VALUES ('Lublin', 'Lubelskie');
--
--
COLUMN  ODDZ_MIEJSCOWOSC FORMAT A10
select ODDZ_MIEJSCOWOSC from ODDZIAL;

INSERT INTO 
ZAMIESZKANIA_MIEJSCE(ZAMI_KRAJ,ZAMI_MIASTO)
VALUES ('Polska','Krakow');

INSERT INTO 
ZAMIESZKANIA_MIEJSCE(ZAMI_KRAJ,ZAMI_MIASTO)
VALUES ('Polska','Parczew');

INSERT INTO 
ZAMIESZKANIA_MIEJSCE(ZAMI_KRAJ,ZAMI_MIASTO)
VALUES ('Polska','Lublin');

INSERT INTO 
ZAMIESZKANIA_MIEJSCE(ZAMI_KRAJ,ZAMI_MIASTO)
VALUES ('Polska','Warszawa');


COLUMN  ZAMI_KRAJ FORMAT A10
COLUMN  ZAMI_MIASTO FORMAT A10
select ZAMI_KRAJ,ZAMI_MIASTO from ZAMIESZKANIA_MIEJSCE;