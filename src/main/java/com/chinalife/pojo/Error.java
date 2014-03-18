package com.chinalife.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by shixin on 3/18/14.
 */
public class Error {
    private Map<Integer, String> errorInfo = new HashMap<Integer, String>();

    public Map<Integer, String> getErrorInfo() {
        return errorInfo;
    }

    public void addErrorInfo(ErrorCode errorCode) {
        errorInfo.put(errorCode.getCode(), errorCode.getDescription());
    }
}
