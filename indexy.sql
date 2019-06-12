CLEAR SCREEN;

set serveroutput on;
set LINESIZE 140


--PERSPEKTYWY

create or replace view V_OSOBA_ZAMIESZKANIA_MIEJSCE
(OSOBA, ZAMIESZKANIA_MIEJSCE)
as
SELECT OSOB_IMIE, ZAMI_MIASTO from OSOBA, ZAMIESZKANIA_MIEJSCE WHERE ZAMI_ID_f = ZAMI_ID;

COLUMN  OSOB_IMIE FORMAT A30
COLUMN  ZAMI_MIASTO FORMAT A30
select * from V_OSOBA_ZAMIESZKANIA_MIEJSCE order by ZAMIESZKANIA_MIEJSCE;

--

create or replace view V_CENA_AUTO
(Cena, Model, Dostepnosc)
as
SELECT CENA_ZA_DOBE, AUTO_MODEL, AUTO_DOSTEPNOSC from CENA, AUTO WHERE CENA_ID_f = CENA_ID;

COLUMN  CENA_ZA_DOBE FORMAT 9999
COLUMN  AUTO_MODEL FORMAT A30
COLUMN  AUTO_DOSTEPNOSC FORMAT A30
select * from V_CENA_AUTO order by CENA;


--INDEXY

DROP INDEX IX_OSOBA
DROP INDEX IX_ZAMIESZKANIA_MIEJSCE


CREATE INDEX IX_OSOBA
ON OSOBA(OSOB_IMIE)
STORAGE(INITIAL 10k NEXT 10k)
TABLESPACE STUDENT_INDEX;

--

CREATE INDEX IX_ZAMIESZKANIA_MIEJSCE
ON ZAMIESZKANIA_MIEJSCE(ZAMI_MIASTO)
STORAGE(INITIAL 10k NEXT 10k)
TABLESPACE STUDENT_INDEX;



--PROCEDURY

CREATE OR REPLACE PROCEDURE ZAMI_INSERT(ile IN number)
IS
licznik number(2);
BEGIN
	licznik:=1;
	WHILE 
		licznik < ile+1
		LOOP
			INSERT INTO ZAMIESZKANIA_MIEJSCE(ZAMI_KRAJ, ZAMI_WOJEWODZTWO, ZAMI_KOD_POCZTOWY, ZAMI_MIASTO)
			VALUES
			('Polska', 'Lubelskie'||licznik, 21200, 'Parczew'||licznik);
			licznik:=licznik + 1;
		END LOOP;
END;
/

SAVEPOINT INSERT1;

BEGIN
	ZAMI_INSERT(10);
END;
/


COLUMN  ZAMI_KRAJ FORMAT A30
COLUMN  ZAMI_WOJEWODZTWO FORMAT A30
COLUMN  ZAMI_KOD_POCZTOWY FORMAT 99999
COLUMN  ZAMI_MIASTO FORMAT A30
SELECT * FROM ZAMIESZKANIA_MIEJSCE;

/*
   ZAMI_ID ZAMI_KRAJ                      ZAMI_WOJEWODZTWO               ZAMI_KOD_POCZTOWY ZAMI_MIASTO
---------- ------------------------------ ------------------------------ ----------------- ------------------------------
         1 Polska                         Lubelskie1                                 21200 Parczew1
         2 Polska                         Lubelskie2                                 21200 Parczew2
         3 Polska                         Lubelskie3                                 21200 Parczew3
         4 Polska                         Lubelskie4                                 21200 Parczew4
         5 Polska                         Lubelskie5                                 21200 Parczew5
         6 Polska                         Lubelskie6                                 21200 Parczew6
         7 Polska                         Lubelskie7                                 21200 Parczew7
         8 Polska                         Lubelskie8                                 21200 Parczew8
         9 Polska                         Lubelskie9                                 21200 Parczew9
        10 Polska                         Lubelskie10                                21200 Parczew10
*/

ROLLBACK TO SAVEPOINT INSERT1;

COLUMN  ZAMI_KRAJ FORMAT A30
COLUMN  ZAMI_WOJEWODZTWO FORMAT A30
COLUMN  ZAMI_KOD_POCZTOWY FORMAT 99999
COLUMN  ZAMI_MIASTO FORMAT A30
SELECT * FROM ZAMIESZKANIA_MIEJSCE;

/*
no rows selected
*/

