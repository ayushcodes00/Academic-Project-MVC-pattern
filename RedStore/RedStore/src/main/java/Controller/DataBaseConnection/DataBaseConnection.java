package Controller.DataBaseConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBaseConnection {
	private static Connection con;
    public static Connection connection() throws ClassNotFoundException, SQLException {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3307/redstore";
        String user = "root";
        String pass = "root123";
        return con = DriverManager.getConnection(url, user, pass);
    }
}
