<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <c:if test="${not empty requestScope.OUT}">
            <script>
                swal("SORRY!", "${requestScope.OUT}");
            </script>
        </c:if>
        <c:if test="${not empty requestScope.OK}">
            <script>
                swal("${requestScope.OK}", "You clicked the button!", "success");
            </script>
        </c:if>
        <jsp:include page="menu.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                    <div class="col">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb d-flex justify-content-center">

                                <form action="MainController" class="d-flex align-items-center" >

                                    <li > <input class="form-control " type="number" name="number1" value="${param.number1}$" placeholder="First amount" ></li>
                                <li class="mx-2" > <input class="form-control" type="number" name="number2" value="${param.number2}$" placeholder="Second amount" ></li>
                                <li> <input class="btn btn-success" type="submit" name="action" value="Search By Money"></li>
                            </form>

                            </div>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                
                <div class="col-sm-3">
                    <div class="card bg-light mb-3">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                        <ul class="list-group category_block">
                            <c:forEach items="${sessionScope.listc}" var="c">
                                <li class="list-group-item text-white "><a href="MainController?action=category&cid=${c.getCategoryID()}">${c.getCategoryName()}</a></li>
                                </c:forEach>
                            <li class="list-group-item text-white "><a href="MainController?action=category&cid=0">All</a></li>
                        </ul>
                    </div>
                </div>
                
                    <div class="col-sm-9">
                        <div id="content" class="row">


                        <c:forEach items="${sessionScope.listb}" var="b">
                            <c:if test="${b.isStatus()}"> 
                                <div class="product col-12 col-md-6 col-lg-4">
                                    <div class="card">
                                        <img class="card-img-top" src="anh/${b.getImage()}" alt="Card image cap">
                                        <div class="card-body">
                                            <h4 class="card-title show_txt"><a href="detail?bid=${b.getBookID()}" title="View Book"></a></h4>
                                            <p class="card-text show_txt">${b.getBookName()}</p>
                                            <p class="card-text show_txt">Author: ${b.getAuthor()}</p>
                                            <p class="card-text show_txt">Quantity: ${b.getQuantity()}</p>
                                            <div class="row">
                                                <div class="col">
                                                    <p class="btn btn-danger btn-block">${b.getPrice()} $</p>
                                                </div>
                                                <c:if test="${sessionScope.USER.getRoleID() == 2}">
                                                    <c:if test="${b.getQuantity()>0}">
                                                        <div class="col">
                                                            <a href="MainController?action=AddtoCart&BID=${b.getBookID()}" class="btn btn-success btn-block">Add to cart</a>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${b.getQuantity()<=0}">
                                                        <p class="card-text show_txt" style="text-align: center">OUT OF QUANTITY</p>
                                                    </c:if>
                                                </c:if>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${empty sessionScope.listb}"></c:if>
                                      
                    </div>
                </div>

            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </body>
</html>

