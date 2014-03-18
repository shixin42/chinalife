package com.chinalife.dal.converter;


import com.chinalife.dal.Converter;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ishikin on 14-3-15.
 */
public class FloatConverter implements Converter<Float> {
    @Override
    public Float convert(ResultSet resultSet) throws SQLException {
        return resultSet.getFloat(1);
    }
}
