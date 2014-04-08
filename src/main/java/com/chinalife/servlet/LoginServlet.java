package com.chinalife.servlet;

import com.chinalife.dal.DAOFacade;
import com.chinalife.dao.UserDAO;
import com.chinalife.user.User;
import com.chinalife.utils.servlet.BaseServlet;
import com.chinalife.utils.servlet.pojo.ErrorCode;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by shixin on 3/18/14.
 */
public class LoginServlet extends BaseServlet {
    private static final Logger logger = Logger.getLogger(LoginServlet.class);

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String nickname = getParam(request, "nickname");
        String password = getParam(request, "password");
        String userRand = getParam(request, "captcha");
        logger.info("nickname:"+nickname+" :password:"+password + "captcha:"+userRand);

        try {
            String sysRand = (String)request.getSession().getAttribute("rand");;

            Long userId = DAOFacade.getDAO(UserDAO.class).login(nickname, password);

            //validate the captcha for logon
            if(!userRand.equals(sysRand)){
                addError(request, ErrorCode.CaptchaError);
                getFailureDispatcher(request).forward(request, response);
            }
            else if (null == userId) {
                addError(request, ErrorCode.LoginError);
                getFailureDispatcher(request).forward(request, response);
            } else {
                User user = new User();
                user.setId(userId);
                user.setNickname(nickname);

                addAttribute(request, Scope.SESSION, "user", user);
                getSuccessDispatcher(request).forward(request, response);
            }
        } catch (Exception e) {
            logger.error(e);
            throw new ServletException(e);
        }
    }
}
