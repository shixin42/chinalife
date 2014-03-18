drop table if exists `user`;
create table user(
user_id int(10) not null primary key auto_increment,
user_nickname varchar(64) not null,
user_pwd varchar(64) not null,
user_email varchar(64) not null,
user_category varchar(64) not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
update_time timestamp on update CURRENT_TIMESTAMP
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists `user_info`;
create table user_info(
user_id int(10) not null primary key,
cellphone_number varchar(16),
telephone_number varchar(32),
country varchar(32),
city varchar(32),
address varchar(32),
birthday date,
create_time timestamp not null default CURRENT_TIMESTAMP,
update_time timestamp on update CURRENT_TIMESTAMP
)ENGINE=InnoDB DEFAULT CHARSET=utf8;