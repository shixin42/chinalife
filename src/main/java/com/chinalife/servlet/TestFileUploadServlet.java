package com.chinalife.servlet;

import com.chinalife.utils.servlet.BaseServlet;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;

/**
 * Created by shixin on 3/24/14.
 */
public class TestFileUploadServlet extends BaseServlet {
    private static final Logger logger = Logger.getLogger(TestFileUploadServlet.class);

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try {
            logger.info(getServletContext().getRealPath("/"));
            logger.info(request.getServletPath());


            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (isMultipart) {
                DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
                diskFileItemFactory.setRepository(new File("/tmp"));

                ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);

                List<FileItem> files = servletFileUpload.parseRequest(request);

                for (FileItem fileItem : files) {
                    if (fileItem.isFormField()) {
                        logger.info("Field name:" + fileItem.getFieldName());
                        logger.info("Field value:" + fileItem.getString());
                    } else {
                        logger.info("Field name:" + fileItem.getFieldName());
                        logger.info("File name:" + fileItem.getName());
                        logger.info("Content type:" + fileItem.getContentType());
                        logger.info("Size type:" + fileItem.getSize());
                        logger.info("Is in memory" + fileItem.isInMemory());
                        //fileItem.write(new File("webapps/chinalife/" + fileItem.getName()));
                    }
                }
            } else {
                logger.error("Is not multipart");
            }
        } catch (FileUploadException e) {
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }
    }
}