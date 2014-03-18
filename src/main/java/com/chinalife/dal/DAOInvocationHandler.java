package com.chinalife.dal;

import com.chinalife.dal.converter.ConverterFactory;
import com.chinalife.util.TypeUtil;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by shixin on 3/12/14.
 */
class DAOInvocationHandler implements InvocationHandler {
    private static final Logger logger = Logger.getLogger(DAOInvocationHandler.class);

    private static Map<Method, DAOMethod> methodToDAOMethodMap = new HashMap<Method, DAOMethod>();

    /**
     * TODO:Add cache.
     * TODO:Add username and password encoding.
     * TODO:Add JMX monitor.
     *
     * @param o
     * @param method
     * @param objects
     * @return
     * @throws Throwable
     */
    @Override
    public Object invoke(Object o, Method method, Object[] objects) throws Throwable {
        DAOMethod daoMethod = getDAOMethod(method, objects);
        DBClient dbClient = new DBClient(daoMethod);

        Class<?> returnType = daoMethod.getReturnType();
        Class<?>[] returnGenericTypes = daoMethod.getReturnGenericTypes();
        Class<?> returnParameterType = returnGenericTypes.length > 0 ? returnGenericTypes[0] : returnType;

        try {
            Object returnValue = null;

            if (daoMethod.isSelect()) {
                //Find appropriate Converter instance.
                Converter<?> converter;
                if (daoMethod.isLastParameterConverter()) {
                    converter = (Converter<?>) objects[objects.length - 1];
                } else {
                    converter = ConverterFactory.getBasicConverter(returnParameterType);
                }
                Validate.notNull("Cant find converter.");

                // This is not a generic type, assume it's querying one object.
                if (returnGenericTypes.length == 0) {
                    return dbClient.executeQueryToOne(converter);
                }

                if (List.class.isAssignableFrom(returnType)) {
                    return dbClient.executeQueryToList(converter);
                }

                if (Set.class.isAssignableFrom(returnType)) {
                    return dbClient.executeQueryToSet(converter);
                }

                throw new UnsupportedOperationException("Unknown return type : " + returnValue.getClass().getName());
            } else {
                if (daoMethod.isApplyToAllTables()) {
                    returnValue = dbClient.executeUpdateForAllPartitions();
                } else {
                    returnValue = dbClient.executeUpdate();
                }
                returnValue = TypeUtil.tryConvertNumber(returnValue, returnType);

                return returnValue;
            }
        } catch (RuntimeException e) {
            logger.error("Encounter RuntimeException:", e);
            throw e;
        } catch (Exception e) {
            logger.error("Encounter SQLException:", e);
            throw e;
        }
    }

    private synchronized DAOMethod getDAOMethod(Method method, Object[] objects) {
        DAOMethod daoMethod = methodToDAOMethodMap.get(method);
        if (null == daoMethod) {
            daoMethod = new DAOMethod(method, objects);
            methodToDAOMethodMap.put(method, daoMethod);
        }
        return daoMethod;
    }
}