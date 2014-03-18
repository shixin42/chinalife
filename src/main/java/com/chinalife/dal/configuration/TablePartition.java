package com.chinalife.dal.configuration;

import com.chinalife.dal.dbcp.DBConnectionPool;
import org.apache.commons.lang3.Validate;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Created by shixin on 3/12/14.
 */
public class TablePartition {
    private String name;
    private List<DBConnectionPool> masterPools = new ArrayList<DBConnectionPool>();
    private List<DBConnectionPool> slavePools = new ArrayList<DBConnectionPool>();

    private boolean isPartitioned = false;
    private int partitionNum;
    private String partitionColumn;
    private PartitionType partitionType;

    TablePartition(String name, List<DBConnectionPool> pools) {
        this.name = name;

        for (DBConnectionPool dbConnectionPool : pools) {
            if (dbConnectionPool.getDbRole() == DBRole.MASTER) {
                this.masterPools.add(dbConnectionPool);
            } else {
                this.slavePools.add(dbConnectionPool);
            }
        }
    }

    public boolean isPartitioned() {
        return this.isPartitioned;
    }

    void setPartitionInfo(int partitionNum, String partitionColumn, PartitionType partitionType) {
        this.isPartitioned = true;
        this.partitionNum = partitionNum;
        this.partitionColumn = partitionColumn;
        this.partitionType = partitionType;
    }

    public String lookupTable(String partitionValue) {
        Validate.isTrue(this.isPartitioned);

        long longValue = 0;
        if (this.partitionType == PartitionType.NUMBER) {
            longValue = Long.parseLong(partitionValue);
        } else {
            longValue = getDbStringHash(partitionValue);
        }

        return String.format(this.name + "_%d", longValue % this.partitionNum);
    }

    /**
     * It's used to get the hash value of a database partition value. <br>
     * This algorithm was first reported by Dan Bernstein many years ago in comp.lang.c
     *
     * @param str
     * @return
     */
    private long getDbStringHash(String str) {
        long hash = 5381;
        int idx = 0, len = str.length();
        char c;
        while (idx < len) {
            c = str.charAt(idx);
            hash = ((hash << 5) + hash) + c; // hash*33 + c
            idx++;
        }
        if (hash < 0) {
            hash = -hash;
        }
        return hash;
    }

    public String getPartitionColumn() {
        return partitionColumn;
    }

    public int getPartitionNum() {
        return this.partitionNum;
    }

    //TODO: how select one
    public DBConnectionPool lookupDBConnectionPool(DBRole dbRole) {
        if (DBRole.MASTER == dbRole) {
            return masterPools.get(new Random(System.currentTimeMillis()).nextInt(masterPools.size()));
        } else {
            return slavePools.get(new Random(System.currentTimeMillis()).nextInt(slavePools.size()));
        }
    }
}
