package com.chinalife.servlet.admin;

import com.chinalife.dal.DAOFacade;
import com.chinalife.dao.HouseSaleDAO;
import com.chinalife.dao.HouseSalePictureDAO;
import com.chinalife.utils.servlet.BaseServlet;
import com.chinalife.utils.servlet.FileUploadUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

/**
 * Created by shixin on 3/24/14.
 */
public class HouseAddServlet extends BaseServlet {
    private static final Logger logger = Logger.getLogger(HouseAddServlet.class);

    @Override
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        logger.info("Enter HouseAddServlet.");
        logger.info("天下无贼");

        try {
            List<FileItem> items = FileUploadUtil.getFileIterms(request, getTmpPath(), -1, -1, null);

            Map<String, String> parameters = FileUploadUtil.getFormFields(items);
            String title = getStr(parameters, "title");
            String district = getStr(parameters, "district");
            String status = getStr(parameters, "status");
            String address = getStr(parameters, "address");
            String type = getStr(parameters, "type");
            int room = getInt(parameters, "room");
            int toilet = getInt(parameters, "toilet");
            int carport = getInt(parameters, "carport");
            double area = getDouble(parameters, "area");
            double minPrice = getDouble(parameters, "min_price");
            double maxPrice = getDouble(parameters, "max_price");
            String desc = getStr(parameters, "description");
            String contactPersion1 = getStr(parameters, "first_contact_name");
            String contactPhone1 = getStr(parameters, "first_contact_phone");
            String contactPersion2 = getStr(parameters, "second_contact_name");
            String contactPhone2 = getStr(parameters, "second_contact_phone");

            final Long houseSaleId = DAOFacade.getDAO(HouseSaleDAO.class)
                    .createHouseSale(title, district, status, address, type, room, toilet, carport, area, minPrice, maxPrice, desc,
                            contactPersion1, contactPhone1, contactPersion2, contactPhone2, new Timestamp(System.currentTimeMillis()));

            String appPath = getAppPath();
            logger.info("App path : " + appPath);

            File houseSalePictureDir = new File(appPath, "house-sale-pictures");
            if (!houseSalePictureDir.exists()) {
                houseSalePictureDir.mkdir();
            }

            File saveTo = new File(houseSalePictureDir, String.valueOf(houseSaleId));
            if (saveTo.exists()) {
                logger.info(saveTo.getAbsolutePath() + " exists, will delete it.");
                saveTo.delete();
            }
            saveTo.mkdir();

            FileUploadUtil.saveToDisk(items, saveTo, null, new FileUploadUtil.AfterProcessor() {
                @Override
                public void process(File savedFile) throws Exception {
                    DAOFacade.getDAO(HouseSalePictureDAO.class).createHouseSalePicture(
                            houseSaleId, savedFile.getName(), savedFile.getAbsolutePath(), new Timestamp(System.currentTimeMillis()));
                }
            });

            getSuccessDispatcher(request).forward(request, response);
        } catch (Exception e) {
            logger.error(e);
            throw new ServletException(e);
        }
    }
}
