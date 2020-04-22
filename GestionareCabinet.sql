create database GestionareCabinet
use GestionareCabinet

create table Cabinet
(cod_c int primary key,
adresa varchar(100)
);

create table Animal
(cod_a int primary key,
nume varchar(50),
tip varchar(50),
cod_c int foreign key 
references Cabinet(cod_c)
on delete set null
on update set null
);


create table Ambulanta
(cod_amb int primary key,
pret_deplasare int,
cod_c int foreign key
references Cabinet(cod_c)
on delete set null
on update set null
);

create table Doctor
(cnp int primary key,
nume varchar(50),
data_n date,
cod_c int foreign key 
references Cabinet(cod_c)
on delete set null
on update set null
);

create table Diagnostic
(cod_d int primary key,
denumire varchar(50)
);

create table Reteta
(cod_a int foreign key
references Animal(cod_a)
on delete cascade 
on update cascade,
cod_d int foreign key
references Diagnostic(cod_d)
on delete cascade
on update cascade,
constraint pk_Reteta primary key
(cod_a,cod_d)
);


insert into Cabinet(cod_c,adresa) values(1,'Str Zimbrului, nr 9');
insert into Cabinet(cod_c,adresa)values(2,'Str Libertatii,nr 2');
insert into Cabinet(cod_c,adresa)values(3,'Str Pacii,nr 10');
insert into Cabinet(cod_c,adresa)values(4,'Str Secului,nr 8');
insert into Cabinet(cod_c,adresa)values(5,'Str Lalelei,nr 2');

insert into Doctor(cnp,nume, data_n,cod_c) values(10,'Pop Ioan','1999-11-17',1);
insert into Doctor(cnp,nume,data_n,cod_c) values(12,'Rus Ionela','2000-10-20',2);
insert into Doctor(cnp,nume,data_n,cod_c) values(13,'Toader Maria','1989-06-07',3);
insert into Doctor(cnp,nume,data_n,cod_c) values(15,'Alexandra Pop','2000-09-09',4);
insert into Doctor(cnp,nume,data_n,cod_c) values(17,'Ioana Adam','1989-06-09',5);
insert into Doctor(cnp,nume,data_n,cod_c) values(16,'Ioana Maria','1989-02-08',4);
insert into Doctor(cnp,nume,data_n,cod_c) values(199,'Ion Adam','1969-04-08',4);
insert into Doctor(cnp,nume,data_n,cod_c) values(23,'Ionut Pop','1970-04-06',3);
insert into Doctor(cnp,nume,data_n,cod_c) values(20,'Ionut Albul','1970-04-06',3);
insert into Doctor(cnp,nume,data_n,cod_c) values(21,'Ionut Albul','1970-04-07',3);
insert into Doctor(cnp,nume,data_n,cod_c) values(22,'Ionut Albul','1989-05-06',3);



insert into Animal(cod_a,nume,tip,cod_c)values(7,'Pufi','caine',1);
insert into Animal(cod_a,nume,tip,cod_c)values(8,'Mara','pisica',2);
insert into Animal(cod_a,nume,tip,cod_c)values(9,'Omega','malamut de Alaska',3);
insert into Animal(cod_a,nume,tip,cod_c)values(20,'Balkan','husky',2);
insert into Animal(cod_a,nume,tip,cod_c)values(4,'Tomas','pisica',4);
insert into Animal(cod_a,nume,tip,cod_c)values(78,'Mickey','husky',4);


insert into Diagnostic(cod_d,denumire) values(178,' Leptospiroza');
insert into Diagnostic(cod_d,denumire)values(009,'Colita');
insert into Diagnostic(cod_d,denumire) values(224,'Parvoviroza');
insert into Diagnostic(cod_d,denumire) values(445,'Dermatoza');

insert into Reteta(cod_a,cod_d) values(7,178);
insert into Reteta(cod_a,cod_d) values(7,009);
insert into Reteta(cod_a,cod_d)values(20,224);
insert into Reteta(cod_a,cod_d)values(8,009);
insert into Reteta(cod_a,cod_d)values(20,009);
insert into Reteta(cod_a,cod_d)values(4,224);
insert into Reteta(cod_a,cod_d)values(4,445);
insert into Reteta(cod_a,cod_d)values(4,178);


insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(334,200,1);
insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(228,200,2);
insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(129,150,3);
insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(77,200,2);
insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(999,NULL,4);
insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(556,150,NULL);
insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(22,130,4);
insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(666,130,4);
insert into Ambulanta(cod_amb,pret_deplasare,cod_c)values(668,130,2);

update Animal set nume='Anyta' where cod_a=8

update Doctor set data_n='1979-11-12' where cnp<=10
delete from Reteta where cod_a=7;

delete from Animal where cod_a=7;
delete from Animal where cod_a=78 AND cod_c=4;
delete from Animal where cod_a=8;

update Ambulanta set pret_deplasare=200 where pret_deplasare IS NULL;
delete from Ambulanta where cod_c IS NULL;
update Ambulanta set pret_deplasare=200 where cod_c IS NOT NULL;


select * from Doctor
SELECT  * FROM Ambulanta

/*LAB 3*/
/*numele tuturor doctorilor care lucreaza la cabinetul 1 sau 2 -UNION */

select d.nume from Doctor d inner join Cabinet c on d.cod_c=c.cod_c 
where c.cod_c=1
union 
select d.nume from Doctor d inner join Cabinet c on d.cod_c=c.cod_c
where c.cod_c=2

/*adresa cabinetelor care au animale cu tipul 'pisica'- INNER JOIN*/

select c.adresa from Cabinet c inner join Animal a on c.cod_c=a.cod_c 
where a.tip='pisica' ;


--numele tuturor animalelor indiferent daca sunt sau nu inregistrate cu un anumit diagnostic - LEFT JOIN */

select distinct a.nume  from Animal a left join Reteta r on a.cod_a=r.cod_a;


--denumirea si codul diagnosticelor care se gasesc pe retetele animalelor cu tipul'pisica'

select d.denumire, d.cod_d from Diagnostic d inner join Reteta r on d.cod_d=r.cod_d inner join Animal a on r.cod_a=a.cod_a 
where a.tip='pisica';
 
 --cabinetele care are cel putin 2 doctori-GROUP BY

 select c.adresa, count(d.cnp) from Cabinet c inner join Doctor d on c.cod_c=d.cod_c group by adresa having count(d.cnp)>2;

  
  --numele animalelor care au diagnosticul 'Dermatoza'-GROUP BY

  select a.nume from Animal a inner join Reteta r on a.cod_a=r.cod_a inner join Diagnostic d on d.cod_d=r.cod_d where d.denumire='Parvoviroza' group by nume;


--selectarea cabinetelor cu pretul maxim al ambulantei-GROUP BY
select c.adresa, max(a.pret_deplasare) from Cabinet c inner join Ambulanta a on a.cod_c=c.cod_c group by adresa ;

--numele doctorilor care lucreaza la cabinetul cu adresa 'Str.Pacii,nr10'

select distinct d.nume from Doctor d inner join Cabinet c on c.cod_c=d.cod_c where c.adresa='Str Pacii,nr 10';

--pentru fiecare cabinet se selecteaza pretul minim al ambulantei
select c.adresa, min(a.pret_deplasare) from Cabinet c inner join Ambulanta a on a.cod_c=c.cod_c group by adresa order by min(a.pret_deplasare);