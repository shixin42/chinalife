package com.chinalife.utils.servlet;

import com.chinalife.utils.servlet.pojo.Error;
import com.chinalife.utils.servlet.pojo.ErrorCode;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.Map;

/**
 * Created by ishikin on 14-3-18.
 */
public abstract class BaseServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(BaseServlet.class);

    private static final String INIT_PARAM_KEY_SUCCESS = "s";
    private static final String INIT_PARAM_KEY_FAILURE = "f";

    private static final String ERROR_ATTR_NAME = "error";
    private static final String USER_ATTR_NAME = "user";

    protected String successAction;
    protected String failureAction;

    @Override
    public void init() {
        successAction = getInitParameter(INIT_PARAM_KEY_SUCCESS);
        failureAction = getInitParameter(INIT_PARAM_KEY_FAILURE);
        logger.info("Success action : " + successAction);
        logger.info("Failure action : " + failureAction);
    }

    protected String getAppPath() {
        return getServletContext().getRealPath("/");
    }

    protected String getTmpPath() {
        return getServletContext().getInitParameter("tmp");
    }

    protected RequestDispatcher getSuccessDispatcher(HttpServletRequest request) {
        Validate.notEmpty(successAction, "Cant find success action.");
        return request.getRequestDispatcher(successAction);
    }

    protected RequestDispatcher getFailureDispatcher(HttpServletRequest request) {
        Validate.notEmpty(failureAction, "Cant find failure action.");
        return request.getRequestDispatcher(failureAction);
    }

    protected double getDouble(Map<String, String> map, String key) {
        Validate.isTrue(map.containsKey(key));
        Validate.notEmpty(map.get(key));
        return Double.parseDouble(map.get(key));
    }

    protected int getInt(Map<String, String> map, String key) {
        Validate.isTrue(map.containsKey(key));
        Validate.notEmpty(map.get(key));
        return Integer.parseInt(map.get(key));
    }

    protected String getStr(Map<String, String> map, String key) {
        Validate.isTrue(map.containsKey(key));
        Validate.notEmpty(map.get(key));
        return map.get(key);
    }

    /**
     * Will throw RuntimeException
     *
     * @param request
     * @param name
     * @return
     */
    protected String getParam(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        Validate.notBlank(value, "Miss parameter:" + name);
        return value;
    }

    /**
     * Given default value.
     *
     * @param request
     * @param name
     * @param defaultValue
     * @return
     */
    protected int getIntParam(HttpServletRequest request, String name, int defaultValue) {
        if (hasParam(request, name)) {
            return getIntParam(request, name);
        } else {
            return defaultValue;
        }
    }

    protected boolean hasParam(HttpServletRequest request, String name) {
        if (null != request.getParameter(name))
            return true;
        return false;
    }

    protected int getIntParam(HttpServletRequest request, String name) {
        return Integer.parseInt(getParam(request, name));
    }

    protected double getDoubleParam(HttpServletRequest request, String name) {
        return Double.parseDouble(getParam(request, name));
    }

    private void logRequestParams(HttpServletRequest request) {
        Enumeration<String> e = request.getParameterNames();
        while (e.hasMoreElements()) {
            String paramName = e.nextElement();
            logger.info("Param name:" + paramName + ", param value:" + request.getParameter(paramName));
        }
    }

    protected void addError(HttpServletRequest request, ErrorCode errorCode) {
        Error error = (Error) request.getAttribute(ERROR_ATTR_NAME);
        if (null != error) {
            error.getErrorInfo().clear();
            error.addErrorInfo(errorCode);
        } else {
            error = new Error();
            error.addErrorInfo(errorCode);
            request.setAttribute(ERROR_ATTR_NAME, error);
        }
    }

    protected void addAttribute(HttpServletRequest request, Scope scope, String name, Object value) {
        switch (scope) {
            case REQUEST:
                if (request.getAttribute(name) != null) {
                    request.removeAttribute(name);
                }
                request.setAttribute(name, value);
                break;
            case SESSION:
                HttpSession httpSession = request.getSession();
                if (httpSession.getAttribute(name) != null) {
                    httpSession.removeAttribute(name);
                }
                httpSession.setAttribute(name, value);
                break;
            case APPLICATION:
                ServletContext applicaton = request.getServletContext();
                if (applicaton.getAttribute(name) != null) {
                    applicaton.removeAttribute(name);
                }
                applicaton.setAttribute(name, value);
                break;
            default:
                logger.error("Invalid scope enum : " + scope);
        }
    }

    private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        logger.info("Enter servlet.");
        logRequestParams(request);

        doProcess(request, response);
    }

    abstract protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException;

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        process(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        process(request, response);
    }

    protected enum Scope {
        REQUEST, SESSION, APPLICATION;
    }
}
