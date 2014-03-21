package com.chinalife.dao;


import com.chinalife.dal.DAOException;
import com.chinalife.dal.annotation.DAO;
import com.chinalife.dal.annotation.SQL;
import com.chinalife.dal.annotation.SQLControl;
import com.chinalife.dal.annotation.Table;

import java.sql.Timestamp;

/**
 * Created by shixin on 3/18/14.
 */
@DAO
public interface UserDAO {
    @Table("user")
    @SQL("select user_id from user where user_nickname=?")
    Long queryUserByNickname(String nickname) throws DAOException;

    @Table("user")
    @SQL("select user_id from user where user_email=?")
    Long queryUserByEmail(String email) throws DAOException;

    @Table("user")
    @SQLControl(returnAotuGeneratedId = true)
    @SQL("insert into user(user_nickname,user_pwd,user_email,user_category,create_time) values (?,?,?,?,?)")
    Long createUser(String nickname, String pwd, String email, String category, Timestamp createTime) throws DAOException;

    @Table("user")
    @SQL("select user_id from user where user_nickname=? and user_pwd=?")
    Long login(String nickname, String pwd) throws DAOException;
}
