package dtos;

import java.io.Serializable;

public class UserDTO implements Serializable{
    private int UserID;
    private String UserName;
    private String PassWord;
    private int RoleID;

    public UserDTO() {
    }

    public UserDTO(int UserID, String UserName, String PassWord, int RoleID) {
        this.UserID = UserID;
        this.UserName = UserName;
        this.PassWord = PassWord;
        this.RoleID = RoleID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String UserName) {
        this.UserName = UserName;
    }

    public String getPassWord() {
        return PassWord;
    }

    public void setPassWord(String PassWord) {
        this.PassWord = PassWord;
    }

    public int getRoleID() {
        return RoleID;
    }

    public void setRoleID(int RoleID) {
        this.RoleID = RoleID;
    }

}
