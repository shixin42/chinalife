package com.chinalife.dal;

import com.chinalife.dal.configuration.DBPartitionConfig;
import com.chinalife.dal.configuration.DBRole;
import com.chinalife.dal.configuration.TablePartition;
import com.chinalife.dal.dbcp.DBConnectionPool;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import java.io.InputStream;
import java.util.Properties;

/**
 * Created by ishikin on 14-3-12.
 */
public class DBAccesser {
    private static Logger logger = Logger.getLogger(DBAccesser.class);

    private static DBAccesser instance = null;

    private DBPartitionConfig dbPartitionConfig;

    private DBAccesser(DBPartitionConfig dbPartitionConfig) {
        this.dbPartitionConfig = dbPartitionConfig;
    }

    public static synchronized void createInstance(InputStream inputStream, Properties properties) {
        if (null == instance) {
            try {
                Class.forName("com.mysql.jdbc.Driver");

                DBPartitionConfig dbPartitionConfig = new DBPartitionConfig();
                dbPartitionConfig.loadFromStream(inputStream, properties);
                instance = new DBAccesser(dbPartitionConfig);
            } catch (Exception e) {
                logger.error(e);
                throw new RuntimeException("Failed to load partition configuration.");
            }
        }
    }

    public static DBAccesser getInstance() {
        if (null == instance) {
            throw new RuntimeException("Please initialize first.");
        }
        return instance;
    }

    public boolean isTablePartitioned(String tableName) {
        TablePartition tablePartion = this.dbPartitionConfig.getTablePartition(tableName);
        Validate.notNull(tablePartion, "Can't get table partition config for : " + tableName);
        return tablePartion.isPartitioned();
    }

    public String getPartitionColumn(String tableName) {
        TablePartition tablePartion = this.dbPartitionConfig.getTablePartition(tableName);
        return tablePartion.getPartitionColumn();
    }

    public String lookupTable(String tableName, String partitionedValue) {
        TablePartition tablePartion = this.dbPartitionConfig.getTablePartition(tableName);
        return tablePartion.lookupTable(partitionedValue);
    }

    public DBConnectionPool lookupDBPool(String tableName, DBRole dbRole) {
        TablePartition tablePartion = this.dbPartitionConfig.getTablePartition(tableName);
        return tablePartion.lookupDBConnectionPool(dbRole);
    }

    public String[] getAllPartitionedTables(String tableName) {
        TablePartition tablePartion = this.dbPartitionConfig.getTablePartition(tableName);
        Validate.notNull(tablePartion, "Can't get table partition config for : " + tableName);

        if (tablePartion.isPartitioned()) {
            String[] allPartitionedTables = new String[tablePartion.getPartitionNum()];
            for (int i = 0; i < tablePartion.getPartitionNum(); i++) {
                allPartitionedTables[i] = tableName + "_" + i;
            }
            return allPartitionedTables;
        } else {
            return new String[]{tableName};
        }
    }

    //TODO
    public void close() {
    }
}
