package net.coffeexing.webmall.dao;

import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BaseDao {
    public static <T> List<T> operQuery(String sql, List<Object> p, Class<T> cls)
            throws Exception {
        Connection conn = null;
        PreparedStatement pste = null;
        ResultSet rs = null;
        List<T> list = new ArrayList<T>();
        conn = getConn();
        try {
            pste = conn.prepareStatement(sql);
            if (p != null) {
                for (int i = 0; i < p.size(); i++) {
                    pste.setObject(i + 1, p.get(i));
                }
            }

            rs = pste.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            while (rs.next()) {
                T entity = cls.newInstance();
                for (int j = 0; j < rsmd.getColumnCount(); j++) {
                    String col_name = rsmd.getColumnName(j + 1);
                    Object value = rs.getObject(col_name);
                    Field field = cls.getDeclaredField(col_name);
                    field.setAccessible(true);
                    field.set(entity, value);
                }
                list.add(entity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            releaseAll(rs, pste, conn);
        }
        return list;
    }

    public static boolean operUpdate(String sql, List<Object> p) {
        Connection conn = null;
        PreparedStatement pste = null;
        int res = 0;
        conn = getConn();
        try {
            pste = conn.prepareStatement(sql);
            if (p != null) {
                for (int i = 0; i < p.size(); i++) {
                    pste.setObject(i + 1, p.get(i));
                }
            }
            res = pste.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            releaseAll(null, pste, conn);
        }
        return res > 0;//
    }

    private static void releaseAll(ResultSet rs, PreparedStatement pste, Connection conn) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pste != null) {
                pste.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConn() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://119.45.239.3:3306/online_shop?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true", "admin", "123456");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
