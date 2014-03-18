package com.chinalife.dal.configuration;

import com.chinalife.dal.dbcp.DBConnectionPool;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.InputStream;
import java.util.*;

/**
 * Created by shixin on 3/12/14.
 */
public class DBPartitionConfig {
    private static final Logger logger = Logger.getLogger(DBPartitionConfig.class);

    private Map<String, DBConnectionPool> nameToPoolMap = new HashMap<String, DBConnectionPool>();
    private Map<String, TablePartition> nameToTablesMap = new HashMap<String, TablePartition>();

    public static final String PT_NUMBER = "number";
    public static final String PT_TEXT = "text";

    /**
     * <connections>
     * <connection name="" url="" user="" pwd="" role=""></connection>
     * <connections/>
     * <tables>
     * <table name="" con_refs="" partition_num="" partition_column="" partition_type=""></table>
     * </tables>
     *
     * @param inputStream
     * @param properties
     * @throws org.dom4j.DocumentException
     */
    public void loadFromStream(InputStream inputStream, Properties properties) throws DocumentException {
        Element root = new SAXReader().read(inputStream).getRootElement();

        logger.info("Beginning parse db connections.");
        for (Element conE : (List<Element>) root.element("connections").elements("connection")) {
            String name = conE.attributeValue("name");
            String url = conE.attributeValue("url");
            String user = conE.attributeValue("user");
            String pwd = conE.attributeValue("pwd");
            String role = conE.attributeValue("role");

            if (nameToPoolMap.containsKey(name)) {
                logger.error("Duplicated connection name:" + name + ", so skip it.");
                continue;
            }

            Validate.notEmpty(name, "Connection name can not be empty.");
            Validate.notEmpty(url, "Connection url can not be empty.");
            Validate.notEmpty(user, "Connection user can not be empty.");
            Validate.notEmpty(pwd, "Connection pwd can not be empty.");
            Validate.notEmpty(role, "Connection role can not be empty.");

            DBRole dbRole = DBRole.valueOf(role.toUpperCase());
            Validate.notNull(dbRole);

            DBConnectionPool pool = new DBConnectionPool(url, user, pwd, dbRole, properties);
            nameToPoolMap.put(name, pool);

            logger.info("Successfully create db pool for url:" + url);
        }

        for (Element tableE : (List<Element>) root.element("tables").elements("table")) {
            String name = tableE.attributeValue("name");
            String connectionRefs = tableE.attributeValue("con_refs");
            Validate.notEmpty(name, "Table name can not be empty.");
            Validate.notEmpty(connectionRefs, "Table con_refs can not be empty.");

            if (this.nameToTablesMap.containsKey(name)) {
                logger.error("Duplicated table name:" + name + ", so skip it.");
                continue;
            }

            String[] connections = connectionRefs.split(";");
            Validate.notEmpty(connections, "There is no valid con_refs.");
            Set<String> uniqueConns = new HashSet<String>(Arrays.asList(connections));

            List<DBConnectionPool> pools = new ArrayList<DBConnectionPool>();
            for (String connection : uniqueConns) {
                DBConnectionPool pool = this.nameToPoolMap.get(connection);
                Validate.notNull(pool, "Get non connection pool for ref:" + connection);
                pools.add(pool);
            }

            TablePartition tablePartition = new TablePartition(name, pools);
            nameToTablesMap.put(name, tablePartition);

            String partitionNumStr = tableE.attributeValue("partition_num");
            if (StringUtils.isNoneBlank(partitionNumStr)) {
                int partitionNum = Integer.parseInt(partitionNumStr);
                if (partitionNum <= 0) {
                    throw new IllegalArgumentException("Invalid parameter partition_num");
                }

                String partitionColumn = tableE.attributeValue("partition_column");
                String partitionTypeStr = tableE.attributeValue("partition_type");
                PartitionType partitionType = PartitionType.valueOf(partitionTypeStr.toUpperCase());
                Validate.notEmpty(partitionColumn, "Table partition_column can not be empty.");
                Validate.notNull(partitionType, "Table partition_type can not be empty.");

                tablePartition.setPartitionInfo(partitionNum, partitionColumn, partitionType);
            }

            logger.info("Successfully load conf for table:" + name);
        }
    }

    public TablePartition getTablePartition(String tableName) {
        return this.nameToTablesMap.get(tableName);
    }
}
