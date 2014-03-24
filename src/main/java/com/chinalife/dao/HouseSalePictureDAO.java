package com.chinalife.dao;

import com.chinalife.dal.DAOException;
import com.chinalife.dal.annotation.DAO;
import com.chinalife.dal.annotation.SQL;
import com.chinalife.dal.annotation.Table;

import java.sql.Timestamp;

/**
 * Created by shixin on 3/24/14.
 */
@DAO
public interface HouseSalePictureDAO {
    @Table("house_sale_picture")
    @SQL("insert into house_sale_picture(house_id,picture_name,picture_path,picture_content,create_time) values (?,?,?,?,?)")
    void createHouseSalePicture(long id, String name, String path, byte[] content, Timestamp createTime) throws DAOException;
}
