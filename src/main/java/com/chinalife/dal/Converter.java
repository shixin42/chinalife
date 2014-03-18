package com.chinalife.dal;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by shixin on 3/12/14.
 */
public interface Converter<T> {
    T convert(ResultSet resultSet) throws SQLException;
}