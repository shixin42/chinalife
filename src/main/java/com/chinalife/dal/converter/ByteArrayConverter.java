package com.chinalife.dal.converter;


import com.chinalife.dal.Converter;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ishikin on 14-3-15.
 */
public class ByteArrayConverter implements Converter<byte[]> {
    @Override
    public byte[] convert(ResultSet resultSet) throws SQLException {
        return resultSet.getBytes(1);
    }
}
