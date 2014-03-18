package com.chinalife.dal;

import com.chinalife.dal.annotation.DAO;
import org.apache.commons.lang3.Validate;

import java.lang.annotation.Annotation;
import java.lang.reflect.Proxy;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by shixin on 3/12/14.
 */
public class DAOFacade {
    private static Map<Class<?>, Object> daoObjects = new HashMap<Class<?>, Object>();

    private DAOFacade() {
    }

    public synchronized static <T> T getDAO(Class<T> clazz) {
        Object dao = daoObjects.get(clazz);
        if (null == dao) {
            dao = createProxyInstance(clazz);
            daoObjects.put(clazz, dao);
        }
        return (T) dao;
    }

    private static <T> T createProxyInstance(Class<T> clazz) {
        Annotation annotation = clazz.getAnnotation(DAO.class);
        Validate.notNull(annotation, "Interface must have DAO annotation.");
        Validate.isTrue(clazz.isInterface(), "Class must be interface");
        return (T) Proxy.newProxyInstance(clazz.getClassLoader(), new Class<?>[]{clazz}, new DAOInvocationHandler());
    }
}
