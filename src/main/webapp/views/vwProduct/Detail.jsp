<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="product" scope="request" type="com.ute.auctionwebapp.beans.Product" />
<jsp:useBean id="relevantProducts" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />
<jsp:useBean id="seller" scope="request" type="com.ute.auctionwebapp.beans.User" />
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>

<t:main>
  <jsp:body>
    <div class="card">
      <h4 class="card-header">
          ${product.proName}
      </h4>

      <div class="card-body">
<%--        <img src="${pageContext.request.contextPath}/public/imgs/sp/1/main.jpg" alt="${product.proName}" title="${product.proName}">--%>
        <div class="mt-3">
          <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/Product/AddWatchlist?ProID=${product.proID}&UserID=${authUser.userID}" role="button">
            <i class="fa fa-heart" aria-hidden="true"></i>
          </a>
          <p class="card-text mt-3 d-inline ml-2">
            Giá bán ngay:
          <h5 class="card-title text-danger d-inline">
            <u><small>đ</small></u><fmt:formatNumber value="${product.bin}" type="number" />
          </h5>
          </p>
        </div>

<%--        <p class="card-text">Tồn kho: ${product.quantity}</p>--%>
        <p class="card-text">${product.fullDes}</p>
        <p class="card-text"><i>Ngày được đăng bán:</i> ${product.uploadDate}</p>

        <h5 class="mt-5">Lịch sử đấu giá</h5>

        <table class="table-sm mt-2">
          <thead class="thead-light">
          <tr>
            <th scope="col"><i>Thời điểm</i></th>
            <th scope="col"><i>Người mua</i></th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>00:00</td>
            <td>Otto</td>
          </tr>
          <tr>
            <td>00:00</td>
            <td>Thornton</td>
          </tr>
          <tr>
            <td>00:00</td>
            <td>the Bird</td>
          </tr>
          </tbody>
        </table>
        <form class="form-inline mt-2" method="post">
          <div class="form-group mb-2">
            <span>Mức giá </span>
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <input type="text" class="form-control"placeholder="Nhập mức giá" id="price">
          </div>
          <button type="submit" class="btn btn-danger btn-lg">
            <i class="fa fa-gavel" aria-hidden="true"></i>
            Ra giá
          </button>
        </form>

        <div class="alert alert-primary mt-3" role="alert">
          <p><i class="fa fa-id-badge mr-2" aria-hidden="true"></i>${seller.name}</p>
          <p><i class="fa fa-envelope mr-1" aria-hidden="true"></i>${seller.email}</p>
<%--          <p><i class="fa fa-star mr-1" aria-hidden="true"></i>${seller.rating}</p>--%>
        </div>
      </div>
    </div>



    <div class="card mt-3">
      <h5 class="card-header">
        Sản phẩm tương tự "${product.proName}"
      </h5>
      <c:choose>
        <c:when test="${relevantProducts.size() == 0}">
          <div class="card-body">
            <p class="card-text">Chưa có sản phẩm tương tự nào.</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="card-body">
            <div class="row">
              <c:forEach items="${relevantProducts}" var="c">
                <div class="col-sm-3 mb-2">
                  <div class="card h-100">
                      <%--                      <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.proID}/main_thumbs.jpg" alt="${c.proName}" title="${c.proName}" class="card-img-top">--%>
                    <div class="card-body">
                      <h6 class="card-title">${c.proName}</h6>
                      <h5 class="card-title text-danger">
                        <u><small>đ</small></u><fmt:formatNumber value="${c.bin}" type="number" />
                      </h5>
                      <p class="font-weight-light mt-3">${c.uploadDate}</p>
                    </div>
                    <div class="card-footer text-muted">
                      <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/Product/AddWatchlist?proid=${c.proID}" role="button">
                        <i class="fa fa-heart" aria-hidden="true"></i>
                      </a>

                      <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/Product/Detail?id=${c.proID}" role="button">
                          <%--                        <i class="fa fa-eye" aria-hidden="true"></i>--%>
                        Chi tiết sản phẩm
                      </a>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </jsp:body>
</t:main>