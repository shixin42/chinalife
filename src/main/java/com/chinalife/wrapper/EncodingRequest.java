package com.chinalife.wrapper;


import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.UnsupportedEncodingException;

/**
 * Created by shixin on 3/18/14.
 */
public class EncodingRequest extends HttpServletRequestWrapper {
    private static final Logger logger = Logger.getLogger(EncodingRequest.class);

    public EncodingRequest(HttpServletRequest request) {
        super(request);
    }

    @Override
    public String getParameter(String name) {
        String value = getRequest().getParameter(name);
        if (null != value) {
            try {
                byte[] bytes = value.getBytes("ISO-8859-1");
                return new String(bytes, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                logger.error("Failed to wrap request:", e);
                throw new RuntimeException(e);
            }
        }
        return value;
    }
}
