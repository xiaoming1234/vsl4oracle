create tablespace ep datafile 'C:\APP\ADMINISTRATOR\ORADATA\ORCL\EP01.DBF' size 500m autoextend on next 50m segment space management auto;

create temporary tablespace temp_ep tempfile 'C:\APP\ADMINISTRATOR\ORADATA\ORCL\TEMP_EP01.DBF' size 50m;

create user vsl identified by epvsl default tablespace ep temporary tablespace temp_ep;

grant dba to vsl;


drop sequence epvsl_sq;
drop sequence epvslmsg_sq;

drop table epvslmsg;
drop table epvsl;

create table epvsl(
	id number primary key not null,
    vslid varchar2(20) not null,
    vslname varchar2(35) not null,
    vslnamecn varchar2(35),
    expvoy varchar2(10),
    impvoy varchar2(10),
    berpln varchar2(20),
    unberpln varchar2(20),
    port varchar2(10),
    berthcode varchar2(10),
    beract varchar2(20),
    unberact varchar2(20),
	flag number not null,
	canceled number not null
);

create table epvslmsg(
	id number primary key not null,
	vslname varchar2(35) not null,
	content clob
);

create sequence epvsl_sq;
create sequence epvslmsg_sq;

create or replace trigger epvsl_tr
before insert on epvsl
for each row

begin
select epvsl_sq.nextval into :new.id from dual;
end;
/

create or replace trigger epvslmsg_tr
before insert on epvslmsg
for each row

begin
select epvslmsg_sq.nextval into :new.id from dual;
end;
/