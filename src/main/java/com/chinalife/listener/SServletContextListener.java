package com.chinalife.listener;

import com.chinalife.dal.DBAccesser;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.SessionCookieConfig;
import java.io.InputStream;
import java.util.Properties;

/**
 * Created by ishikin on 14-3-16.
 */
public class SServletContextListener implements ServletContextListener {
    private Logger logger = Logger.getLogger(SServletContextListener.class);

    private ServletContext servletContext;

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        try {
            logger.info("Initializing ServletContext.");
            this.servletContext = servletContextEvent.getServletContext();

            initDB();
            initHttpSession();
        } catch (Exception e) {
            logger.error("Failed init ServerContext due to:", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }

    private void initDB() {
        String dbConfigName = servletContext.getInitParameter("db.config.name");
        Validate.notEmpty(dbConfigName, "db.config.name cant be empty!");

        Properties dbProperties = new Properties();
        String maxIdle = servletContext.getInitParameter("db.max.idle");
        if (StringUtils.isNoneEmpty(maxIdle)) {
            dbProperties.put("max.idle", Integer.parseInt(maxIdle));
        }
        String maxTotal = servletContext.getInitParameter("db.max.total");
        if (StringUtils.isNoneEmpty(maxTotal)) {
            dbProperties.put("max.total", Integer.parseInt(maxTotal));
        }

        InputStream dbStream = getClass().getClassLoader().getResourceAsStream(dbConfigName);
        Validate.notNull(dbStream, "Cant find db config file : " + dbConfigName);

        DBAccesser.createInstance(dbStream, dbProperties);
    }

    private void initHttpSession() {
        SessionCookieConfig config = servletContext.getSessionCookieConfig();
        config.setMaxAge(60 * 60 * 24 * 7); //7 days
        config.setName("CHINALIFT_SESSION_ID");
    }
}
