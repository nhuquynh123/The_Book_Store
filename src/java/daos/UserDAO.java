package daos;

import dtos.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    Connection cn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    public UserDTO checkLogin(String username, String password) throws SQLException {
        try {
            cn = utils.DBUtil.getConnection();
            if (cn != null) {
                String sql = "select UserID,UserName,RoleID\n"
                        + "from tblUsers\n"
                        + "where UserName = ? and PassWord = ?";
                pst = cn.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);
                rs = pst.executeQuery();
                if (rs.next()) {
                    UserDTO u = new UserDTO(rs.getInt("UserID"), rs.getString("UserName"), "****", rs.getInt("RoleID"));
                    return u;
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return null;
    }

}
