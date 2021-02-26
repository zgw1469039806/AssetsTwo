package avicit.assets.utils.controller;

import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.AESUtils;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.fastdfs.fastdfs.*;
import avicit.platform6.fastdfs.utils.AESUtil;
import avicit.platform6.fastdfs.utils.FastDfsUtil;
import avicit.platform6.fastdfs.vo.FileLocation;
import avicit.platform6.modules.system.sysfileupload.domain.SysFileUpload;
import avicit.platform6.modules.system.sysfileupload.service.SwfUploadService;
import avicit.platform6.modules.system.sysfileupload.util.FileEncryptUtil;
import avicit.platform6.modules.system.sysfileupload.util.IOUtils;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;
import com.spire.presentation.FileFormat;
import com.spire.presentation.Presentation;
import fr.opensagres.xdocreport.itext.extension.font.IFontProvider;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hwpf.HWPFDocumentCore;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.converter.WordToHtmlUtils;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.converter.pdf.PdfConverter;
import org.apache.poi.xwpf.converter.pdf.PdfOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.crypto.Cipher;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.GenericType;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.awt.Color;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.sql.Blob;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Controller
@Scope("prototype")
@RequestMapping("assets/utils/attachViewerController")
public class AttachViewerController  implements LoaderConstant {
    private static final Logger log = LoggerFactory.getLogger(AttachViewerController.class);

    @Autowired
    private SwfUploadService swfUploadService;

    @Autowired
    private SysLookupAPI sysLookupAPI;

    /**
     * 获取后台附件
     *
     * @param request
     * @param response
     */
    @RequestMapping(value = "/getShowFiles")
    public void getShowFiles(HttpServletRequest request, HttpServletResponse response) {

        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/pdf;charset=UTF-8");

        String fileId = request.getParameter("fileId");
        try {
            SysFileUpload file = swfUploadService.getAttachById(fileId);
            if (file != null) {

                long fileSize = file.getFILE_SIZE();
                if (fileSize > 0) {
                    response.setHeader("Content-Length", String.valueOf(fileSize));
                }

                String filePath = file.getFILE_URL();
                String fastfdsLocation = file.getFastfdsLocation();
                if (fastfdsLocation != null && !"".equals(fastfdsLocation)) {
                    // 下载来自fastdfs的文件
                    if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                        FastDfsUtil.downloadAes128FileByStream(response.getOutputStream(), fastfdsLocation,
                                "avicit2015v6r3");
                    } else {
                        FastDfsUtil.downLoadFileByStream(response.getOutputStream(), fastfdsLocation);
                    }
                    response.getOutputStream().close();

                } else if (filePath != null && !"".equals(filePath)) {
                    // 下载来自物理存储的文件(磁盘)
                    BufferedInputStream bis = null;
                    InputStream in = null;
                    try {
                        in = new FileInputStream(new File(filePath));
                        bis = new BufferedInputStream(in);

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            FileEncryptUtil.downloadAes128FileByStream(response.getOutputStream(), in,
                                    "avicit2015v6r3");
                        } else {
                            int len = in.available();
                            if (len > 0) {
                                IOUtils.copy(bis, response.getOutputStream());
                            }
                        }

                    } finally {
                        response.getOutputStream().close();
                        bis.close();
                        in.close();
                    }
                } else {
                    // 下载来自数据库
                    Map<String, String> condition = new HashMap<String, String>();
                    condition.put("fileId", fileId);
                    Blob fileBody = swfUploadService.getFileBodyByCondition(condition);
                    BufferedInputStream bis = null;
                    InputStream in = null;
                    try {
                        in = fileBody.getBinaryStream();
                        bis = new BufferedInputStream(in);

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            FileEncryptUtil.downloadAes128FileByStream(response.getOutputStream(), in,
                                    "avicit2015v6r3");
                        } else {
                            IOUtils.copy(bis, response.getOutputStream());
                        }

                    } finally {
                        response.getOutputStream().close();
                        bis.close();
                        in.close();
                    }
                }

            } else {
                response.setCharacterEncoding("UTF-8");
                return;
            }
        } catch (Exception e) {
            log.error("download下载附件出错:", e);
        }
    }

    /**
     * 获取下载附件的文件名称
     *
     * @param fileName
     * @param agent
     * @return
     */
    private String getFileName(String fileName, String agent) {
        String codedfilename = fileName;
        try {
            if (agent != null && agent.indexOf("Mozilla") != -1 && agent.indexOf("Android") != -1) {// Mozilla..
                try {
                    codedfilename = URLEncoder.encode(fileName, "UTF-8");
                } catch (Exception e) {
                    codedfilename = fileName;
                }
            } else if (agent.toLowerCase().indexOf("safari") != -1) {// Safari浏览器，只能采用ISO编码的中文输出
                codedfilename = new String(codedfilename.getBytes("UTF-8"), "ISO8859-1");
            } else if (agent.toLowerCase().indexOf("chrome") != -1) {// Chrome浏览器，只能采用MimeUtility编码或ISO编码的中文输出
                codedfilename = MimeUtility.encodeText(codedfilename, "UTF8", "B");
            }
            // FireFox浏览器，可以使用MimeUtility或filename*或ISO编码的中文输出
            else if (agent != null && agent.toLowerCase().indexOf("mozilla") != -1
                    && agent.toLowerCase().indexOf("firefox") != -1) {// ff,mozilla..
                codedfilename = MimeUtility.encodeText(fileName, "GBK", "B");
            } else {// ie,opera..
                if (Charset.defaultCharset().name().indexOf("GBK") != -1) {
                    codedfilename = new String(fileName.getBytes(), "ISO8859_1");
                } else {
                    codedfilename = URLEncoder.encode(fileName, "utf-8");
                }
            }
        } catch (Exception e) {
            log.error("getFileName", e);
        }
        return codedfilename;
    }

    /**
     * 获取DOCX后台附件
     *
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/getDocx")
    public BufferedInputStream getDocx(HttpServletRequest request, HttpServletResponse response) throws IOException {
        InputStream in = null;
        String id = request.getParameter("fileId");
        try {
            SysFileUpload file = swfUploadService.getAttachById(id);
            if (file != null) {
                String filePath = file.getFILE_URL();
                String fastfdsLocation = file.getFastfdsLocation();
                if (fastfdsLocation != null && !"".equals(fastfdsLocation)) {
                    // 下载来自fastdfs的文件
                    if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                        in = this.FastDownloadAes128FileByStream(fastfdsLocation, "avicit2015v6r3");
                    } else {
                        in = this.downLoadFileByStream(fastfdsLocation);

                    }

                } else if (filePath != null && !"".equals(filePath)) {
                    // 下载来自物理存储的文件(磁盘)
                    try {
                        in = new FileInputStream(new File(filePath));

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }
                    } finally {
                    }
                } else {
                    // 下载来自数据库
                    Map<String, String> condition = new HashMap<String, String>();
                    condition.put("fileId", id);
                    Blob fileBody = swfUploadService.getFileBodyByCondition(condition);
                    try {
                        in = fileBody.getBinaryStream();

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }

                    } finally {
                    }
                }

            }
        } catch (Exception e) {
            log.error("download下载附件出错:", e);
        }
        File pdf = new File("test.pdf");
        XWPFDocument document = new XWPFDocument(in);

        // 2) Prepare Pdf options
        PdfOptions options = PdfOptions.create();
        IFontProvider iFontProvider = new IFontProvider() {
            @Override
            public Font getFont(String familyName, String encoding, float size, int style, Color color) {
                try {
                    // BaseFont bfChinese = BaseFont.createFont("STSong-Light",
                    // BaseFont.IDENTITY_H,BaseFont.NOT_EMBEDDED);
                    BaseFont bfChinese = BaseFont.createFont("/simsun.ttc,0", BaseFont.IDENTITY_H,
                            BaseFont.NOT_EMBEDDED);
                    Font fontChinese = new Font(bfChinese, size, style, color);
                    if (familyName != null) {
                        fontChinese.setFamily(familyName);
                    }
                    return fontChinese;
                } catch (Exception e) {
                    e.printStackTrace();
                    return null;
                }
            }
        };
        options.fontProvider(iFontProvider);
        // 3) Convert XWPFDocument to Pdf
        FileOutputStream out = new FileOutputStream(pdf);
        PdfConverter.getInstance().convert(document, out, options);
        BufferedInputStream bf = new BufferedInputStream(new FileInputStream(pdf));
        IOUtils.copy(bf, response.getOutputStream());
        response.getOutputStream().close();
        out.flush();
        bf.close();
        out.close();
        return bf;
    }

    /**
     * doc文件转换为html
     *
     * @return
     * @throws FileNotFoundException
     * @throws IOException
     * @throws ParserConfigurationException
     * @throws TransformerException
     * @throws SQLException
     */
    @RequestMapping(value = "/getDoc")
    public String
    getDoc(String id) throws FileNotFoundException, IOException, ParserConfigurationException,
            TransformerException, SQLException {
        InputStream in = null;
        try {
            SysFileUpload file = swfUploadService.getAttachById(id);
            if (file != null) {
                String filePath = file.getFILE_URL();
                String fastfdsLocation = file.getFastfdsLocation();
                if (fastfdsLocation != null && !"".equals(fastfdsLocation)) {
                    // 下载来自fastdfs的文件
                    if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                        in = this.FastDownloadAes128FileByStream(fastfdsLocation, "avicit2015v6r3");
                    } else {
                        in = this.downLoadFileByStream(fastfdsLocation);

                    }

                } else if (filePath != null && !"".equals(filePath)) {
                    // 下载来自物理存储的文件(磁盘)
                    try {
                        in = new FileInputStream(new File(filePath));

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            // FileEncryptUtil.downloadAes128FileByStream(
                            // response.getOutputStream(), in,
                            // "avicit2015v6r3");
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }
                    } finally {
                        // in.close();
                    }
                } else {
                    // 下载来自数据库
                    Map<String, String> condition = new HashMap<String, String>();
                    condition.put("fileId", id);
                    Blob fileBody = swfUploadService.getFileBodyByCondition(condition);
                    BufferedInputStream bis = null;
                    try {
                        in = fileBody.getBinaryStream();

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            // FileEncryptUtil.downloadAes128FileByStream(response.getOutputStream(),
                            // in, "avicit2015v6r3");
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }

                    } finally {
                        // in.close();
                    }
                }

            }
        } catch (Exception e) {
            log.error("download下载附件出错:", e);
        }

        // HWPFDocumentCore wordDocument = WordToHtmlUtils.loadDoc(new
        // FileInputStream(file));
        HWPFDocumentCore wordDocument = WordToHtmlUtils.loadDoc(in);
        WordToHtmlConverter wordToHtmlConverter = new InlineImageWordToHtmlConverter(
                DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());
        wordToHtmlConverter.processDocument(wordDocument);

        // 导入w3c的document包
        Document docHtml = wordToHtmlConverter.getDocument();
        DOMSource source = new DOMSource(docHtml);

        // 数据
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        // ByteOutputStream out = new ByteOutputStream();
        StreamResult result = new StreamResult(out);

        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer trans = tf.newTransformer();
        trans.setOutputProperty(OutputKeys.INDENT, "yes");
        trans.setOutputProperty(OutputKeys.METHOD, "html");
        trans.setOutputProperty(OutputKeys.INDENT, "yes");

        trans.transform(source, result);
        // String htmlString = new String(out.getBytes());
        String htmlString = new String(out.toByteArray(), "UTF-8");
        ;
        out.close();
        in.close();

        return htmlString;
    }

    /**
     * txt文件转换为html
     *
     * @return
     * @throws FileNotFoundException
     * @throws IOException
     * @throws ParserConfigurationException
     * @throws TransformerException
     * @throws SQLException
     */
    @RequestMapping(value = "/getTxt")
    public String getTxt(String id) throws FileNotFoundException, IOException, ParserConfigurationException,
            TransformerException, SQLException {
        InputStream in = null;
        try {
            SysFileUpload file = swfUploadService.getAttachById(id);
            if (file != null) {
                String filePath = file.getFILE_URL();
                String fastfdsLocation = file.getFastfdsLocation();
                if (fastfdsLocation != null && !"".equals(fastfdsLocation)) {
                    // 下载来自fastdfs的文件
                    if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                        in = this.FastDownloadAes128FileByStream(fastfdsLocation, "avicit2015v6r3");
                    } else {
                        in = this.downLoadFileByStream(fastfdsLocation);

                    }

                } else if (filePath != null && !"".equals(filePath)) {
                    // 下载来自物理存储的文件(磁盘)
                    try {
                        in = new FileInputStream(new File(filePath));

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            // FileEncryptUtil.downloadAes128FileByStream(
                            // response.getOutputStream(), in,
                            // "avicit2015v6r3");
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }
                    } finally {
                        // in.close();
                    }
                } else {
                    // 下载来自数据库
                    Map<String, String> condition = new HashMap<String, String>();
                    condition.put("fileId", id);
                    Blob fileBody = swfUploadService.getFileBodyByCondition(condition);
                    BufferedInputStream bis = null;
                    try {
                        in = fileBody.getBinaryStream();

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            // FileEncryptUtil.downloadAes128FileByStream(response.getOutputStream(),
                            // in, "avicit2015v6r3");
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }

                    } finally {
                        // in.close();
                    }
                }

            }
        } catch (Exception e) {
            log.error("download下载附件出错:", e);
        }

        String encoding = "GBK";
        InputStreamReader read = new InputStreamReader(in, encoding);
        // 考虑到编码格式
        BufferedReader bufferedReader = new BufferedReader(read);
        String lineTxt = "";
        String htmlString = "";
        while ((lineTxt = bufferedReader.readLine()) != null) {
            htmlString += lineTxt + "<br/>";
        }
        System.out.println("html为：" + htmlString);
        read.close();
        return htmlString;

    }

    /**
     * 图片转换为html
     *
     * @author LHX
     *
     */
    class InlineImageWordToHtmlConverter extends WordToHtmlConverter {

        public InlineImageWordToHtmlConverter(Document document) {
            super(document);
        }

        @Override
        protected void processImageWithoutPicturesManager(Element currentBlock, boolean inlined, Picture picture) {
            Element imgNode = currentBlock.getOwnerDocument().createElement("img");
            StringBuilder sb = new StringBuilder();
            // Base64.encode(picture.getRawContent());
            // sb.append(Base64.getMimeEncoder().encodeToString(picture.getRawContent()));
            sb.append(new Base64().encodeToString(picture.getRawContent()));
            sb.insert(0, "data:" + picture.getMimeType() + ";base64,");
            imgNode.setAttribute("src", sb.toString());
            currentBlock.appendChild(imgNode);
        }
    }

    /**
     * 获取文件类型
     *
     * @param request
     * @param response
     * @param fileId
     * @return
     * @throws FileNotFoundException
     * @throws IOException
     * @throws ParserConfigurationException
     * @throws TransformerException
     * @throws SQLException
     */
    @RequestMapping(value = "/getFileType")
    public ModelAndView getFileType(String fileId, HttpServletRequest request, HttpServletResponse response)
            throws FileNotFoundException, IOException, ParserConfigurationException, TransformerException,
            SQLException {
        ModelAndView mav = new ModelAndView();

        SysFileUpload file = swfUploadService.getAttachById(fileId);
        if (file != null) {
            String documentId = file.getFILE_BUSINESS_TABLE_FIELD();
            String docFlag = file.getATTRIBUTE_03();
            if ("1".equals(docFlag)) {
                String url = RestClientConfig.getRestHost("docu_save_batch")
                        + "/api/cihs/document/cihsdocumentaccesscontrol/CihsDocumentAccesscontrolRest/searchAccess/v1";
                Map<String, String> map = new HashMap<>();
                map.put("userId", SessionHelper.getLoginSysUserId(request));
                map.put("documentId", documentId);
                ResponseMsg<Map<String, Integer>> responseMsg = RestClient.doPost(url, map,
                        new GenericType<ResponseMsg<Map<String, Integer>>>() {
                        });
                if (responseMsg.getRetCode().equals("200")) {
                    int downloadAccess = responseMsg.getResponseBody().get("downloadPower");
                    if (downloadAccess == 0) {
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter p = response.getWriter();
                        p.write("<script>alert('没有浏览此文档的权限');</script>");
                        p.close();
                        // return null;
                    }

                } else {
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter p = response.getWriter();
                    p.write("<script>alert('获取权限失败');</script>");
                    p.close();
                    // return null;
                }
            }
            String fileName = file.getFILE_NAME();
            String fileType = fileName.substring(fileName.lastIndexOf('.') + 1, fileName.length());
            if (fileType.equalsIgnoreCase("doc")) {
                String htmlString = this.getDoc(fileId);
                mav.addObject("out", htmlString);
                mav.setViewName("avicit/static/pdfjs/web/docview");
                return mav;
            } else if (fileType.equalsIgnoreCase("pdf")) {
                mav.addObject("fileIds", fileId);
                mav.setViewName("avicit/static/pdfjs/web/viewer");
                return mav;
            } else if (fileType.equalsIgnoreCase("xls") || fileType.equalsIgnoreCase("xlsx")) {
                String htmlExcel = this.readExcelToHtml(fileId, true);
                mav.addObject("out", htmlExcel);
                mav.setViewName("avicit/static/pdfjs/web/excelview");
                return mav;
            } else if (fileType.equalsIgnoreCase("docx")) {
                mav.addObject("fileIds", fileId);
                mav.setViewName("avicit/static/pdfjs/web/docxview");
                return mav;
            } else if (fileType.equalsIgnoreCase("txt")) {
                String htmlTxt = this.getTxt(fileId);
                mav.addObject("out", htmlTxt);
                mav.setViewName("avicit/static/pdfjs/web/txtview");
                return mav;
            } else if (fileType.equalsIgnoreCase("bmp")) {
                mav.addObject("id", fileId);
                mav.addObject("contype", "image/bmp");
                mav.setViewName("avicit/static/pdfjs/web/imgview");
                return mav;
            } else if (fileType.equalsIgnoreCase("gif")) {
                mav.addObject("id", fileId);
                mav.addObject("contype", "image/gif");
                mav.setViewName("avicit/static/pdfjs/web/imgview");
                return mav;
            } else if (fileType.equalsIgnoreCase("ief")) {
                mav.addObject("id", fileId);
                mav.addObject("contype", "image/ief");
                mav.setViewName("avicit/static/pdfjs/web/imgview");
                return mav;
            } else if (fileType.equalsIgnoreCase("jpeg")) {
                mav.addObject("id", fileId);
                mav.addObject("contype", "image/jpeg");
                mav.setViewName("avicit/static/pdfjs/web/imgview");
                return mav;
            } else if (fileType.equalsIgnoreCase("jpg")) {
                mav.addObject("id", fileId);
                mav.addObject("contype", "image/jpeg");
                mav.setViewName("avicit/static/pdfjs/web/imgview");
                return mav;
            } else if (fileType.equalsIgnoreCase("png")) {
                mav.addObject("id", fileId);
                mav.addObject("contype", "image/png");
                mav.setViewName("avicit/static/pdfjs/web/imgview");
                return mav;
            } else if (fileType.equalsIgnoreCase("tiff")) {
                mav.addObject("id", fileId);
                mav.addObject("contype", "image/tiff");
                mav.setViewName("avicit/static/pdfjs/web/imgview");
                return mav;
            } else if (fileType.equalsIgnoreCase("tif")) {
                mav.addObject("id", fileId);
                mav.addObject("contype", "image/tif");
                mav.setViewName("avicit/static/pdfjs/web/imgview");
                return mav;
            } else if (fileType.equalsIgnoreCase("ppt")) {
                String html = this.getPPT(fileId,fileType,request,response);
                mav.addObject("out", html);
                mav.setViewName("avicit/static/pdfjs/web/pptview");
                return mav;
            }else if (fileType.equalsIgnoreCase("pptx")) {
                String html = this.getPPT(fileId,fileType,request,response);
                mav.addObject("out", html);
                mav.setViewName("avicit/static/pdfjs/web/pptview");
                return mav;
            }else {
                String errorStr = "暂不支持："+fileType+" 格式文件在线预览！";
                mav.addObject("error", errorStr);
                mav.setViewName("avicit/static/pdfjs/web/errorview");
                return mav;
            }
        } else {
            String errorStr = "文件不存在！";
            mav.addObject("error", errorStr);
            mav.setViewName("avicit/static/pdfjs/web/errorview");
            return mav;
        }

    }

    /**
     * downLoadFileByStream
     *
     * @param fileLocation
     * @return
     * @throws Exception
     */
    public InputStream downLoadFileByStream(String fileLocation) throws Exception {
        String classPath = (new File(FastDfsUtil.class.getResource("/").getFile())).getCanonicalPath();
        String fdfsClientConfigFilePath = classPath + File.separator + "fdfs_client.conf";
        ClientGlobal.init(fdfsClientConfigFilePath);
        StorageServer storageServer = null;
        TrackerClient trackerClient = new TrackerClient();
        TrackerServer trackerServer = trackerClient.getConnection();
        StorageClient storageClient = new StorageClient(trackerServer, (StorageServer) storageServer);
        InputStream in = null;
        try {
            ObjectMapper mapper = new ObjectMapper();
            List<FileLocation> list = (List) mapper.readValue(fileLocation, new TypeReference<List<FileLocation>>() {
            });
            Iterator i$ = list.iterator();

            while (i$.hasNext()) {
                FileLocation item = (FileLocation) i$.next();
                byte[] b = storageClient.download_file(item.getGn(), item.getFn());
                // outStream.write(b);
                in = new ByteArrayInputStream(b);
            }
        } catch (Exception var13) {
            var13.printStackTrace();
        }

        return in;
    }

    /**
     * FastDownloadAes128FileByStream
     *
     * @param fileLocation
     * @param sKey
     * @return
     * @throws Exception
     */
    public InputStream FastDownloadAes128FileByStream(String fileLocation, String sKey) throws Exception {
        String classPath = (new File(FastDfsUtil.class.getResource("/").getFile())).getCanonicalPath();
        String fdfsClientConfigFilePath = classPath + File.separator + "fdfs_client.conf";
        ClientGlobal.init(fdfsClientConfigFilePath);
        StorageServer storageServer = null;
        TrackerClient trackerClient = new TrackerClient();
        TrackerServer trackerServer = trackerClient.getConnection();
        StorageClient storageClient = new StorageClient(trackerServer, (StorageServer) storageServer);
        InputStream in = null;
        try {
            Cipher cipher = AESUtil.init128AESCipher(sKey, 2);
            ObjectMapper mapper = new ObjectMapper();
            List<FileLocation> list = (List) mapper.readValue(fileLocation, new TypeReference<List<FileLocation>>() {
            });
            Iterator i$ = list.iterator();

            while (i$.hasNext()) {
                FileLocation item = (FileLocation) i$.next();
                byte[] b = storageClient.download_file(item.getGn(), item.getFn());
                in = new ByteArrayInputStream(b);
            }
        } catch (Exception var15) {
            var15.printStackTrace();
        }

        return in;
    }

    /**
     * FileDownloadAes128FileByStream
     *
     * @param inStream
     * @param sKey
     * @return
     * @throws Exception
     */
    public InputStream FileDownloadAes128FileByStream(InputStream inStream, String sKey) throws Exception {
        InputStream in = null;
        try {
            Cipher cipher = AESUtils.init128AESCipher(sKey, 2);
            ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
            byte[] buff = new byte[100];
            boolean var6 = false;

            int rc;
            while ((rc = inStream.read(buff, 0, 100)) > 0) {
                swapStream.write(buff, 0, rc);
            }

            byte[] in2b = swapStream.toByteArray();
            in = new ByteArrayInputStream(in2b);
        } catch (Exception var8) {
            var8.printStackTrace();
        }

        return in;
    }

    /**
     * 将EXCEL转换为HTML
     *
     * @param isWithStyle
     *            是否需要表格样式 包含 字体 颜色 边框 对齐方式
     * @return
     *         <table>
     *         ...
     *         </table>
     *         字符串
     */
    @RequestMapping(value = "/readExcelToHtml")
    public String readExcelToHtml(String id, boolean isWithStyle) {

        InputStream in = null;
        String htmlExcel = null;

        try {
            SysFileUpload file = swfUploadService.getAttachById(id);
            if (file != null) {

                String filePath = file.getFILE_URL();
                String fastfdsLocation = file.getFastfdsLocation();
                if (fastfdsLocation != null && !"".equals(fastfdsLocation)) {
                    // 下载来自fastdfs的文件
                    if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                        in = this.FastDownloadAes128FileByStream(fastfdsLocation, "avicit2015v6r3");
                    } else {
                        in = this.downLoadFileByStream(fastfdsLocation);

                    }

                } else if (filePath != null && !"".equals(filePath)) {
                    // 下载来自物理存储的文件(磁盘)
                    try {
                        in = new FileInputStream(new File(filePath));

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }
                    } finally {
                        // in.close();
                    }
                } else {
                    // 下载来自数据库
                    Map<String, String> condition = new HashMap<String, String>();
                    condition.put("fileId", id);
                    Blob fileBody = swfUploadService.getFileBodyByCondition(condition);
                    BufferedInputStream bis = null;
                    try {
                        in = fileBody.getBinaryStream();

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }

                    } finally {
                        // in.close();
                    }
                }

            }
        } catch (Exception e) {
            log.error("download下载附件出错:", e);
        }

        try {
            Workbook wb = WorkbookFactory.create(in);
            if (wb instanceof XSSFWorkbook) {
                XSSFWorkbook xWb = (XSSFWorkbook) wb;
                htmlExcel = AttachViewerController.getExcelInfo(xWb, isWithStyle);
            } else if (wb instanceof HSSFWorkbook) {
                HSSFWorkbook hWb = (HSSFWorkbook) wb;
                htmlExcel = AttachViewerController.getExcelInfo(hWb, isWithStyle);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return htmlExcel;
    }

    public static String getExcelInfo(Workbook wb, boolean isWithStyle) {

        StringBuffer sb = new StringBuffer();
        int sheetCounts = wb.getNumberOfSheets();
        sb.append("<div id=\"tab\"> <div id=\"tab-header\"> <ul> ");// by 500419
        for (int i = 0; i < sheetCounts; i++) {
            Sheet sheet = wb.getSheetAt(i);
            if (i == 0) {
                sb.append("<li class='selected'>" + sheet.getSheetName() + "</li> ");
            } else {
                sb.append("<li>" + sheet.getSheetName() + "</li> ");
            }
        } // by 500419
        sb.append("</ul> </div> <div id=\"tab-content\"> ");// by 500419

        for (int i = 0; i < sheetCounts; i++) {
            Sheet sheet = wb.getSheetAt(i);// 获取第一个Sheet的内容
            int lastRowNum = sheet.getLastRowNum();
            Map<String, String> map[] = getRowSpanColSpanMap(sheet);
            if (i == 0) {
                sb.append("<div class=\"dom\" style=\"display: block;\">");
            } else {
                sb.append("<div class=\"dom\" style=\"display: no;\">");
            }
            sb.append("<table style='border-collapse:collapse;' width='100%'>");
            Row row = null; // 兼容
            Cell cell = null; // 兼容
            for (int rowNum = sheet.getFirstRowNum(); rowNum <= lastRowNum; rowNum++) {
                row = sheet.getRow(rowNum);
                if (row == null) {
                    sb.append("<tr><td > &nbsp;</td></tr>");
                    continue;
                }
                sb.append("<tr>");
                int lastColNum = row.getLastCellNum();
                for (int colNum = 0; colNum < lastColNum; colNum++) {
                    cell = row.getCell(colNum);
                    if (cell == null) { // 特殊情况 空白的单元格会返回null
                        sb.append("<td>&nbsp;</td>");
                        continue;
                    }

                    String stringValue = getCellValue(cell);
                    if (map[0].containsKey(rowNum + "," + colNum)) {
                        String pointString = map[0].get(rowNum + "," + colNum);
                        map[0].remove(rowNum + "," + colNum);
                        int bottomeRow = Integer.valueOf(pointString.split(",")[0]);
                        int bottomeCol = Integer.valueOf(pointString.split(",")[1]);
                        int rowSpan = bottomeRow - rowNum + 1;
                        int colSpan = bottomeCol - colNum + 1;
                        sb.append("<td rowspan= '" + rowSpan + "' colspan= '" + colSpan + "' ");
                    } else if (map[1].containsKey(rowNum + "," + colNum)) {
                        map[1].remove(rowNum + "," + colNum);
                        continue;
                    } else {
                        sb.append("<td ");
                    }

                    // 判断是否需要样式
                    if (isWithStyle) {
                        dealExcelStyle(wb, sheet, cell, sb);// 处理单元格样式
                    }

                    sb.append(">");
                    if (stringValue == null || "".equals(stringValue.trim())) {
                        sb.append(" &nbsp; ");
                    } else {
                        // 将ascii码为160的空格转换为html下的空格（&nbsp;）
                        sb.append(stringValue.replace(String.valueOf((char) 160), "&nbsp;"));
                    }
                    sb.append("</td>");
                }
                sb.append("</tr>");
            }
            sb.append("</table>");
            sb.append("</div>");
        }
        sb.append("</div>");

        return sb.toString();
    }

    private static Map<String, String>[] getRowSpanColSpanMap(Sheet sheet) {

        Map<String, String> map0 = new HashMap<String, String>();
        Map<String, String> map1 = new HashMap<String, String>();
        int mergedNum = sheet.getNumMergedRegions();
        CellRangeAddress range = null;
        for (int i = 0; i < mergedNum; i++) {
            range = sheet.getMergedRegion(i);
            int topRow = range.getFirstRow();
            int topCol = range.getFirstColumn();
            int bottomRow = range.getLastRow();
            int bottomCol = range.getLastColumn();
            map0.put(topRow + "," + topCol, bottomRow + "," + bottomCol);
            int tempRow = topRow;
            while (tempRow <= bottomRow) {
                int tempCol = topCol;
                while (tempCol <= bottomCol) {
                    map1.put(tempRow + "," + tempCol, "");
                    tempCol++;
                }
                tempRow++;
            }
            map1.remove(topRow + "," + topCol);
        }
        Map[] map = { map0, map1 };
        return map;
    }

    /**
     * 获取表格单元格Cell内容
     *
     * @param cell
     * @return
     */
    private static String getCellValue(Cell cell) {

        String result = new String();
        switch (cell.getCellType()) {
            case Cell.CELL_TYPE_NUMERIC:// 数字类型
                if (HSSFDateUtil.isCellDateFormatted(cell)) {// 处理日期格式、时间格式
                    SimpleDateFormat sdf = null;
                    if (cell.getCellStyle().getDataFormat() == HSSFDataFormat.getBuiltinFormat("h:mm")) {
                        sdf = new SimpleDateFormat("HH:mm");
                    } else {// 日期
                        sdf = new SimpleDateFormat("yyyy-MM-dd");
                    }
                    Date date = cell.getDateCellValue();
                    result = sdf.format(date);
                } else {
                    short dataFormat=cell.getCellStyle().getDataFormat();
                    SimpleDateFormat sdf ;
                    // 处理自定义日期格式：m月d日(通过判断单元格的格式id解决)
                    if(dataFormat==14||dataFormat==31||dataFormat==57||dataFormat==58||(176<=dataFormat&&dataFormat<=179)
                            ||(182<=dataFormat&&dataFormat<=196)||(210<=dataFormat&&dataFormat<=213)||208==dataFormat||30==dataFormat){
                        //日期
                        sdf = new SimpleDateFormat("yyyy-MM-dd");
                    } else if (dataFormat == 20 || dataFormat == 32 || dataFormat == 183 || (200 <= dataFormat && dataFormat <= 209)) {
                        //时间
                        sdf = new SimpleDateFormat("HH:mm");
                    }else{
                        //普通数字
                        double value = cell.getNumericCellValue();
                        CellStyle style = cell.getCellStyle();
                        String temp = style.getDataFormatString();
                        DecimalFormat format = new DecimalFormat();
                        // 单元格设置成常规
                        if ("General".equals(temp)) {
                            format.applyPattern("#");
                        }
                        result = format.format(value);
                        return result;
                    }
                    double value = cell.getNumericCellValue();
                    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);
                    result = sdf.format(date);
                }
                break;
            case Cell.CELL_TYPE_STRING:// String类型
                result = cell.getRichStringCellValue().toString();
                break;
            case Cell.CELL_TYPE_BLANK:
                result = "";
                break;
            default:
                result = "";
                break;
        }
        return result;
    }

    /**
     * 处理表格样式
     *
     * @param wb
     * @param sheet
     * @param cell
     * @param sb
     */
    private static void dealExcelStyle(Workbook wb, Sheet sheet, Cell cell, StringBuffer sb) {

        CellStyle cellStyle = cell.getCellStyle();
        if (cellStyle != null) {
            short alignment = cellStyle.getAlignment();
            sb.append("align='" + convertAlignToHtml(alignment) + "' ");// 单元格内容的水平对齐方式
            short verticalAlignment = cellStyle.getVerticalAlignment();
            sb.append("valign='" + convertVerticalAlignToHtml(verticalAlignment) + "' ");// 单元格中内容的垂直排列方式

            if (wb instanceof XSSFWorkbook) {

                XSSFFont xf = ((XSSFCellStyle) cellStyle).getFont();
                short boldWeight = xf.getBoldweight();
                sb.append("style='");
                sb.append("font-weight:" + boldWeight + ";"); // 字体加粗
                sb.append("font-size: " + xf.getFontHeight() / 2 + "%;"); // 字体大小
                int columnWidth = sheet.getColumnWidth(cell.getColumnIndex());
                sb.append("width:" + columnWidth + "px;");

                XSSFColor xc = xf.getXSSFColor();
                if (xc != null && !"".equals(xc)) {
                    sb.append("color:#" + xc.getARGBHex().substring(2) + ";"); // 字体颜色
                }

                XSSFColor bgColor = (XSSFColor) cellStyle.getFillForegroundColorColor();
                if (bgColor != null && !"".equals(bgColor)) {
                    sb.append("background-color:#" + bgColor.getARGBHex().substring(2) + ";"); // 背景颜色
                }
                sb.append(getBorderStyle(0, cellStyle.getBorderTop(),
                        ((XSSFCellStyle) cellStyle).getTopBorderXSSFColor()));
                sb.append(getBorderStyle(1, cellStyle.getBorderRight(),
                        ((XSSFCellStyle) cellStyle).getRightBorderXSSFColor()));
                sb.append(getBorderStyle(2, cellStyle.getBorderBottom(),
                        ((XSSFCellStyle) cellStyle).getBottomBorderXSSFColor()));
                sb.append(getBorderStyle(3, cellStyle.getBorderLeft(),
                        ((XSSFCellStyle) cellStyle).getLeftBorderXSSFColor()));

            } else if (wb instanceof HSSFWorkbook) {

                HSSFFont hf = ((HSSFCellStyle) cellStyle).getFont(wb);
                short boldWeight = hf.getBoldweight();
                short fontColor = hf.getColor();
                sb.append("style='");
                HSSFPalette palette = ((HSSFWorkbook) wb).getCustomPalette(); // 类HSSFPalette用于求的颜色的国际标准形式
                HSSFColor hc = palette.getColor(fontColor);
                sb.append("font-weight:" + boldWeight + ";"); // 字体加粗
                sb.append("font-size: " + hf.getFontHeight() / 2 + "%;"); // 字体大小
                String fontColorStr = convertToStardColor(hc);
                if (fontColorStr != null && !"".equals(fontColorStr.trim())) {
                    sb.append("color:" + fontColorStr + ";"); // 字体颜色
                }
                int columnWidth = sheet.getColumnWidth(cell.getColumnIndex());
                sb.append("width:" + columnWidth + "px;");
                short bgColor = cellStyle.getFillForegroundColor();
                hc = palette.getColor(bgColor);
                String bgColorStr = convertToStardColor(hc);
                if (bgColorStr != null && !"".equals(bgColorStr.trim())) {
                    sb.append("background-color:" + bgColorStr + ";"); // 背景颜色
                }
                sb.append(getBorderStyle(palette, 0, cellStyle.getBorderTop(), cellStyle.getTopBorderColor()));
                sb.append(getBorderStyle(palette, 1, cellStyle.getBorderRight(), cellStyle.getRightBorderColor()));
                sb.append(getBorderStyle(palette, 3, cellStyle.getBorderLeft(), cellStyle.getLeftBorderColor()));
                sb.append(getBorderStyle(palette, 2, cellStyle.getBorderBottom(), cellStyle.getBottomBorderColor()));
            }

            sb.append("' ");
        }
    }

    /**
     * 单元格内容的水平对齐方式
     *
     * @param alignment
     * @return
     */
    private static String convertAlignToHtml(short alignment) {

        String align = "left";
        switch (alignment) {
            case CellStyle.ALIGN_LEFT:
                align = "left";
                break;
            case CellStyle.ALIGN_CENTER:
                align = "center";
                break;
            case CellStyle.ALIGN_RIGHT:
                align = "right";
                break;
            default:
                break;
        }
        return align;
    }

    /**
     * 单元格中内容的垂直排列方式
     *
     * @param verticalAlignment
     * @return
     */
    private static String convertVerticalAlignToHtml(short verticalAlignment) {

        String valign = "middle";
        switch (verticalAlignment) {
            case CellStyle.VERTICAL_BOTTOM:
                valign = "bottom";
                break;
            case CellStyle.VERTICAL_CENTER:
                valign = "center";
                break;
            case CellStyle.VERTICAL_TOP:
                valign = "top";
                break;
            default:
                break;
        }
        return valign;
    }
    /**
     * 转换颜色
     * @param hc
     * @return
     */
    private static String convertToStardColor(HSSFColor hc) {

        StringBuffer sb = new StringBuffer("");
        if (hc != null) {
            if (HSSFColor.AUTOMATIC.index == hc.getIndex()) {
                return null;
            }
            sb.append("#");
            for (int i = 0; i < hc.getTriplet().length; i++) {
                sb.append(fillWithZero(Integer.toHexString(hc.getTriplet()[i])));
            }
        }

        return sb.toString();
    }

    private static String fillWithZero(String str) {
        if (str != null && str.length() < 2) {
            return "0" + str;
        }
        return str;
    }

    static String[] bordesr = { "border-top:", "border-right:", "border-bottom:", "border-left:" };
    static String[] borderStyles = { "solid ", "solid ", "solid ", "solid ", "solid ", "solid ", "solid ", "solid ",
            "solid ", "solid", "solid", "solid", "solid", "solid" };

    private static String getBorderStyle(HSSFPalette palette, int b, short s, short t) {

        if (s == 0) {
            return bordesr[b] + borderStyles[s] + "#d0d7e5 1px;";
        }
        ;
        String borderColorStr = convertToStardColor(palette.getColor(t));
        borderColorStr = borderColorStr == null || borderColorStr.length() < 1 ? "#000000" : borderColorStr;
        return bordesr[b] + borderStyles[s] + borderColorStr + " 1px;";

    }

    private static String getBorderStyle(int b, short s, XSSFColor xc) {

        if (s == 0) {
            return bordesr[b] + borderStyles[s] + "#d0d7e5 1px;";
        }
        ;
        if (xc != null && !"".equals(xc)) {
            String borderColorStr = xc.getARGBHex();// t.getARGBHex();
            borderColorStr = borderColorStr == null || borderColorStr.length() < 1 ? "#000000"
                    : borderColorStr.substring(2);
            return bordesr[b] + borderStyles[s] + borderColorStr + " 1px;";
        }

        return "";
    }

    /**
     * 图片在线预览
     * @param id
     * @param contype
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/getImg")
    public void getImg(String id, String contype, HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        InputStream in = null;
        try {
            SysFileUpload file = swfUploadService.getAttachById(id);
            if (file != null) {
                String filePath = file.getFILE_URL();
                String fastfdsLocation = file.getFastfdsLocation();
                if (fastfdsLocation != null && !"".equals(fastfdsLocation)) {
                    // 下载来自fastdfs的文件
                    if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                        in = this.FastDownloadAes128FileByStream(fastfdsLocation, "avicit2015v6r3");
                    } else {
                        in = this.downLoadFileByStream(fastfdsLocation);

                    }

                } else if (filePath != null && !"".equals(filePath)) {
                    // 下载来自物理存储的文件(磁盘)
                    try {
                        in = new FileInputStream(new File(filePath));

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            // FileEncryptUtil.downloadAes128FileByStream(
                            // response.getOutputStream(), in,
                            // "avicit2015v6r3");
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }
                    } finally {
                        // in.close();
                    }
                } else {
                    // 下载来自数据库
                    Map<String, String> condition = new HashMap<String, String>();
                    condition.put("fileId", id);
                    Blob fileBody = swfUploadService.getFileBodyByCondition(condition);
                    BufferedInputStream bis = null;
                    try {
                        in = fileBody.getBinaryStream();

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            // FileEncryptUtil.downloadAes128FileByStream(response.getOutputStream(),
                            // in, "avicit2015v6r3");
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }

                    } finally {
                        // in.close();
                    }
                }

            }
        } catch (Exception e) {
            log.error("download下载附件出错:", e);
        }

        response.setContentType("text/html; charset=UTF-8");
        response.setContentType(contype);
        OutputStream os = response.getOutputStream();
        try {
            int count = 0;
            byte[] buffer = new byte[1024 * 1024];
            while ((count = in.read(buffer)) != -1) {
                os.write(buffer, 0, count);
            }
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (os != null) {
                os.close();
            }
            if (in != null) {
                in.close();
            }
        }

    }

    /**
     * 获取DOCX后台附件
     *
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/getPPT")
    public String getPPT(String id,String fileType,HttpServletRequest request, HttpServletResponse response) throws IOException {
        InputStream in = null;
        SysFileUpload file = null;
        try {
            file = swfUploadService.getAttachById(id);
            if (file != null) {
                String filePath = file.getFILE_URL();
                String fastfdsLocation = file.getFastfdsLocation();
                if (fastfdsLocation != null && !"".equals(fastfdsLocation)) {
                    // 下载来自fastdfs的文件
                    if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                        in = this.FastDownloadAes128FileByStream(fastfdsLocation, "avicit2015v6r3");
                    } else {
                        in = this.downLoadFileByStream(fastfdsLocation);
                    }
                } else if (filePath != null && !"".equals(filePath)) {
                    // 下载来自物理存储的文件(磁盘)
                    try {
                        in = new FileInputStream(new File(filePath));

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }
                    } finally {
                    }
                } else {
                    // 下载来自数据库
                    Map<String, String> condition = new HashMap<String, String>();
                    condition.put("fileId", id);
                    Blob fileBody = swfUploadService.getFileBodyByCondition(condition);
                    try {
                        in = fileBody.getBinaryStream();

                        if (Integer.parseInt(file.getSECRET_LEVEL()) > 1) {
                            in = null;
                            in = this.FileDownloadAes128FileByStream(in, "avicit2015v6r3");
                        }
                    } finally {
                    }
                }

            }
        } catch (Exception e) {
            log.error("download下载附件出错:", e);
        }
        BufferedInputStream bf = null;
        String viewPath = "";
        try {
            String path = request.getSession().getServletContext().getRealPath("/")+"pptFileExport/";
            if(!new File(path).exists()){
                new File(path).mkdirs();
            }
            String fileName = "Export" + id + ".pdf";
            viewPath = "pptFileExport/"+fileName;
            File pdf = new File(path + fileName);
            //Create PPT document
            Presentation presentation = new Presentation();
            if (fileType.equalsIgnoreCase("pptx")) {
                presentation.loadFromStream(in, FileFormat.PPTX_2007);
            } else {
                presentation.loadFromStream(in, FileFormat.PPT);
            }
            FileOutputStream out = new FileOutputStream(pdf);
            presentation.saveToFile(out, FileFormat.PDF);
            InputStream resultIn = new FileInputStream(pdf);

            bf = new BufferedInputStream(resultIn);
            IOUtils.copy(bf, response.getOutputStream());
            response.getOutputStream().close();
            out.close();
            presentation.dispose();
            resultIn.close();
            bf.close();

        } catch (Exception e) {
            log.error("download下载附件出错:", e);
            e.printStackTrace();
        } finally {
            if (response.getOutputStream() != null) {
                response.getOutputStream().close();
            }
            if (in != null) {
                in.close();
            }
        }
        String resultPdf = "<div class=\"panel-main\">\n" +
                "<iframe scrolling=\"no\" id=\"index_iframe0\" frameborder=\"0\" src=\""+viewPath+"\" style=\"width: 100%; height: 100%;background-color: white;\"></iframe>\n" +
                "t</div>";
        return resultPdf;
    }

    /**
     * 获取帮助文档
     *
     * @param request
     * @param response
     * @param code
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getHelpDocumentByCode")
    public ModelAndView getHelpDocumentByCode(String code, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        ModelAndView mav = new ModelAndView();
        //先根据code获取维护的文档编号
        String documentCode=sysLookupAPI.getNameByLooupTypeCodeAndLooupCodeByAppId(
                "HELP_DOCUMENT_LIST", code, SessionHelper.getApplicationId());
        if(StringUtils.isBlank(documentCode)) {
            String errorStr = "帮助文档异常，请联系管理员维护";
            mav.addObject("error", errorStr);
            mav.setViewName("avicit/static/pdfjs/web/errorview");
            return mav;
        }

        //查找文档主表
//        QueryReqBean<CmosDocumentInfoDTO> documentQrb=new QueryReqBean<CmosDocumentInfoDTO>();
//        CmosDocumentInfoDTO documentSearchDto=new CmosDocumentInfoDTO();
//        documentSearchDto.setDocumentCode(documentCode);
//        documentSearchDto.setDocumentStat("3");
//        documentQrb.setSearchParams(documentSearchDto);
//        List<CmosDocumentInfoDTO> infoList=cmosDocumentInfoService.searchCmosDocumentInfo(documentQrb);
//        if(infoList.isEmpty()) {
//            String errorStr = "帮助文档异常，请联系管理员维护";
//            mav.addObject("error", errorStr);
//            mav.setViewName("avicit/static/pdfjs/web/errorview");
//            return mav;
//        }
//        CmosDocumentInfoDTO info=infoList.get(0);
//
//        List<SysFileUpload> listFile = swfUploadService.getFileListByFormId(info.getId(), "physicalId");
//        if (listFile.size() > 0) {
//            String fileId = listFile.get(0).getId();
//            if (!StringUtils.isBlank(fileId)) {
//                mav=getFileType(fileId,request,response);
//                mav.addObject("d", 1);//for safe
//            }
//        }else {
//            String errorStr = "找不到对应文档附件，请联系管理员维护";
//            mav.addObject("error", errorStr);
//            mav.setViewName("avicit/static/pdfjs/web/errorview");
//        }


        return mav;
    }
}
