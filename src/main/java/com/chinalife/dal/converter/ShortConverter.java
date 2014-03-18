package com.chinalife.dal.converter;



import com.chinalife.dal.Converter;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ishikin on 14-3-15.
 */
public class ShortConverter implements Converter<Short> {
    @Override
    public Short convert(ResultSet resultSet) throws SQLException {
        return new Short(resultSet.getShort(1));
    }
}
