create or replace procedure
	pZAMIESZKANIA_MIEJSCE_update (miasto in varchar2, nowe_miasto in varchar2)
	is
		xMiasto ZAMIESZKANIA_MIEJSCE.ZAMI_MIASTO%TYPE;
		
		cursor ZAMIESZKANIA_MIEJSCE_cursor
		is
			select ZAMI_MIASTO
			from ZAMIESZKANIA_MIEJSCE
			where ZAMI_MIASTO=miasto
		for update of ZAMI_MIASTO;
			
		begin
			open ZAMIESZKANIA_MIEJSCE_cursor;
			loop
				fetch ZAMIESZKANIA_MIEJSCE_cursor into xMiasto;
				exit when
					ZAMIESZKANIA_MIEJSCE_cursor%NOTFOUND OR ZAMIESZKANIA_MIEJSCE_cursor%ROWCOUNT < 1;
					
				update ZAMIESZKANIA_MIEJSCE
				set ZAMI_MIASTO=nowe_miasto
				where current of ZAMIESZKANIA_MIEJSCE_cursor;
				
			end loop;
				
			close ZAMIESZKANIA_MIEJSCE_cursor;
		exception
			when others 
				then
					dbms_output.put_line('Nie znaleziono kursora');
		end;
/
select ZAMI_MIASTO from ZAMIESZKANIA_MIEJSCE;
/*
Procedure created.


ZAMI_MIASTO
----------------------------------------
Nieznane
Nieznane
Nieznane


PL/SQL procedure successfully completed.


ZAMI_MIASTO
----------------------------------------
Miasto
Miasto
Miasto
*/

exec pZAMIESZKANIA_MIEJSCE_update('Nieznane','Miasto');
select ZAMI_MIASTO from ZAMIESZKANIA_MIEJSCE;

create or replace procedure
	pN_ZAMIESZKANIA_MIEJSCE_update (miasto in varchar2, nowe_miasto in varchar2)
	is
	begin
		for dane in (select ZAMI_MIASTO from ZAMIESZKANIA_MIEJSCE where ZAMI_MIASTO like 'Nieznane')
			loop
				exit when
					SQL%NOTFOUND OR
					SQL%ROWCOUNT < 1;
				dbms_output.put_line('test');
				update ZAMIESZKANIA_MIEJSCE
				set ZAMI_MIASTO=nowe_miasto
				where ZAMI_MIASTO like miasto;
			end loop;
		exception
			when others
				then
					dbms_output.put_line('Nie znaleziono kursora');
		end;
/
/*

*/
exec pN_ZAMIESZKANIA_MIEJSCE_update('Miasto', 'Nieznane');
