package com.chinalife.dal.converter;


import com.chinalife.dal.Converter;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ishikin on 14-3-15.
 */
public class IntegerConverter implements Converter<Integer> {
    @Override
    public Integer convert(ResultSet resultSet) throws SQLException {
        return new Integer(resultSet.getInt(1));
    }
}
