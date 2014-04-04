package com.chinalife.utils;

import org.apache.commons.lang3.Validate;

import java.util.Map;

/**
 * Created by shixin on 4/4/14.
 */
public class Utils {
    public static String getStrFromMap(Map<String, String> map, String key) {
        Validate.isTrue(map.containsKey(key));
        Validate.notEmpty(map.get(key));
        return map.get(key);
    }
}
