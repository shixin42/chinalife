package com.chinalife.servlet;

import com.chinalife.dal.DAOException;
import com.chinalife.dal.DAOFacade;
import com.chinalife.dao.UserDAO;
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

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nickname = getParam(request, "nickname");
        String email = getParam(request, "email");
        String password = getParam(request, "password");
        String category = request.getParameter("category");
        UserCategory userCategory = UserCategory.valueOf(category.toUpperCase());
        Validate.notNull(userCategory, "Invalid category value:" + category);

        try {
            //Check nickname
            Long userId = DAOFacade.getDAO(UserDAO.class).queryUserByNickname(nickname);
            if (userId != null) {
                logger.error("Duplicate nickname.");
                createError(ErrorCode.DuplicateUserNicknameError, request);
                getFailureDispatcher(request).forward(request, response);
                return;

            }

            //Check email
            userId = DAOFacade.getDAO(UserDAO.class).queryUserByEmail(email);
            if (userId != null) {
                logger.error("Duplicate email.");
                createError(ErrorCode.DuplicateUserEmailError, request);
                getFailureDispatcher(request).forward(request, response);
                return;
            }

            //Register
            userId = DAOFacade.getDAO(UserDAO.class).createUser(nickname, password, email,
                    category.toString(), new Timestamp(System.currentTimeMillis()));

            logger.info("Successful create user " + userId);

            //Save to session
            User user = new User();
            user.setId(userId);
            user.setNickname(nickname);
            user.setEmail(email);

            HttpSession session = request.getSession();
            session.setAttribute("User", user);

            getSuccessDispatcher(request).forward(request, response);
        } catch (DAOException e) {
            logger.error("Failed query db:", e);
        }
    }
}
