package com.chinalife.dal.dbcp;

import org.apache.commons.lang3.Validate;
import org.apache.commons.pool2.BasePooledObjectFactory;
import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.impl.DefaultPooledObject;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by shixin on 3/11/14.
 */
public class DBConnectionFactory extends BasePooledObjectFactory<Connection> {
    private static final Logger logger = Logger.getLogger(DBConnectionFactory.class);

    private static final int LOGIN_TIMEOUT_IN_SECONDS = 1;
    private static final long DEFAULT_SQL_SOCKEY_CONNECT_TIMEOUT = 800;
    private static final long DEFAULT_SQL_SOCKEY_QUERY_TIMEOUT = 2000;
    private static final int DEFAULT_CONNECTION_VALIDATE_TIMEOUT = 5;

    private String url;
    private String userName;
    private String password;

    public DBConnectionFactory(String url, String userName, String password) {
        Validate.notEmpty(url);
        Validate.notEmpty(userName);
        Validate.notEmpty(password);
        
        this.url = url;
        this.userName = userName;
        this.password = password;
    }

    @Override
    public Connection create() throws Exception {
        logger.info("Making new db connection.");
        DriverManager.setLoginTimeout(LOGIN_TIMEOUT_IN_SECONDS);

        Properties properties = new Properties();
        properties.put("user", userName);
        properties.put("password", password);
        properties.put("enableQueryTimeouts", "true");
        properties.put("connectTimeout", String.valueOf(DEFAULT_SQL_SOCKEY_CONNECT_TIMEOUT));
        properties.put("socketTimeout", String.valueOf(DEFAULT_SQL_SOCKEY_QUERY_TIMEOUT));

        Connection con = DriverManager.getConnection(this.url, properties);
        Validate.notNull(con, "Failed to create connection.");
        logger.info("Successfully make new db connection:" + this.url);
        return con;
    }

    @Override
    public PooledObject<Connection> wrap(Connection o) {
        return new DefaultPooledObject<Connection>(o);
    }

    @Override
    public void destroyObject(PooledObject<Connection> pooledConnection) throws SQLException {
        logger.info("Destroying pooled connection:" + pooledConnection.toString());
        Connection connection = pooledConnection.getObject();
        if (null != connection) {
            connection.close();
        }
    }

    @Override
    public boolean validateObject(PooledObject<Connection> pooledObject) {
        logger.info("Validating pooled connection :" + pooledObject);
        Connection connection = pooledObject.getObject();
        if (null != connection) {
            try {
                if (connection.isClosed()) {
                    return false;
                }

                return connection.isValid(DEFAULT_CONNECTION_VALIDATE_TIMEOUT);
            } catch (SQLException e) {
                logger.error("Validating connection failed.", e);
                return false;
            }
        }
        return false;
    }
}
