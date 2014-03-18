package com.chinalife.util;

import org.apache.commons.lang3.Validate;

/**
 * Created by ishikin on 14-3-15.
 */
public class TypeUtil {
    public static Object tryConvertNumber(Object arg, Class<?> returnType) {
        Validate.notNull(arg);

        if (!(arg instanceof Number) || arg.getClass() == returnType) {
            return arg;
        }

        Number number = (Number) arg;
        if (returnType == byte.class || returnType == Byte.class) {
            return Byte.valueOf(number.byteValue());
        }
        if (returnType == short.class || returnType == Short.class) {
            return Short.valueOf(number.shortValue());
        }
        if (returnType == int.class || returnType == Integer.class) {
            return Integer.valueOf(number.intValue());
        }
        if (returnType == long.class || returnType == Long.class) {
            return Long.valueOf(number.longValue());
        }
        if (returnType == float.class || returnType == Float.class) {
            return Float.valueOf(number.floatValue());
        }
        if (returnType == double.class || returnType == Double.class) {
            return Double.valueOf(number.doubleValue());
        }
        return number;
    }
}
