package com.chinalife.servlet.admin;

import com.chinalife.utils.servlet.BaseServlet;
import com.chinalife.utils.servlet.FileUploadUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ishikin on 14-4-14.
 */
public class UploadServlet extends BaseServlet {
    private static Logger logger = Logger.getLogger(UploadServlet.class);

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            Validate.isTrue(ServletFileUpload.isMultipartContent(request), "Invalid request form type.");

            String appPath = getAppPath();

            File houseSalePictureDir = new File(appPath, "house-sale-pictures");
            if (!houseSalePictureDir.exists()) {
                houseSalePictureDir.mkdir();
            }

            File savePath = new File(houseSalePictureDir, System.currentTimeMillis() + "");
            savePath.mkdir();

            response.setContentType("application/json");
            PrintWriter printWriter = response.getWriter();

            ObjectMapper objectMapper = new ObjectMapper();

            List<UploadResponse> uploadResponses = new ArrayList<UploadResponse>();
            try {
                String tmpPath = getTmpPath();
                List<FileItem> items = FileUploadUtil.getFileIterms(request, tmpPath, 0, 0, null);

                for (FileItem item : items) {
                    if (!item.isFormField()) {
                        File savedFile = new File(savePath, item.getName());
                        item.write(savedFile);
                        logger.info("Saved file " + item.getName() + " to " + savedFile.getPath());

                        UploadResponse uploadResponse = new UploadResponse();
                        uploadResponse.setName(item.getName());
                        uploadResponse.setSize(item.getSize());
                        uploadResponse.setPath(savedFile.getPath());

                        uploadResponses.add(uploadResponse);
                    }
                }
            } catch (Exception e) {
                logger.error(e);
                throw new ServletException(e);
            } finally {
                String responseContent = objectMapper.writeValueAsString(uploadResponses);
                logger.info("Response content : " + responseContent);

                printWriter.write(responseContent);
                printWriter.close();
            }
        } else {
            if (hasParam(request, "deleteFile")) {
                String filePath = getParam(request, "deleteFile");
                File file = new File(filePath);
                file.delete();
            }
        }
    }

    private static class UploadResponse {
        private String name;
        private long size;
        private String path;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public long getSize() {
            return size;
        }

        public void setSize(long size) {
            this.size = size;
        }

        public String getPath() {
            return path;
        }

        public void setPath(String path) {
            this.path = path;
        }
    }
}
