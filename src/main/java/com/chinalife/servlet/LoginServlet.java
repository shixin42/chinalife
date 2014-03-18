package com.chinalife.servlet;

import com.chinalife.dal.DAOException;
import com.chinalife.dal.DAOFacade;
import com.chinalife.dao.UserDAO;
import com.chinalife.pojo.Error;
import com.chinalife.pojo.ErrorCode;
import com.chinalife.pojo.User;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by shixin on 3/18/14.
 */
public class LoginServlet extends BaseServlet {
    private static final Logger logger = Logger.getLogger(LoginServlet.class);

    private String successAction;
    private String failAction;

    @Override
    public void init() {
        this.successAction = getInitParameter("success");
        this.failAction = getInitParameter("fail");

        Validate.notEmpty(successAction, "Must define success action");
        Validate.notEmpty(failAction, "Must define fail action");
    }

    @Override
    public void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nickname = request.getParameter("user_nickname");
        String password = request.getParameter("user_pwd");

        try {
            Long userId = DAOFacade.getDAO(UserDAO.class).login(nickname, password);
            if (null == userId) {
                com.chinalife.pojo.Error error = new Error();
                error.addErrorInfo(ErrorCode.LoginError);

                request.setAttribute("Error", error);
                request.getRequestDispatcher(failAction).forward(request, response);
            } else {
                User user = new User();
                user.setId(userId);
                user.setNickname(nickname);

                HttpSession session = request.getSession();
                session.setAttribute("User", user);
                request.getRequestDispatcher(successAction).forward(request, response);
            }
        } catch (DAOException e) {
            logger.error("Failed to login due to:", e);
        }
    }
}
