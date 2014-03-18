package com.chinalife.dal;

import com.chinalife.dal.annotation.HashKey;
import com.chinalife.dal.annotation.SQL;
import com.chinalife.dal.annotation.SQLControl;
import com.chinalife.dal.annotation.Table;
import com.chinalife.dal.configuration.DBRole;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import java.lang.annotation.Annotation;
import java.lang.reflect.*;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by shixin on 3/12/14.
 */
class DAOMethod {
    private static final Logger logger = Logger.getLogger(DAOMethod.class);

    private final Table tableAnnotation;
    private final String tabaleName;
    private String hashedTableName;

    private final SQL sqlAnnotation;
    private final String sqlStatement;
    private String formattedSqlStatement;

    private final SQLControl sqlControlAnnotation;
    private boolean useSlave = false;
    private boolean applyToAllTables = false;
    private boolean returnAotuGeneratedId = false;

    private final Object[] arguments;

    private final Class<?> returnType;
    private final Class<?>[] returnGenericTypes;
    private final Class<?>[] exceptionTypes;
    private ParameterType[] parameterTypes;

    private final boolean isHashed;
    private boolean isSelect = false;
    private boolean isLastParameterConverter;

    DAOMethod(Method method, Object[] arguments) {
        this.arguments = arguments == null ? new Object[0] : arguments;

        this.tableAnnotation = method.getAnnotation(Table.class);
        Validate.notNull(this.tableAnnotation, "Need Table annotation");

        this.tabaleName = this.tableAnnotation.value();
        Validate.notEmpty(this.tabaleName, "Table name can't be empty");

        this.isHashed = DBAccesser.getInstance().isTablePartitioned(tabaleName);

        this.sqlAnnotation = method.getAnnotation(SQL.class);
        Validate.notNull(this.sqlAnnotation, "Need SQL annotation");

        this.sqlStatement = this.sqlAnnotation.value();
        Validate.notEmpty(this.sqlStatement);

        this.isSelect = StringUtils.startsWithIgnoreCase(sqlStatement, "select");

        this.sqlControlAnnotation = method.getAnnotation(SQLControl.class);
        if (null != this.sqlControlAnnotation) {
            this.useSlave = this.sqlControlAnnotation.useSlave();
            this.applyToAllTables = this.sqlControlAnnotation.applyToAllTables();
            this.returnAotuGeneratedId = this.sqlControlAnnotation.returnAotuGeneratedId();
        }

        this.exceptionTypes = method.getExceptionTypes();
        Validate.notEmpty(this.exceptionTypes, "Must declare DAOException.");
        boolean hasDAOException = false;
        for (Class<?> clazz : this.exceptionTypes) {
            if (clazz == DAOException.class) {
                hasDAOException = true;
                break;
            }
        }
        Validate.isTrue(hasDAOException, "Must declare DAOException.");

        this.returnType = method.getReturnType();
        this.returnGenericTypes = getActualClasses(method.getGenericReturnType());

        //Get partitioned key index.
        int hashKeyNum = 0;
        int hashKeyIndex = -1;
        Annotation[][] parameterAnnotations = method.getParameterAnnotations();
        for (int i = 0; i < parameterAnnotations.length; i++) {
            for (Annotation annotation : parameterAnnotations[i]) {
                if (annotation instanceof HashKey) {
                    hashKeyIndex = i;
                    hashKeyNum++;
                }
            }
        }
        Validate.isTrue(1 >= hashKeyNum, "There can only has one HashKey annotation in method.");
        if (this.isHashed && !this.isApplyToAllTables()) {
            Validate.isTrue(0 == hashKeyIndex, "There must be @HashKey in method : " + method.getName());

            this.hashedTableName = DBAccesser.getInstance().lookupTable(this.tabaleName, arguments[0].toString());

            this.formattedSqlStatement = this.sqlStatement.replaceFirst(
                    String.format("\\b%s\\b", this.tabaleName),
                    this.hashedTableName);
        }
        //TODO: Validate the HashKey corresponding the PartitionKey in configuration.


        Class<?>[] rawParameterTypes = method.getParameterTypes();
        if (rawParameterTypes.length > 0) {
            this.isLastParameterConverter = (Converter.class.isAssignableFrom(rawParameterTypes[rawParameterTypes.length - 1]));
        }

        int parameterLength = this.isLastParameterConverter ? rawParameterTypes.length - 1 : rawParameterTypes.length;

        this.parameterTypes = new ParameterType[parameterLength];
        for (int i = 0; i < parameterLength; i++) {
            ParameterType parameterType = getParameterType(rawParameterTypes[i]);
            Validate.notNull(parameterType, "Invalid DAO method parameter type : " + rawParameterTypes[i].getName());
            this.parameterTypes[i] = parameterType;
        }

        Validate.isTrue(parameterTypes.length == getPlaceholdersNum(sqlStatement),
                "Parameters's count should be equal to ?'s count.");
    }

    public boolean isLastParameterConverter() {
        return this.isLastParameterConverter;
    }

    public boolean isApplyToAllTables() {
        return applyToAllTables;
    }

    public boolean isReturnAotuGeneratedId() {
        return returnAotuGeneratedId;
    }

    private Class<?>[] getActualClasses(Type genericReturnType) {
        if (genericReturnType instanceof ParameterizedType) {
            Type[] actualTypes = ((ParameterizedType) genericReturnType).getActualTypeArguments();
            Class<?>[] actualClasses = new Class<?>[actualTypes.length];
            for (int i = 0; i < actualTypes.length; i++) {
                Type actualType = actualTypes[i];
                if (actualType instanceof Class<?>) {
                    actualClasses[i] = (Class<?>) actualType;
                } else if (actualType instanceof GenericArrayType) {
                    Type componentType = ((GenericArrayType) actualType).getGenericComponentType();
                    actualClasses[i] = Array.newInstance((Class<?>) componentType, 0).getClass();
                }
            }
        }
        return new Class<?>[0];
    }

    private ParameterType getParameterType(Class<?> clazz) {
        for (ParameterType parameterType : ParameterType.values()) {
            for (Class<?> subClazz : parameterType.getClazzes()) {
                if (clazz == subClazz)
                    return parameterType;
            }
        }
        return null;
    }

    public ParameterType[] getParameterTypes() {
        return this.parameterTypes;
    }

    private int getPlaceholdersNum(String sql) {
        Pattern pattern = Pattern.compile("[\\?]");
        Matcher matcher = pattern.matcher(sql);

        int i = 0;
        while (matcher.find()) {
            i++;
        }

        return i;
    }

    public boolean isSelect() {
        return isSelect;
    }

    public DBRole getDBRole() {
        return useSlave ? DBRole.SLAVE : DBRole.MASTER;
    }

    public String getSql() {
        return this.sqlStatement;
    }

    public boolean isHashed() {
        return this.isHashed;
    }

    public String getTabaleName() {
        return this.tabaleName;
    }

    public String getHashedTableName() {
        return this.hashedTableName;
    }

    /**
     * TODO: Assumption: the auto-generated id is always the first
     *
     * @return
     */
    public int getAutoGeneratedKeyIndex() {
        return 1;
    }

    public String getRealSql() {
        if (this.isHashed()) {
            return this.formattedSqlStatement;
        } else {
            return this.getSql();
        }
    }

    public Object[] getRealArguments() {
        if (this.isLastParameterConverter) {
            return Arrays.copyOfRange(this.arguments, 0, this.arguments.length - 1);
        } else {
            return Arrays.copyOfRange(this.arguments, 0, this.arguments.length);
        }
    }

    public Class<?> getReturnType() {
        return this.returnType;
    }

    public Class<?>[] getReturnGenericTypes(){
        return this.returnGenericTypes;
    }
}