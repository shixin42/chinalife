drop table if exists house_sale_picture;
create table house_sale_picture(
house_id int(10) not null primary key,
picture_name varchar(64) not null,
picture_path varchar(128) not null,
create_time datetime not null,
update_time timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
)ENGINE=InnoDB DEFAULT CHARSET=utf8;