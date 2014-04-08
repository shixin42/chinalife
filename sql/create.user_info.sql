drop table if exists `user_info`;
create table user_info(
user_id int(10) not null primary key,
cellphone_number varchar(16),
telephone_number varchar(32),
country varchar(32),
city varchar(32),
address varchar(32),
birthday date,
create_time datetime not null,
update_time timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
)ENGINE=InnoDB DEFAULT CHARSET=utf8;