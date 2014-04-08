drop table if exists house_sale;
create table house_sale(
house_id int(10) not null primary key auto_increment,
title varchar(128) not null,
district varchar(128) not null,
status varchar(128) not null,
address varchar(1024) not null,
type varchar(128) not null,
room int(10) not null,
toilet int(10) not null,
carport int(10) not null,
area double not null,
min_price double not null,
max_price double not null,
description text,
contact_person1 varchar(64) not null,
contact_phone1 varchar(64) not null,
contact_person2 varchar(64),
contact_phone2 varchar(64),
create_time datetime not null,
update_time timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
)ENGINE=InnoDB DEFAULT CHARSET=utf8;