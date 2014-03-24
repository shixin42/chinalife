drop table if exists `house_sale`;
create table house_sale(
house_id int(10) not null primary key auto_increment,
house_room int(10) not null,
house_hall int(10) not null,
house_toilet int(10) not null,
house_carport int(10) not null,
house_area double not null,
house_price double not null,
house_community varchar(256) not null,
house_address varchar(256) not null,
house_title varchar(128) not null,
house_description text,
contact_person varchar(64) not null,
contact_phone varchar(64) not null,
create_time datetime not null,
update_time timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
)ENGINE=InnoDB DEFAULT CHARSET=utf8;