package com.chinalife.servlet;

import com.chinalife.dal.DAOException;
import com.chinalife.dal.DAOFacade;
import com.chinalife.dao.HouseSaleDAO;
import com.chinalife.dao.HouseSalePictureDAO;
import com.chinalife.utils.servlet.BaseServlet;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.Validate;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by shixin on 3/24/14.
 */
public class HouseSaleAddServlet extends BaseServlet {
    private static final Logger logger = Logger.getLogger(HouseSaleAddServlet.class);

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        Validate.isTrue(ServletFileUpload.isMultipartContent(request), "Invalid request type.");

        Integer room = null;
        Integer hall = null;
        Integer toilet = null;
        Integer carport = null;
        Double area = null;
        Double price = null;
        String community = null;
        String address = null;
        String title = null;
        String description = null;
        String contactPerson = null;
        String contactPhone = null;

        try {
            List<FileItem> fileItems = getFileUpload().parseRequest(request);
            for (FileItem fileItem : fileItems) {
                if (fileItem.isFormField()) {
                    String fieldName = fileItem.getFieldName();
                    logger.info("File name:" + fieldName + ", and value:" + fileItem.getString());

                    if ("room".equalsIgnoreCase(fieldName)) {
                        room = Integer.parseInt(fileItem.getString());
                    } else if ("hall".equalsIgnoreCase(fieldName)) {
                        hall = Integer.parseInt(fileItem.getString());
                    } else if ("toilet".equalsIgnoreCase(fieldName)) {
                        toilet = Integer.parseInt(fileItem.getString());
                    } else if ("carport".equalsIgnoreCase(fieldName)) {
                        carport = Integer.parseInt(fileItem.getString());
                    } else if ("area".equalsIgnoreCase(fieldName)) {
                        area = Double.parseDouble(fileItem.getString());
                    } else if ("price".equalsIgnoreCase(fieldName)) {
                        price = Double.parseDouble(fileItem.getString());
                    } else if ("community".equalsIgnoreCase(fieldName)) {
                        community = fileItem.getString();
                    } else if ("address".equalsIgnoreCase(fieldName)) {
                        address = fileItem.getString();
                    } else if ("title".equalsIgnoreCase(fieldName)) {
                        title = fileItem.getString();
                    } else if ("description".equalsIgnoreCase(fieldName)) {
                        description = fileItem.getString();
                    } else if ("contact_person".equalsIgnoreCase(fieldName)) {
                        contactPerson = fileItem.getString();
                    } else if ("contact_phone".equalsIgnoreCase(fieldName)) {
                        contactPhone = fileItem.getString();
                    }
                }
            }

            Validate.notNull(room);
            Validate.notNull(hall);
            Validate.notNull(toilet);
            Validate.notNull(carport);
            Validate.notNull(area);
            Validate.notNull(price);
            Validate.notNull(community);
            Validate.notNull(address);
            Validate.notNull(title);
            Validate.notNull(description);
            Validate.notNull(contactPerson);
            Validate.notNull(contactPhone);

            Long houseSaleId = DAOFacade.getDAO(HouseSaleDAO.class)
                    .createHouseSale(room, hall, toilet, carport, area, price, community, address, title, description,
                            contactPerson, contactPhone, new Timestamp(System.currentTimeMillis()));
            logger.info("Successfully create house for sale:" + houseSaleId);

            File appDir = new File(getAppPath());
            Validate.isTrue(appDir.exists() && appDir.isDirectory(), "App dir is not exists.");

            File houseSalePictureDir = new File(appDir, "house-sale-picture");
            if (!houseSalePictureDir.exists()) {
                houseSalePictureDir.mkdir();
            }

            File myDir = new File(houseSalePictureDir, String.valueOf(houseSaleId));
            if (myDir.exists()) {
                logger.info(myDir.getAbsolutePath() + " exists, so delete it.");
                myDir.delete();
            }
            myDir.mkdir();


            for (FileItem fileItem : fileItems) {
                if (!fileItem.isFormField()) {
                    logger.info("Found uploaded file:" + fileItem.getName());

                    File file = new File(myDir, fileItem.getName());
                    fileItem.write(file);
                    logger.info("Successfully save file:" + file.getAbsolutePath());

                    byte[] content = fileItem.get();
                    DAOFacade.getDAO(HouseSalePictureDAO.class).createHouseSalePicture(
                            houseSaleId, fileItem.getName(), file.getAbsolutePath(), content, new Timestamp(System.currentTimeMillis()));
                    logger.info("Successfully create house sale picture.");
                }
            }
            getSuccessDispatcher(request).forward(request, response);
        } catch (DAOException e) {
            logger.error("Failed to create house for sale due to:", e);
        } catch (FileUploadException e) {
            logger.error("Failed to parse request", e);
        } catch (Exception e) {
            logger.error("Failed to parse request", e);
        }
    }
}
