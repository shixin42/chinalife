package com.chinalife.servlet;

import com.chinalife.dal.DAOException;
import com.chinalife.dal.DAOFacade;
import com.chinalife.dao.UserDAO;
import com.chinalife.pojo.Error;
import com.chinalife.pojo.ErrorCode;
import com.chinalife.pojo.User;
import com.chinalife.user.UserCategory;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;

/**
 * Created by ishikin on 14-3-18.
 */
public class RegisterServlet extends BaseServlet {
    private static final Logger logger = Logger.getLogger(RegisterServlet.class);

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
        String userNickname = request.getParameter("user_nickname");
        String userEmail = request.getParameter("user_email");
        String userPwd = request.getParameter("user_pwd");
        UserCategory category = UserCategory.CUSTOMER;

        try {
            Long userId = DAOFacade.getDAO(UserDAO.class).queryUserByNickname(userNickname);
            if (userId != null) {
                Error error = new Error();
                error.addErrorInfo(ErrorCode.DuplicateUserNicknameError);

                request.setAttribute("Error", error);
                request.getRequestDispatcher(this.failAction).forward(request, response);
            }

            userId = DAOFacade.getDAO(UserDAO.class).queryUserByEmail(userEmail);
            if (userId != null) {
                Error error = new Error();
                error.addErrorInfo(ErrorCode.DuplicateUserEmailError);

                request.setAttribute("Error", error);
                request.getRequestDispatcher(this.failAction).forward(request, response);
            }

            userId = DAOFacade.getDAO(UserDAO.class).createUser(userNickname, userPwd, userEmail,
                    category.toString().toUpperCase(), new Timestamp(System.currentTimeMillis()));
            logger.info("Successful create user " + userId);

            User user = new User();
            user.setId(userId);
            user.setNickname(userNickname);
            user.setEmail(userEmail);

            HttpSession session = request.getSession();
            session.setAttribute("User", user);

            request.getRequestDispatcher(this.successAction).forward(request, response);

        } catch (DAOException e) {
            logger.error("Failed query db:", e);
        }
    }
}
