package com.chinalife.servlet;

import com.chinalife.dal.DAOException;
import com.chinalife.dal.DAOFacade;
import com.chinalife.dao.UserDAO;
import com.chinalife.pojo.ErrorCode;
import com.chinalife.pojo.User;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by shixin on 3/18/14.
 */
public class LoginServlet extends BaseServlet {
    private static final Logger logger = Logger.getLogger(LoginServlet.class);

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nickname = getParam(request, "nickname");
        String password = getParam(request, "password");

        try {
            Long userId = DAOFacade.getDAO(UserDAO.class).login(nickname, password);

            if (null == userId) {
                createError(ErrorCode.LoginError, request);
                getFailureDispatcher(request).forward(request, response);
            } else {
                User user = new User();
                user.setId(userId);
                user.setNickname(nickname);

                updateSession(request, user);
                getSuccessDispatcher(request).forward(request, response);
            }
        } catch (DAOException e) {
            logger.error("Failed to login due to:", e);
        }
    }
}
