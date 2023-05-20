import dataNoBase.*;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;

public class Main {
    public static void main(String[] args) throws SQLException {
        Connection test = JDBCTool.getConnection();
        System.out.println(test.isValid(1));
        AdminDAO.insertAdmin(new Admin(122, "test", "test", "test", new Timestamp(new java.util.Date().getTime())));
//        AdminDAO.deleteAdminByUsername("test");
    }
}