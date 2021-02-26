package avicit.assets.utils;


import java.io.*;
import java.sql.*;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * @Auther: yangxd
 * @Date: 2020/9/9
 */
public class FileUtil {

    private static final int BUFFER_SIZE = 2 * 1024;

    /**
     * 根据oracle的大字段生成文件
     * @param filePath
     * @param blob
     */
    public static void generateFileFromBlob(String filePath,Blob blob)throws  Exception{
        try(InputStream in = blob.getBinaryStream();
            FileOutputStream file = new FileOutputStream(filePath)) {

            int len = (int) blob.length();
            byte[] buffer = new byte[len]; // 建立缓冲区
            while ((len = in.read(buffer)) != -1) {
                file.write(buffer, 0, len);
            }
        }
    }



    /**
     * 压缩成ZIP
     *
     * @param srcFiles 需要压缩的文件列表
     * @param targetFile      压缩文件输出路径
     * @throws RuntimeException 压缩失败会抛出运行时异常
     */


    public static void toZip(List<File> srcFiles, String targetFile) throws RuntimeException {
        long start = System.currentTimeMillis();
        ZipOutputStream zos = null;
        try {
            zos = new ZipOutputStream(new FileOutputStream(new File(targetFile)));
            for (File srcFile : srcFiles) {
                byte[] buf = new byte[BUFFER_SIZE];
                zos.putNextEntry(new ZipEntry(srcFile.getName()));
                int len;
                FileInputStream in = new FileInputStream(srcFile);
                while ((len = in.read(buf)) != -1) {
                    zos.write(buf, 0, len);
                }
                zos.closeEntry();
                in.close();
            }
            long end = System.currentTimeMillis();
            System.out.println("压缩完成，耗时：" + (end - start) + " ms");
        } catch (Exception e) {
            throw new RuntimeException("zip error from ZipUtils", e);
        } finally {
            if (zos != null) {
                try {
                    zos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }


    /**
     * 递归压缩方法
     *
     * @param sourceFile       源文件
     * @param zos              zip输出流
     * @param name             压缩后的名称
     * @param KeepDirStructure 是否保留原来的目录结构,true:保留目录结构;
     *                         <p>
     *                         <p>
     *                         <p>
     *                         false:所有文件跑到压缩包根目录下(注意：不保留目录结构可能会出现同名文件,会压缩失败)
     * @throws Exception
     */


    /*private static void compress(File sourceFile, ZipOutputStream zos, String name,  boolean KeepDirStructure) throws Exception {
        byte[] buf = new byte[BUFFER_SIZE];
        if (sourceFile.isFile()) {
            // 向zip输出流中添加一个zip实体，构造器中name为zip实体的文件的名字
            zos.putNextEntry(new ZipEntry(name));
            // copy文件到zip输出流中
            int len;
            FileInputStream in = new FileInputStream(sourceFile);
            while ((len = in.read(buf)) != -1) {
                zos.write(buf, 0, len);
            }
            // Complete the entry
            zos.closeEntry();
            in.close();
        } else {
            File[] listFiles = sourceFile.listFiles();
            if (listFiles == null || listFiles.length == 0) {
                // 需要保留原来的文件结构时,需要对空文件夹进行处理
                if (KeepDirStructure) {
                    // 空文件夹的处理
                    zos.putNextEntry(new ZipEntry(name + "/"));
                    // 没有文件，不需要文件的copy
                    zos.closeEntry();
                }
            } else {
                for (File file : listFiles) {
                    // 判断是否需要保留原来的文件结构
                    if (KeepDirStructure) {
                        // 注意：file.getName()前面需要带上父文件夹的名字加一斜杠,
                        // 不然最后压缩包中就不能保留原来的文件结构,即：所有文件都跑到压缩包根目录下了
                        compress(file, zos, name + "/" + file.getName(), KeepDirStructure);
                    } else {
                        compress(file, zos, file.getName(), KeepDirStructure);
                    }
                }
            }
        }
    }*/


    public static boolean delAllFile(String path) {
        boolean flag = false;
        File file = new File(path);
        if (!file.exists()) {
            return flag;
        }
        if (!file.isDirectory()) {
            return flag;
        }
        String[] tempList = file.list();
        File temp = null;
        for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
                temp.delete();
            }
            /*if (temp.isDirectory()) {
                delAllFile(path + "/" + tempList[i]);//先删除文件夹里面的文件
                delFolder(path + "/" + tempList[i]);//再删除空文件夹
                flag = true;
            }*/
        }
        return flag;
    }


    public static void main(String[] args)throws Exception{

        //测试从Blob生成文件
        /*Connection conn = null;
        Statement sql = null;
        ResultSet rs = null;

            try {
                // Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                // String sourceURL = "jdbc:odbc:ORDB";
                Class.forName("oracle.jdbc.driver.OracleDriver");
                String sourceURL = "jdbc:oracle:thin:@192.168.0.122:1521:ORCL";//        String sourceUrl = "jdbc:oracle:thin:@(DESCRIPTION = (ADDRESS_LIST =(ADDRESS = (PROTOCOL = TCP)(HOST = 10.10.52.53)(PORT = 1521)) ) (CONNECT_DATA =(SERVICE_NAME = orcl)))";String user = "root"; String password = "password";　　　　　　　　　　

                conn = DriverManager.getConnection(sourceURL, "PT6", "cape");

                sql = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

                // 注：“ini”字段为BLOB字段
                String sqlstr = "select * from SYS_ATTACHMENT t where t.id = '4028af81746760b801746ce0a9c10e09'";

                rs = sql.executeQuery(sqlstr);

                while (rs.next()) {
                    String name = rs.getString("attach_name");

                    // 如下使用JdbcOdbcDriver则报错：Hit uncaught exception
                    // java.lang.UnsupportedOperationException
                    // java.sql.Blob blob = rs.getBlob("ini");

                    // 注意这里的写法：使用的是OracleDriver
                    //reportfile数据库中的blob字段
                    //oracle.sql.BLOB blob = (oracle.sql.BLOB) rs.getBlob("attach_blob");
                    java.sql.Blob blob = (java.sql.Blob) rs.getBlob("attach_blob");
                    String filepath = "D:/" + name ;
                    System.out.println("输出文件路径为:" + filepath);

                    generateFileFromBlob(filepath,blob);
                }
            } finally {
                rs.close();
                sql.close();
                conn.close();
            }*/


        //测试压缩文件
        /*List<File> fileList = new ArrayList<File>();
        fileList.add(new File("D:/vue1.html"));
        fileList.add(new File("D:/vue2.html"));
        fileList.add(new File("D:/vue3.html"));

        FileUtil.toZip(fileList, "D:/vue.zip");*/


        delAllFile("D:\\delete_dir\\a1");


    }
}
