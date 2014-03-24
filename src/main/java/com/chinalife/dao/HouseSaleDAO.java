package com.chinalife.dao;

import com.chinalife.dal.DAOException;
import com.chinalife.dal.annotation.DAO;
import com.chinalife.dal.annotation.SQL;
import com.chinalife.dal.annotation.SQLControl;
import com.chinalife.dal.annotation.Table;

import java.sql.Timestamp;

/**
 * Created by shixin on 3/24/14.
 */
@DAO
public interface HouseSaleDAO {
    @Table("house_sale")
    @SQLControl(returnAotuGeneratedId = true)
    @SQL("insert into house_sale(house_room,house_hall,house_toilet,house_carport,house_area,house_price,house_community," +
            "house_address,house_title,house_description,contact_person,contact_phone,create_time) values (?,?,?,?,?,?,?,?,?,?,?,?,?)")
    Long createHouseSale(int room, int hall, int toilet, int carport, double area, double price, String community,
                         String address, String title, String description, String contactPerson, String contactPhone,
                         Timestamp createTime) throws DAOException;


}
