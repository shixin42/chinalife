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
    @SQL("insert into house_sale(title,district,status,address,type,room,toilet,carport,area,min_price,max_price," +
            "description,contact_person1,contact_phone1,contact_person2,contact_phone2,create_time) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)")
    Long createHouseSale(String title, String district, String status, String address, String type,
                         int room, int toilet, int carport, double area, double min_price, double max_price,
                         String desc, String person1, String phone1, String person2, String phone2, Timestamp createTime) throws DAOException;


}
