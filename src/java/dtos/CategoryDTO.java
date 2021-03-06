package dtos;

import java.io.Serializable;

public class CategoryDTO implements Serializable{
    private int CategoryID;
    private String CategoryName;

    public CategoryDTO() {
    }

    public CategoryDTO(int CategoryID, String CategoryName) {
        this.CategoryID = CategoryID;
        this.CategoryName = CategoryName;
    }

    public int getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(int CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getCategoryName() {
        return CategoryName;
    }

    public void setCategoryName(String CategoryName) {
        this.CategoryName = CategoryName;
    }

    @Override
    public String toString() {
        return "CategoryDTO{" + "CategoryID=" + CategoryID + ", CategoryName=" + CategoryName + '}';
    }
    
    
}
