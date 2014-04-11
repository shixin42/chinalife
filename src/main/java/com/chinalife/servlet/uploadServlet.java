package com.chinalife.servlet;

import java.io.*;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.chinalife.dal.DAOException;
import com.chinalife.dal.DAOFacade;
import com.chinalife.dao.HouseSaleDAO;
import com.chinalife.dao.HouseSalePictureDAO;
import com.chinalife.utils.servlet.BaseServlet;
import com.chinalife.utils.servlet.FileUploadUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
/**
 * Created by Chao.Cui.VWED on 14-3-29.
 */
public class uploadServlet extends BaseServlet {

    private static final Logger logger = Logger.getLogger(LoginServlet.class);

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        logger.info("this is upload servlet");
        Validate.isTrue(ServletFileUpload.isMultipartContent(request), "Invalid request type.");

        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";

        try {
            List<FileItem> fileItems = FileUploadUtil.getFileIterms(request, getTmpPath(), -1, -1, null);

            File appDir = new File(getAppPath());
            Validate.isTrue(appDir.exists() && appDir.isDirectory(), "App dir is not exists.");

            File houseSalePictureDir = new File(appDir, "house-sale-picture");
            if (!houseSalePictureDir.exists()) {
                houseSalePictureDir.mkdir();
            }

            File myDir = new File(houseSalePictureDir, String.valueOf("1"));
            if (myDir.exists()) {
                logger.info(myDir.getAbsolutePath() + " exists, so delete it.");
                myDir.delete();
            }
            myDir.mkdir();

            String url = "";
            String name = "";
            String deleteUrl = "";
            String deleteType = "";
            String thumbnailUrl ="";
            //return to the website with json data.

//            File saveTo = new File("D:");
//            FileUploadUtil.saveToDisk(fileItems, saveTo, null,null);

            String json = "{\"files\":[{";
            for (FileItem fileItem : fileItems) {
                if (!fileItem.isFormField()) {
                    //logger.info("Found uploaded file:" + fileItem.getName());
                    File file = new File(myDir, fileItem.getName());
                    fileItem.write(file);
                    name = fileItem.getName();
                    url = basePath + "/"+"house-sale-picture/1/"+name;
                    thumbnailUrl = basePath + "/"+"house-sale-picture/1/"+name;
                    deleteType = "DELETE";
                    deleteUrl = "/chinalife/upload";
                    logger.info("Successfully save file basePath:" + basePath);
                    logger.info("Successfully save file name:" + name);
                    logger.info("Successfully save file url:" + url);
                    logger.info("Successfully save file deleteType:" + deleteType);
                    logger.info("Successfully save file deleteUrl:" + deleteUrl);
                    json += "\"name\":\""+name+"\",";
                    json += "\"url\":\""+url+"\",";
                    json += "\"deleteType\":\""+deleteType+"\",";
                    json += "\"deleteUrl\":\""+deleteUrl+"\",";
                    json += "\"thumbnailUrl\":\""+thumbnailUrl+"\"";
                    json += "}]";
                }
            }
            json += "}";
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            logger.info("json:"+json);
            out.println(json);
            out.flush();
            out.close();
//            getSuccessDispatcher(request).forward(request, response);
        } catch (DAOException e) {
            logger.error("Failed to create house for sale due to:", e);
        } catch (FileUploadException e) {
            logger.error("Failed to parse request", e);
        } catch (Exception e) {
            logger.error("Failed to parse request", e);
        }
    }
}
