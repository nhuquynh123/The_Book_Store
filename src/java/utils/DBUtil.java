package utils;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBUtil {

    public static Connection getConnection() throws ClassNotFoundException, SQLException, NamingException {
        Context context = new InitialContext();
        Context tomcat = (Context) context.lookup("java:comp/env");
        DataSource ds = (DataSource) tomcat.lookup("DB");
        Connection con = ds.getConnection();

        return con;
    }
}
