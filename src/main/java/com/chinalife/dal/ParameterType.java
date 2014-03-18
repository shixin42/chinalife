package com.chinalife.dal;

import java.math.BigDecimal;

/**
 * Created by shixin on 3/13/14.
 */
public enum ParameterType {
    STRING(String.class),
    BYTE_ARRAY(byte[].class),

    BYTE(byte.class, Byte.class),
    SHORT(short.class, Short.class),
    INT(int.class, Integer.class),
    LONG(long.class, Long.class),

    FLOAT(float.class, Float.class),
    DOUBLE(double.class, Double.class),

    BIG_DECIMAL(BigDecimal.class),

    DATE(java.sql.Date.class),
    TIME(java.sql.Time.class),
    TIMESTAMP(java.sql.Timestamp.class);

    private Class<?>[] clazzes;

    ParameterType(Class<?>... clazzes) {
        this.clazzes = clazzes;
    }

    public Class<?>[] getClazzes() {
        return clazzes;
    }
}