package com.chinalife.servlet;

import com.chinalife.pojo.Error;
import com.chinalife.pojo.ErrorCode;
import com.chinalife.pojo.User;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;

/**
 * Created by ishikin on 14-3-18.
 */
public abstract class BaseServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(BaseServlet.class);

    private static final String ERROR_ATTR_NAME = "error";
    private static final String USER_ATTR_NAME = "user";

    protected String successAction;
    protected String failureAction;

    @Override
    public void init() {
        successAction = getInitParameter("s");
        failureAction = getInitParameter("f");

        Validate.notEmpty(successAction, "Must define success action");
        Validate.notEmpty(failureAction, "Must define failure action");

        logger.info("Success action :" + successAction);
        logger.info("Failure action :" + failureAction);
    }


    private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("Enter servlet.");
        logRequestParams(request);
        doProcess(request, response);
    }

    abstract protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;


    protected void logRequestParams(HttpServletRequest request) {
        Enumeration<String> e = request.getParameterNames();
        while (e.hasMoreElements()) {
            String paramName = e.nextElement();
            logger.info("Param name:" + paramName + ", param value:" + request.getParameter(paramName));
        }
    }

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

    protected String getParam(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        Validate.notBlank(value, "Miss parameter:" + name);
        return value;
    }

    protected void createError(ErrorCode errorCode, HttpServletRequest request) {
        Error error = (Error) request.getAttribute(ERROR_ATTR_NAME);
        if (null != error) {
            error.getErrorInfo().clear();
        } else {
            error = new Error();
        }

        error.addErrorInfo(errorCode);
        request.setAttribute(ERROR_ATTR_NAME, error);
    }

    protected void updateSession(HttpServletRequest request, User user) {
        HttpSession httpSession = request.getSession();
        if (httpSession.getAttribute(USER_ATTR_NAME) != null) {
            ((User) httpSession.getAttribute(USER_ATTR_NAME)).update(user);
        } else {
            httpSession.setAttribute(USER_ATTR_NAME, user);
        }
    }

    protected RequestDispatcher getSuccessDispatcher(HttpServletRequest request) {
        return request.getRequestDispatcher(successAction);
    }

    protected RequestDispatcher getFailureDispatcher(HttpServletRequest request) {
        return request.getRequestDispatcher(failureAction);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }
}
