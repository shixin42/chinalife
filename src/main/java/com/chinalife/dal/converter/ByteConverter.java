package com.chinalife.dal.converter;



import com.chinalife.dal.Converter;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ishikin on 14-3-15.
 */
public class ByteConverter implements Converter<Byte> {
    @Override
    public Byte convert(ResultSet resultSet) throws SQLException {
        return new Byte(resultSet.getByte(1));
    }
}
