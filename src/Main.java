import dataNoBase.*;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;

public class Main {
    public static void main(String[] args) throws SQLException {
        Connection test = JDBCTool.getConnection();
        System.out.println(test.isValid(1));
        PersonDAO.insertPerson(new Person(3, "Suri", "123456", "shuqi.dai@ucdconnect.ie", new Timestamp(new java.util.Date().getTime()), 0));
    }

}