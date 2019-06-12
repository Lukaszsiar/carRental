CLEAR SCREEN;
SET LINESIZE 230;
alter session set nls_date_format="YYYY-MM-DD";

create or replace procedure
	pZAMIESZKANIA_MIEJSCE_zla
	is
		nieprawidlowa_wartosc exception;
		PRAGMA EXCEPTION_INIT(nieprawidlowa_wartosc, -20005);
		TYPE miasto is record(
			z_id 		ZAMIESZKANIA_MIEJSCE.ZAMI_ID%TYPE,
			z_miasto	ZAMIESZKANIA_MIEJSCE.ZAMI_MIASTO%TYPE
		);
		
		cursor ZAMIESZKANIA_MIEJSCE_cursor
		is
			select z_id, z_miasto
			from ZAMIESZKANIA_MIEJSCE;
			
		miasto_tmp miasto;
			
		begin
			open ZAMIESZKANIA_MIEJSCE_cursor;
			loop
				fetch ZAMIESZKANIA_MIEJSCE_cursor into miasto_tmp;
				exit when
					ZAMIESZKANIA_MIEJSCE_cursor%NOTFOUND OR ZAMIESZKANIA_MIEJSCE_cursor%ROWCOUNT < 1;
				if LENGTH(miasto_tmp.z_miasto)=0
				then
					raise nieprawidlowa_wartosc;
				end if;
				if LENGTH(miasto_tmp.z_miasto)<3
				then
					INSERT INTO NOTIFICATIONS(NOT_CONTENT, ZAMI_ID, CAT_ID)
					VALUES ('Nieprawidlowa dlugosc nazwy miasta : '||miasto_tmp.z_miasto, miasto_tmp.z_id, 2);
				end if;				
			end loop;
				
			close ZAMIESZKANIA_MIEJSCE_cursor;
		exception
			when nieprawidlowa_wartosc
				then
					dbms_output.put_line('Miasto o zerowej dlugosci nazwy');
			when others 
				then
					dbms_output.put_line('Kursor nie zostal znaleziony');
		end;
/
select * from NOTIFICATIONS;


exec pZAMIESZKANIA_MIEJSCE_zla;