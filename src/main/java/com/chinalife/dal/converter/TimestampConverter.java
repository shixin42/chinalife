package com.chinalife.dal.converter;


import com.chinalife.dal.Converter;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 * Created by ishikin on 14-3-15.
 */
public class TimestampConverter implements Converter<Timestamp> {
    @Override
    public Timestamp convert(ResultSet resultSet) throws SQLException {
        return resultSet.getTimestamp(1);
    }
}
