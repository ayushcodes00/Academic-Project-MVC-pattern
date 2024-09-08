package Controller.Action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.DataBaseConnection.DataBaseConnection;
import Controller.Encryptt.Passenc;
import Model.User.Query;
import Model.User.User;
import Model.User.UserMessage;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter printOut = response.getWriter();
        String Email = request.getParameter("Email");
        String Password = request.getParameter("Password");
        String encryptedpassword = "";

        try {
            encryptedpassword = Passenc.encryption(Password, "my-Secret-Key-hi");
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        if (Email != null && Password != null && Email.equals("admin@gmail.com") && Password.equals("admin")) {
            User u = new User();
            HttpSession session = request.getSession();
            session.setAttribute("User", u);
            session.setAttribute("Email", Email);
            session.setMaxInactiveInterval(30 * 60);
            Cookie cookie = new Cookie("email", u.getEmail());
            ((HttpServletResponse) response).addCookie(cookie);
            u.setFirstName("Admin");
            u.setEmail(Email);
            printOut.println(Email);
            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
        } else {
            Query user;
            try {
                user = new Query(DataBaseConnection.connection());
                User u = user.Login(Email, encryptedpassword);

                if (u == null) {
                    UserMessage msg = new UserMessage("Invalid", "Login Error", "invalid-login");
                    HttpSession session = request.getSession();
                    session.setAttribute("Message", msg);
                    response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("User", u);
                    session.setAttribute("name", u.getFirstName());
                    session.setMaxInactiveInterval(30 * 60);
                    printOut.println(u.getEmail());
                    u.setEmail(Email);
                    Cookie cookie = new Cookie("email", u.getEmail());
                    response.addCookie(cookie);
                    printOut.println(u.getProfilePicture());

                    // Insert a new record into the login_history table
                    Connection conn = DataBaseConnection.connection();
                    String sql = "INSERT INTO login_history (email) VALUES (?)";
                    PreparedStatement statement = conn.prepareStatement(sql);
                    statement.setString(1, Email);
                    statement.executeUpdate();

                    response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}