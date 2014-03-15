package com.chinalife.listener;

import com.shixin.dal.DBAccesser;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Properties;

/**
 * Created by ishikin on 14-3-16.
 */
public class SServletContextListener implements ServletContextListener {
    private Logger logger = Logger.getLogger(SServletContextListener.class);

    private String dbConfigName;

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext servletContext = servletContextEvent.getServletContext();

        this.dbConfigName = servletContext.getInitParameter("db.config.name");
        Validate.notEmpty(this.dbConfigName);

        Properties dbProperties = new Properties();
        String maxIdle = servletContext.getInitParameter("db.max.idle");
        if (StringUtils.isNoneEmpty(maxIdle)) {
            dbProperties.put("max.idle", Integer.parseInt(maxIdle));
        }
        String maxTotal = servletContext.getInitParameter("db.max.total");
        if (StringUtils.isNoneEmpty(maxTotal)) {
            dbProperties.put("max.total", Integer.parseInt(maxTotal));
        }

        File dbConfigFile = new File(this.dbConfigName);
        Validate.isTrue(dbConfigFile.exists(), "Cant find db config file : " + this.dbConfigName);

        try {
            DBAccesser.createInstance(new FileInputStream(dbConfigFile), dbProperties);
        } catch (FileNotFoundException e) {
            logger.error("Failed to create db accessor", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }
}
