package com.chinalife.dal;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ishikin on 14-3-15.
 */
interface ResultSetVisitor<ReturnType, ConverterType> {
    ReturnType visit(ResultSet resultSet, Converter<ConverterType> converter) throws SQLException;
}