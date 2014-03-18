drop table if exists `user`;
create table user(
user_id int(10) not null primary key auto_increment,
user_nickname varchar(64) not null,
user_pwd varchar(64) not null,
user_email varchar(64) not null,
user_category varchar(64) not null,
create_time datetime not null,
update_time timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
)ENGINE=InnoDB DEFAULT CHARSET=utf8;