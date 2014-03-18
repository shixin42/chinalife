package com.chinalife.dal.converter;

import com.chinalife.dal.Converter;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ishikin on 14-3-15.
 */
public class LongConverter implements Converter<Long> {

    @Override
    public Long convert(ResultSet resultSet) throws SQLException {
        return new Long(resultSet.getLong(1));
    }
}
