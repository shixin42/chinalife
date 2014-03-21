package com.chinalife.pojo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by shixin on 3/18/14.
 */
public class Error implements Serializable {
    private Map<Integer, String> errorInfo = new HashMap<Integer, String>();


    public Map<Integer, String> getErrorInfo() {
        return errorInfo;
    }

    public void setErrorInfo(Map<Integer, String> errorInfo) {
        this.errorInfo = errorInfo;
    }

    public void addErrorInfo(ErrorCode errorCode) {
        getErrorInfo().put(errorCode.getCode(), errorCode.getDescription());
    }
}
