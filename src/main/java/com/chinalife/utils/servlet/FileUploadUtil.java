package com.chinalife.utils.servlet;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.FileCleanerCleanup;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileCleaningTracker;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ishikin on 14-4-2.
 */
public class FileUploadUtil {
    private static Logger logger = Logger.getLogger(FileUploadUtil.class);

    /**
     * 获取每个上传文件的输入流
     *
     * @param request
     * @param maxSize
     * @param listener
     * @return
     * @throws org.apache.commons.fileupload.FileUploadException
     * @throws java.io.IOException
     */
    public static List<InputStream> getInputStreams(HttpServletRequest request, long maxSize, ProgressListener listener)
            throws FileUploadException, IOException {
        Validate.notNull(request);
        Validate.isTrue(ServletFileUpload.isMultipartContent(request), "Invalid enctype of form.");

        ServletFileUpload fileUpload = new ServletFileUpload();
        fileUpload.setSizeMax(maxSize);
        if (null != listener) {
            fileUpload.setProgressListener(listener);
        }

        List<InputStream> streams = new ArrayList<InputStream>();

        FileItemIterator iterator = fileUpload.getItemIterator(request);
        while (iterator.hasNext()) {
            FileItemStream fileItemStream = iterator.next();
            if (!fileItemStream.isFormField()) {
                streams.add(fileItemStream.openStream());
            }
        }
        return streams;
    }

    /**
     * 获取每个上传文件的内容
     *
     * @param request
     * @param tmpDir
     * @param threshold
     * @param maxSize
     * @param listener
     * @return
     * @throws org.apache.commons.fileupload.FileUploadException
     */
    public static List<byte[]> getBytes(HttpServletRequest request, String tmpDir, int threshold, long maxSize, ProgressListener listener)
            throws FileUploadException {
        Validate.notNull(request);
        Validate.notEmpty(tmpDir);
        Validate.isTrue(ServletFileUpload.isMultipartContent(request), "Invalid enctype of form.");

        List<byte[]> bytes = new ArrayList<byte[]>();
        List<FileItem> iterms = getFileIterms(request, tmpDir, threshold, maxSize, listener);
        for (FileItem item : iterms) {
            if (!item.isFormField()) {
                bytes.add(item.get());
            }
        }
        return bytes;
    }

    /**
     * 获取普通表单元素的值
     *
     * @param items
     * @return
     * @throws Exception
     */
    public static Map<String, String> getFormFields(List<FileItem> items)
            throws Exception {
        Validate.notEmpty(items);

        Map<String, String> formFields = new HashMap<String, String>();
        for (FileItem item : items) {
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String fieldValue = item.getString("UTF-8");
                logger.info("Get form field and value : " + fieldName + ", " + fieldValue);
                formFields.put(fieldName, fieldValue);
            }
        }
        return formFields;
    }

    /**
     * 把上传的文件保存到某个目录下
     *
     * @param items
     * @param saveTo
     * @param before
     * @param after
     * @throws Exception
     */
    public static void saveToDisk(List<FileItem> items, File saveTo, BeforeProcessor before, AfterProcessor after) throws Exception {
        for (FileItem item : items) {
            if (!item.isFormField()) {
//                if (null != before) {
//                    before.process(item, saveTo);
//                }
                logger.info("file name tracycc: " +item.getName());
//                File newFile = new File(saveTo, item.getName());
//                if (newFile.exists()) {
//                    logger.info("File " +item.getName() +" path: "+ newFile.getPath() + " exists, will delete.");
//                    newFile.delete();
//                }
//                item.write(newFile);
//
//                if (null != after) {
//                    after.process(newFile);
//                }
            }
        }
    }

    public static List<FileItem> getFileIterms(HttpServletRequest request, String tmpDir, int threshold, long maxSize, ProgressListener listener)
            throws FileUploadException {
        ServletContext context = request.getServletContext();
        DiskFileItemFactory factory = creatItermFactory(context, tmpDir, threshold);

        ServletFileUpload fileUpload = new ServletFileUpload(factory);
        if (maxSize > 0) {
            fileUpload.setSizeMax(maxSize);
        }
        if (null != listener) {
            fileUpload.setProgressListener(listener);
        }
        fileUpload.setHeaderEncoding("UTF-8");

        return fileUpload.parseRequest(request);
    }

    private static DiskFileItemFactory creatItermFactory(ServletContext context, String repo, int threshold) {
        File tmpRepository = new File(repo);
        Validate.isTrue(tmpRepository.exists() && tmpRepository.isDirectory(), "Invalid repo.");

        FileCleaningTracker tracker = FileCleanerCleanup.getFileCleaningTracker(context);

        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
        diskFileItemFactory.setRepository(tmpRepository);
        diskFileItemFactory.setSizeThreshold(threshold <= 0 ? DiskFileItemFactory.DEFAULT_SIZE_THRESHOLD : threshold);
        diskFileItemFactory.setFileCleaningTracker(tracker);

        return diskFileItemFactory;
    }

    public static interface BeforeProcessor {
        void process(FileItem item, File saveTo) throws Exception;
    }

    public static interface AfterProcessor {
        void process(File savedFile) throws Exception;
    }
}
