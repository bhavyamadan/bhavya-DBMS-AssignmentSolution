/*---------------------------------------------------------------------------*/
/* 1 Create the Database and the tables. */
/*---------------------------------------------------------------------------*/
create database if not exists TravelOnTheGo;
use TravelOnTheGo;

CREATE TABLE IF NOT EXISTS `price`(
 `Bus_Type` 		varchar(10) Not null,
 `Distance` 		int Not null,
 `Price` 			int not null,
 primary key(`Bus_type`,`Distance`));
 
CREATE TABLE IF NOT EXISTS `passenger`(
`Passenger_name` 	varchar(20), 
`Category` 			varchar(6),
`Gender` 			char,
`Boarding_City` 	varchar(15),
`Destination_City` 	varchar(15),
`Distance` 			int not null,
`Bus_Type` 			varchar(10) not null,
foreign key(`Bus_type`,`Distance`) REFERENCES `price`(`Bus_type`,`Distance`));
 
/*---------------------------------------------------------------------------*/
/* 2 Insert values in all the tables */
/*---------------------------------------------------------------------------*/
insert into `price` values("Sleeper",350,770);
insert into `price` values("Sleeper",500,1100);
insert into `price` values("Sleeper",600,1320);
insert into `price` values("Sleeper",700,1540);
insert into `price` values("Sleeper",1000,2200);
insert into `price` values("Sleeper",1200,2640);
insert into `price` values("Sleeper",1500,2700);
insert into `price` values("Sitting",500,620);
insert into `price` values("Sitting",600,744);
insert into `price` values("Sitting",700,868);
insert into `price` values("Sitting",1000,1240);
insert into `price` values("Sitting",1200,1488);
insert into `price` values("Sitting",1500,1860);
Select * from price;

insert into `passenger` values("Sejal","AC",'F',"Bengaluru","Chennai",350,"Sleeper");
insert into `passenger` values("Anmol","Non-AC",'M',"Mumbai","Hyderabad",700,"Sitting");
insert into `passenger` values("Pallavi","AC",'F',"Panaji","Bengaluru",600,"Sleeper");
insert into `passenger` values("Khusboo","AC",'F',"Chennai","Mumbai",1500,"Sleeper");
insert into `passenger` values("Udit","Non-AC",'M',"Trivandrum","panaji",1000,"Sleeper");
insert into `passenger` values("Ankur","AC",'M',"Nagpur","Hyderabad",500,"Sitting");
insert into `passenger` values("Hemant","Non-AC",'M',"panaji","Mumbai",700,"Sleeper");
insert into `passenger` values("Manish","Non-AC",'M',"Hyderabad","Bengaluru",500,"Sitting");
insert into `passenger` values("Piyush","AC",'M',"Pune","Nagpur",700,"Sitting");
Select * from passenger;

/*---------------------------------------------------------------------------*/
/* 3. How many females and how many male passengers travelled for a minimum 
	  distance of 600 KM s? */
/*---------------------------------------------------------------------------*/
select Gender,count(Gender) from `passenger` 
where Distance>=600 
group by Gender;

/*---------------------------------------------------------------------------*/
/* 4. Find the minimum ticket price for Sleeper Bus.
/*---------------------------------------------------------------------------*/
select min(price) from `price` 
where Bus_type="Sleeper";

/*---------------------------------------------------------------------------*/
/* 5. Select passenger names whose names start with character 'S'
/*---------------------------------------------------------------------------*/
select Passenger_name from `passenger` 
where Passenger_name like 'S%';

/*---------------------------------------------------------------------------*/
/* 6. Calculate price charged for each passenger displaying Passenger name, 
	  Boarding City, Destination City, Bus_Type, Price in the output
/*---------------------------------------------------------------------------*/
select pas.Passenger_name, pas.Boarding_City, pas.Destination_City, 
	   pri.Bus_Type, pri.Price 
from passenger as pas, price as pri 
where pas.Distance = pri.Distance 
and pas.Bus_Type = pri.Bus_Type;

/*---------------------------------------------------------------------------*/
/* 7. What are the passenger name/s and his/her ticket price who travelled 
	  in the Sitting bus for a distance of 1000 KM s
/*---------------------------------------------------------------------------*/
select pas.Passenger_name, pri.Price 
from passenger pas inner join price pri 
on  pas.Bus_Type = pri.Bus_Type 
and pas.Distance = pri.Distance 
and pas.Distance = 1000 
and pas.Bus_Type = 'Sitting';

/*---------------------------------------------------------------------------*/
/* 8. What will be the Sitting and Sleeper bus charge for Pallavi to travel 
	  from Bangalore to Panaji?
/*---------------------------------------------------------------------------*/
select Bus_Type, Price from `price` 
where Distance = (Select Distance from `passenger` where Passenger_name="Pallavi");

/*---------------------------------------------------------------------------*/
/* 9. List the distances from the "Passenger" table which are unique 
	  (non-repeated distances) in descending order.
/*---------------------------------------------------------------------------*/
select Distance from `passenger` 
group by Distance 
order by Distance Desc;

/*---------------------------------------------------------------------------*/
/* 10. Display the passenger name and percentage of distance travelled by that 
	   passenger from the total distance travelled by all passengers without 
       using user variables
/*---------------------------------------------------------------------------*/
select Passenger_name, Distance/(select sum(Distance) from `Passenger`)*100 
as Percentage_Distance_Traveled from `Passenger`;

/*---------------------------------------------------------------------------*/
/* 11. Display the distance, price in three categories in table Price
	a) Expensive if the cost is more than 1000
	b) Average Cost if the cost is less than 1000 and greater than 500 
    c) Cheap otherwise */
/*---------------------------------------------------------------------------*/
select Distance, Price,
case 
	when Price > 1000 then 'Expensive'
    when Price > 500 then 'Average Cost'
    else 'Cheaper'
end as Price_Category from `Price`;

