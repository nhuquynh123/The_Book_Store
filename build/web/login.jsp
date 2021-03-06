<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Book Store</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/css.css">
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="542273842720-sjjmduo4sf62gs9h2uj565ml101sg7v5.apps.googleusercontent.com">
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body>
        <c:if test="${not empty requestScope.OUT}">
            <script>
                swal("${requestScope.OUT}", "You clicked the button!", "success");
            </script>
        </c:if>
        <div class="wrapper">
            <div class="form">
                <div class="title">
                    Login Page
                </div>
                <form method="post" action="MainController">
                    <div class="input_wrap">
                        <label for="input_text">Username</label>
                        <div class="input_field">
                            <input type="text" name="username" class="input" id="input_text">
                        </div>
                    </div>
                    <div class="input_wrap">
                        <label for="input_password">Password</label>
                        <div class="input_field">
                            <input type="password" name="password" class="input" id="input_password">
                        </div>
                    </div>
                    
                    
                    
                    <c:if test="${requestScope.MESS !=null}">
                        <p>Incorrect username or password. Please try again
                        </c:if>
                    <div class="input_wrap">
                        <input type="submit" name="action" id="login_btn" class="btn disabled" value="Login" disabled="true">
                    </div>
                </form>
                
                
            </div>
        </div>
    </body>
    <script>
        var input_fields = document.querySelectorAll(".input");
        var login_btn = document.querySelector("#login_btn");

        input_fields.forEach(function (input_item) {
            input_item.addEventListener("input", function () {
                if (input_item.value.length > 3) {
                    login_btn.disabled = false;
                    login_btn.className = "btn enabled"
                }
            })
        });

        function nonAccentVietnamese(str) {
            str = str.toLowerCase();
            str = str.replace(/??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???/g, "a");
            str = str.replace(/??|??|???|???|???|??|???|???|???|???|???/g, "e");
            str = str.replace(/??|??|???|???|??/g, "i");
            str = str.replace(/??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???/g, "o");
            str = str.replace(/??|??|???|???|??|??|???|???|???|???|???/g, "u");
            str = str.replace(/???|??|???|???|???/g, "y");
            str = str.replace(/??/g, "d");
            // Some system encode vietnamese combining accent as individual utf-8 characters
            str = str.replace(/\u0300|\u0301|\u0303|\u0309|\u0323/g, ""); // Huy???n s???c h???i ng?? n???ng 
            str = str.replace(/\u02C6|\u0306|\u031B/g, ""); // ??, ??, ??, ??, ??
            return str;
        }
    </script>


</html>

