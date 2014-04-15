package com.chinalife.utils.io;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.Validate;

import java.io.*;
import java.util.Enumeration;
import java.util.List;
import java.util.zip.*;

/**
 * Created by shixin on 4/1/14.
 */
public class FileIOUtil {
    public static String getMIMEType(File file) {
        Validate.isTrue(null != file && file.exists() && file.isFile());

        String mimeType;
        if (getSuffix(file.getName()).equalsIgnoreCase("png")) {
            mimeType = "image/png";
        } else if (getSuffix(file.getName()).equalsIgnoreCase("jpg")) {
            mimeType = "image/jpg";
        } else {
            javax.activation.MimetypesFileTypeMap mtMap = new javax.activation.MimetypesFileTypeMap();
            mimeType = mtMap.getContentType(file);
        }
        return mimeType;
    }

    public static String getSuffix(String fileName) {
        String ret = "";
        int index = fileName.lastIndexOf('.');
        if (index > 0 && index < fileName.length() - 1) {
            ret = fileName.substring(index + 1);
        }
        return ret;
    }

    /**
     * Zip single file.
     *
     * @param sourceFile
     * @param destFile
     * @throws java.io.IOException
     */
    public static void zip(File sourceFile, File destFile) throws IOException {
        Validate.notNull(sourceFile);
        Validate.isTrue(sourceFile.exists());
        Validate.notNull(destFile);

        ZipOutputStream out = null;
        try {
            out = new ZipOutputStream(new FileOutputStream(destFile));
            zipFile("", sourceFile, out);
        } finally {
            if (null != out) {
                out.close();
            }
        }
    }

    /**
     * Zip multi files.
     *
     * @param sourcesFiles
     * @param destFile
     * @throws java.io.IOException
     */
    public static void zip(File[] sourcesFiles, File destFile) throws IOException {
        Validate.notEmpty(sourcesFiles);
        Validate.notNull(destFile);

        ZipOutputStream out = null;
        try {
            out = new ZipOutputStream(new FileOutputStream(destFile));
            for (File file : sourcesFiles) {
                Validate.isTrue(file != null && file.exists());
                zipFile("", file, out);
            }
        } finally {
            if (null != out) {
                out.close();
            }
        }
    }

    /**
     * Only zip folder's content.
     *
     * @param sourceDir
     * @param destFile
     * @throws java.io.IOException
     */
    public static void zipFolderContent(File sourceDir, File destFile) throws IOException {
        Validate.notNull(sourceDir);
        Validate.isTrue(sourceDir.exists() && sourceDir.isDirectory());
        Validate.notNull(destFile);

        ZipOutputStream out = null;
        try {
            out = new ZipOutputStream(new FileOutputStream(destFile));

            for (File file : sourceDir.listFiles()) {
                zipFile("", file, out);
            }
        } finally {
            if (null != out) {
                out.close();
            }
        }
    }

    private static void zipFile(String path, File sourceFile, ZipOutputStream out) throws IOException {
        if (sourceFile.isDirectory()) {
            File[] files = sourceFile.listFiles();
            if (null != files) {
                for (File file : files) {
                    String childPath = path + sourceFile.getName() + "/";
                    zipFile(childPath, file, out);
                }
            }
        } else {
            String childPath = path + sourceFile.getName();

            ZipEntry zipEntry = new ZipEntry(childPath);
            out.putNextEntry(zipEntry);

            BufferedInputStream in = null;
            try {
                in = new BufferedInputStream(new FileInputStream(sourceFile));
                IOUtils.copy(in, out);
            } finally {
                if (null != in) {
                    in.close();
                }
            }
        }
    }

    /**
     * Unzip a zip file.
     *
     * @param sourceFile
     * @param destDir
     * @throws java.io.IOException
     */
    public static void unzip(ZipFile sourceFile, File destDir) throws IOException {
        Validate.notNull(sourceFile);
        Validate.notNull(destDir);

        Enumeration<?> entries = sourceFile.entries();
        while (entries.hasMoreElements()) {
            ZipEntry entry = (ZipEntry) entries.nextElement();
            File newFile = new File(destDir, entry.getName());
            if (entry.isDirectory()) {
                newFile.mkdirs();
            } else {
                newFile.getParentFile().mkdirs();
                InputStream input = null;
                OutputStream output = null;
                try {
                    input = sourceFile.getInputStream(entry);
                    output = new BufferedOutputStream(new FileOutputStream(newFile));
                    IOUtils.copy(input, output);
                } finally {
                    if (null != input) {
                        input.close();
                    }
                    if (null != output) {
                        output.close();
                    }
                }
            }
        }
    }

    /**
     * Create a file with contents.
     *
     * @param fileName
     * @param content
     * @return
     * @throws java.io.IOException
     */
    public static File createFile(String fileName, List<String> content) throws IOException {
        Validate.notEmpty(fileName);
        Validate.notEmpty(content);

        File jobFile = new File(fileName);
        if (jobFile.exists()) {
            jobFile.delete();
        }
        jobFile.createNewFile();

        PrintWriter printWriter = null;
        try {
            printWriter = new PrintWriter(new BufferedWriter(new FileWriter(jobFile)));
            for (String line : content) {
                printWriter.println(line);
            }
        } finally {
            if (null != printWriter) {
                printWriter.close();
            }
        }
        return jobFile;
    }

    public static byte[] unGZIPBytes(byte[] bytes) throws IOException {
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
        GZIPInputStream gzipInputStream = new GZIPInputStream(byteArrayInputStream);

        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

        IOUtils.copy(gzipInputStream, byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }

    public static byte[] gzipBytes(byte[] bytes) throws IOException {
        return gzipBytes(bytes, 0, bytes.length);
    }

    public static byte[] gzipBytes(byte[] bytes, int offset, int length) throws IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        GZIPOutputStream gzipOutputStream = new GZIPOutputStream(byteArrayOutputStream);
        gzipOutputStream.write(bytes, offset, length);
        gzipOutputStream.close();
        return byteArrayOutputStream.toByteArray();
    }
}
