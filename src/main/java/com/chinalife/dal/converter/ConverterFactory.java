package com.chinalife.dal.converter;



import com.chinalife.dal.Converter;

import java.sql.Timestamp;

/**
 * Created by ishikin on 14-3-15.
 */
public class ConverterFactory {
    public static <T> Converter<T> getBasicConverter(Class<T> clazz) {
        if (clazz == Byte.class)
            return (Converter<T>) new ByteConverter();

        if (clazz == Short.class)
            return (Converter<T>) new ShortConverter();

        if (clazz == Integer.class)
            return (Converter<T>) new IntegerConverter();

        if (clazz == Long.class)
            return (Converter<T>) new LongConverter();

        if (clazz == Float.class)
            return (Converter<T>) new FloatConverter();

        if (clazz == Double.class)
            return (Converter<T>) new DoubleConverter();

        if (clazz == String.class)
            return (Converter<T>) new StringConverter();

        if (clazz == Timestamp.class)
            return (Converter<T>) new TimestampConverter();

        if (clazz == byte[].class)
            return (Converter<T>) new ByteArrayConverter();

        throw new UnsupportedClassVersionError("Can't find basic converter.");
    }
}
