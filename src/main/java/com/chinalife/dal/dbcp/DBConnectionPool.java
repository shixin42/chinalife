package com.chinalife.dal.dbcp;

import com.chinalife.dal.configuration.DBRole;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.util.Properties;


/**
 * Created by shixin on 3/11/14.
 */
public class DBConnectionPool extends GenericObjectPool<Connection> {
    private static final Logger logger = Logger.getLogger(DBConnectionFactory.class);

    private String url;
    private DBRole dbRole;

    public DBConnectionPool(String url, String user, String password, DBRole dbRole, Properties properties) {
        super(new DBConnectionFactory(url, user, password));
        setup(properties);
        this.url = url;
        this.dbRole = dbRole;
    }

    public DBConnectionPool(String url, String user, String password, DBRole dbRole, GenericObjectPoolConfig config, Properties properties) {
        super(new DBConnectionFactory(url, user, password), config);
        setup(properties);
        this.url = url;
        this.dbRole = dbRole;
    }

    private void setup(Properties properties) {
        this.setLifo(false);
        this.setTestOnBorrow(true);
        this.setTestOnCreate(false);
        this.setTestOnReturn(false);
        this.setTestWhileIdle(true);
        this.setMinEvictableIdleTimeMillis(10 * 60 * 1000);
        this.setTimeBetweenEvictionRunsMillis(12 * 60 * 1000);

        this.setMaxTotal(Integer.parseInt(properties.getProperty("max.idle", "5")));
        this.setMaxTotal(Integer.parseInt(properties.getProperty("max.total", "50")));
    }

    public void close() {
        logger.info("Closing db connection pool for url:" + this.url);
        super.close();
    }

    public DBRole getDbRole() {
        return this.dbRole;
    }
}
