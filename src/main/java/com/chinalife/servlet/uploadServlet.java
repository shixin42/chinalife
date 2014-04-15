package com.chinalife.servlet;

import com.chinalife.utils.io.FileIOUtil;
import com.chinalife.utils.servlet.BaseServlet;
import com.chinalife.utils.servlet.FileUploadUtil;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;
import org.imgscalr.Scalr;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ishikin on 14-4-14.
 */
public class UploadServlet extends BaseServlet {
    private static Logger logger = Logger.getLogger(UploadServlet.class);

    private static final String SAVED_PATH_KEY = "save.path";
    private static final String PARAM_KEY_GET_FILE = "getFile";
    private static final String PARAM_KEY_GET_THUMBNAIL = "getThumbnail";
    private static final String PARAM_KEY_DEL_FILE = "delFile";

    private long current;

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            logger.info("Enter upload servlet get method.");

            if (hasParam(request, PARAM_KEY_GET_FILE)) {
                logger.info("Enter get file method.");

                BufferedInputStream in = null;
                ServletOutputStream out = null;

                try {
                    String savedPath = getAppPath() + "/" + getParam(request, PARAM_KEY_GET_FILE);
                    logger.info("Saved path : " + savedPath);

                    File file = new File(savedPath);
                    Validate.isTrue(file.exists() && file.isFile());

                    in = new BufferedInputStream(new FileInputStream(file));

                    String mimeType = FileIOUtil.getMIMEType(file);
                    logger.info("MIME type : " + mimeType);

                    response.setContentType(mimeType);
                    response.setContentLength((int) file.length());
                    response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");
                    out = response.getOutputStream();

                    byte[] buffer = new byte[1024];
                    while (-1 != in.read(buffer)) {
                        out.write(buffer);
                    }
                } finally {
                    if (null != in) {
                        in.close();
                    }
                    if (null != out) {
                        out.close();
                    }
                }
            } else if (hasParam(request, PARAM_KEY_GET_THUMBNAIL)) {
                logger.info("Enter get thumbnail method.");

                ServletOutputStream out = null;
                try {
                    String savedPath = getAppPath() + "/" + getParam(request, PARAM_KEY_GET_THUMBNAIL);
                    logger.info("Saved path : " + savedPath);

                    File file = new File(savedPath);
                    Validate.isTrue(file.exists() && file.isFile());

                    String mimeType = FileIOUtil.getMIMEType(file);
                    if (mimeType.endsWith("png") || mimeType.endsWith("jpeg")
                            || mimeType.endsWith("gif") || mimeType.endsWith("jpg")) {
                        BufferedImage im = ImageIO.read(file);
                        if (im != null) {
                            BufferedImage thumb = Scalr.resize(im, 75);

                            ByteArrayOutputStream in = new ByteArrayOutputStream();
                            if (mimeType.endsWith("png")) {
                                ImageIO.write(thumb, "PNG", in);
                                response.setContentType("image/png");
                            } else if (mimeType.endsWith("jpeg") || mimeType.endsWith("jpg")) {
                                ImageIO.write(thumb, "jpg", in);
                                response.setContentType("image/jpeg");
                            } else {
                                ImageIO.write(thumb, "GIF", in);
                                response.setContentType("image/gif");
                            }

                            response.setContentLength(in.size());
                            response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");
                            out = response.getOutputStream();

                            in.writeTo(out);
                        }
                    } else {
                        logger.error("Unsupported MIME type : " + mimeType);
                    }
                } finally {
                    if (out != null) {
                        out.close();
                    }
                }
            } else if (hasParam(request, PARAM_KEY_DEL_FILE)) {
                logger.info("Enter delete file method.");

                String savedPath = getAppPath() + "/" + getParam(request, PARAM_KEY_DEL_FILE);
                File file = new File(savedPath);

                logger.info("Deleted file : " + file.getPath());
                file.delete();

                JSONObject ret = new JSONObject();
                JSONArray jArray = new JSONArray();
                JSONObject fileObject = new JSONObject();
                fileObject.put(file.getName(), "true");
                jArray.put(fileObject);
                ret.put("files", jArray);

                response.setContentType("application/json");
                PrintWriter printWriter = response.getWriter();
                printWriter.println(ret.toString());
                printWriter.close();
            }
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            Validate.isTrue(ServletFileUpload.isMultipartContent(request), "Invalid request form type.");

            current = System.currentTimeMillis();
            String savedPath = getInitParameter(SAVED_PATH_KEY);
            Validate.notBlank(savedPath, "Must define save path.");
            File savedDir = getSavedDir(savedPath);
            //String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ request.getContextPath() + "/";

            response.setContentType("application/json");
            PrintWriter printWriter = response.getWriter();

            ObjectMapper objectMapper = new ObjectMapper();
            List<UploadResponse> uploadResponses = new ArrayList<UploadResponse>();

            try {
                String tmpPath = getTmpPath();
                List<FileItem> items = FileUploadUtil.getFileIterms(request, tmpPath, 0, 0, null);

                for (FileItem item : items) {
                    if (!item.isFormField()) {
                        File savedFile = new File(savedDir, item.getName());
                        item.write(savedFile);
                        logger.info("Saved file " + item.getName() + " to " + savedFile.getPath());

                        UploadResponse uploadResponse = new UploadResponse();
                        uploadResponse.setName(item.getName());
                        uploadResponse.setSize(item.getSize());

                        String realPath = getSavedPath(savedPath, item.getName());
                        uploadResponse.setUrl("/chinalife/upload?" + PARAM_KEY_GET_FILE + "=" + realPath);
                        uploadResponse.setThumbnailUrl("/chinalife/upload?" + PARAM_KEY_GET_THUMBNAIL + "=" + realPath);
                        uploadResponse.setDeleteUrl("/chinalife/upload?" + PARAM_KEY_DEL_FILE + "=" + realPath);
                        uploadResponse.setDeleteType("GET");
                        uploadResponses.add(uploadResponse);
                    }
                }
            } catch (Exception e) {
                logger.error(e);
                throw new ServletException(e);
            } finally {
                Map<String, List<UploadResponse>> ret = new HashMap<String, List<UploadResponse>>();
                ret.put("files", uploadResponses);
                String responseContent = objectMapper.writeValueAsString(ret);

                logger.info("Response content : " + responseContent);

                printWriter.write(responseContent);
                printWriter.close();
            }
        } else {
            throw new IllegalArgumentException("Unknown request TYPE.");
        }
    }

    private String getSavedPath(String parentPath, String fileName) {
        return parentPath + "/" + current + "/" + fileName;
    }

    private File getSavedDir(String parentPath) {
        String appPath = getAppPath();
        File parentDir = new File(appPath, parentPath);
        if (!parentDir.exists()) {
            parentDir.mkdir();
        }

        File savedDir = new File(parentDir, String.valueOf(current));
        savedDir.mkdir();

        return savedDir;
    }

    @JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.NONE)
    private static class UploadResponse {
        private String name;
        private long size;
        private String url;
        private String thumbnailUrl;
        private String deleteUrl;
        private String deleteType;


        public void setName(String name) {
            this.name = name;
        }

        public void setSize(long size) {
            this.size = size;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public void setThumbnailUrl(String thumbnailUrl) {
            this.thumbnailUrl = thumbnailUrl;
        }

        public void setDeleteUrl(String deleteUrl) {
            this.deleteUrl = deleteUrl;
        }

        public void setDeleteType(String deleteType) {
            this.deleteType = deleteType;
        }

        public String getName() {
            return name;
        }

        public long getSize() {
            return size;
        }

        public String getUrl() {
            return url;
        }

        public String getThumbnailUrl() {
            return thumbnailUrl;
        }

        public String getDeleteUrl() {
            return deleteUrl;
        }

        public String getDeleteType() {
            return deleteType;
        }
    }

    public static void main(String[] args) {
    }
}