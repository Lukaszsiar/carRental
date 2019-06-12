CLEAR SCREEN;

set serveroutput on;
set LINESIZE 140


--PERSPEKTYWY

create or replace view V_OSOBA_ZAMIESZKANIA_MIEJSCE
(OSOBA, ZAMIESZKANIA_MIEJSCE)
as
SELECT OSOB_IMIE, ZAMI_MIASTO from OSOBA, ZAMIESZKANIA_MIEJSCE WHERE ZAMI_ID_f = ZAMI_ID;
--

 
create or replace view V_CENA_AUTO
(Cena, Model, Dostepnosc)
as
SELECT CENA_ZA_DOBE, AUTO_MODEL, AUTO_DOSTEPNOSC from CENA, AUTO WHERE CENA_ID_f = CENA_ID;


--PROCEDURY

CREATE OR REPLACE PROCEDURE SEQ_INSERT(ile IN number)
IS
PRAGMA AUTONOMOUS_TRANSACTION;

licznik number(2);
zami_id_curr ZAMIESZKANIA_MIEJSCE.ZAMI_ID%TYPE;
osob_id_curr OSOBA.OSOB_ID%TYPE;
jazd_id_curr JAZDY_PRAWA.JAZD_ID%TYPE;
klie_id_curr KLIENT.KLIE_ID%TYPE;
wypo_id_curr WYPOZYCZENIA.WYPO_ID%TYPE;
oddz_id_curr ODDZIAL.ODDZ_ID%TYPE;
cena_id_curr CENA.CENA_ID%TYPE;
auto_id_curr AUTO.AUTO_ID%TYPE;
prze_id_curr PRZEGLAD.PRZE_ID%TYPE;
ubez_id_curr UBEZPIECZENIE.UBEZ_ID%TYPE;
BEGIN
    licznik:=1;
		WHILE
			licznik < ile+1
			LOOP
			
			INSERT INTO ZAMIESZKANIA_MIEJSCE(ZAMI_KRAJ, ZAMI_WOJEWODZTWO, ZAMI_KOD_POCZTOWY, ZAMI_MIASTO)
				VALUES
				('Polska'||licznik, 'Wojewodztwo'||licznik, 21205, 'Miasto'||licznik);
								
				--
				select SEQ_ZAMIESZKANIA_MIEJSCE.currval INTO zami_id_curr FROM DUAL;
				--
				INSERT INTO OSOBA(OSOB_IMIE, OSOB_NAZWISKO, OSOB_PESEL,ZAMI_ID_f)
				VALUES
				('Janusz'||licznik, 'Nazwisko'||licznik, 97051458319, zami_id_curr);
				
				--
				select SEQ_OSOBA.currval INTO osob_id_curr FROM DUAL;
				--
				
				INSERT INTO JAZDY_PRAWA(JAZD_NR, JAZD_WAZNE_DO, JAZD_KATEGORIA)
				VALUES
				(10||licznik, to_date('01-01-2010', 'dd-mm-yy')+trunc(dbms_random.value(1,1000)), 'B');
				
				--
				select SEQ_JAZDY_PRAWA.currval INTO jazd_id_curr FROM DUAL;
				--
				
				INSERT INTO KLIENT(KLIE_DATA_START, KLIE_ZNIZKI)
				VALUES
				(to_date('01-01-2010', 'dd-mm-yy')+trunc(dbms_random.value(1,1000)), 23);
				
				--
				select SEQ_KLIENT.currval INTO klie_id_curr FROM DUAL;
				--
				
				INSERT INTO WYPOZYCZENIA(WYPO_DATA_START, WYPO_DATA_STOP, KLIE_ID_f)
				VALUES
				(to_date('01-01-2010', 'dd-mm-yy')+trunc(dbms_random.value(1,1000)),
				to_date('01-01-2010', 'dd-mm-yy')+trunc(dbms_random.value(1,1000)), klie_id_curr);
				
				--
				select SEQ_WYPOZYCZENIA.currval INTO wypo_id_curr FROM DUAL;
				--
				
				INSERT INTO ODDZIAL(ODDZ_WOJEWODZTWO, ODDZ_KOD_POCZTOWY, ODDZ_MIEJSCOWOSC)
				VALUES
				('Wojewodztwo'||licznik, 21208, 'Miejscowosc'||licznik);
				
				--
				select SEQ_ODDZIAL.currval INTO oddz_id_curr FROM DUAL;
				--
				
				INSERT INTO CENA(CENA_ZA_DOBE)
				VALUES
				(8+trunc(dbms_random.value(50,5000)));
				
				--
				select SEQ_CENA.currval INTO cena_id_curr FROM DUAL;
				--
				
				INSERT INTO AUTO(AUTO_MODEL, AUTO_KOLOR, AUTO_KAT_WYMAGANA, AUTO_NR_REJESTRACYJNY, AUTO_DOSTEPNOSC, CENA_ID_f, WYPO_ID_f)
				VALUES
				('Model'||licznik, 'Czerwony', 'B','LPA 1423 23'||licznik, 'Tak', cena_id_curr, wypo_id_curr);
				
				--
				select SEQ_AUTO.currval INTO auto_id_curr FROM DUAL;
				--
				
				INSERT INTO PRZEGLAD(PRZE_KOSZT, PRZE_DATA, PRZE_WAZNOSC, AUTO_ID_f)
				VALUES
				(50, to_date('01-01-2010', 'dd-mm-yy')+trunc(dbms_random.value(1,1000)),
				to_date('01-01-2010', 'dd-mm-yy')+trunc(dbms_random.value(1,1000)), auto_id_curr);
				
				--
				select SEQ_PRZEGLAD.currval INTO prze_id_curr FROM DUAL;
				--
				
				INSERT INTO UBEZPIECZENIE(UBEZ_NR_POLISY, UBEZ_DATA_START, UBEZ_DATA_STOP)
				VALUES
				(50||licznik, to_date('01-01-2010', 'dd-mm-yy')+trunc(dbms_random.value(1,1000)),
				to_date('01-01-2010', 'dd-mm-yy')+trunc(dbms_random.value(1,1000)));
				
				--
				select SEQ_UBEZPIECZENIE.currval INTO ubez_id_curr FROM DUAL;
				--
				
				
				licznik:=licznik + 1;
				
			END LOOP;
		COMMIT;	
END;
 /
 
 --wywolanie
 BEGIN
    SEQ_INSERT(10);
END;
/

--sprawdzenie
COLUMN  OSOB_IMIE FORMAT A30
COLUMN  ZAMI_MIASTO FORMAT A30
select * from V_OSOBA_ZAMIESZKANIA_MIEJSCE order by ZAMIESZKANIA_MIEJSCE;

/*
OSOBA                                    ZAMIESZKANIA_MIEJSCE
---------------------------------------- ----------------------------------------
Janusz1                                  Miasto1
Janusz10                                 Miasto10
Janusz2                                  Miasto2
Janusz3                                  Miasto3
Janusz4                                  Miasto4
Janusz5                                  Miasto5
Janusz6                                  Miasto6
Janusz7                                  Miasto7
Janusz8                                  Miasto8
Janusz9                                  Miasto9
*/


COLUMN  CENA_ZA_DOBE FORMAT 9999
COLUMN  AUTO_MODEL FORMAT A30
COLUMN  AUTO_DOSTEPNOSC FORMAT A30
select * from V_CENA_AUTO order by CENA;

/*
      CENA MODEL                                    DOSTEPNOSC
---------- ---------------------------------------- ----------------------------------------
       195 Model1                                   Tak
       593 Model9                                   Tak
      1174 Model8                                   Tak
      1637 Model5                                   Tak
      1831 Model4                                   Tak
      3190 Model7                                   Tak
      3501 Model10                                  Tak
      3561 Model3                                   Tak
      4923 Model2                                   Tak
      4992 Model6                                   Tak
*/
