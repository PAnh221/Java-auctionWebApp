<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="product" scope="request" type="com.ute.auctionwebapp.beans.Product" />

<t:main>
  <jsp:body>
    <div class="card">
      <h4 class="card-header">
          ${product.proName}
      </h4>

      <div class="card-body">
        <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/Product/AddWatchlist?proid=${c.proID}" role="button">
          <i class="fa fa-heart" aria-hidden="true"></i>
        </a>
<%--        <img src="${pageContext.request.contextPath}/public/imgs/sp/${product.proID}/main.jpg" alt="${product.proName}" title="${product.proName}">--%>
        <p class="card-text mt-3 d-inline">
          Giá bán ngay:
          <h5 class="card-title text-danger d-inline">
            <u><small>đ</small></u><fmt:formatNumber value="${product.bin}" type="number" />
          </h5>
        </p>
<%--        <p class="card-text">Tồn kho: ${product.quantity}</p>--%>
        <p class="card-text">${product.fullDes}</p>
        <p class="card-text"><i>Ngày được đăng bán:</i> ${product.uploadDate}</p>

        <h4 class="mt-5">Lịch sử đấu giá</h4>
        <table class="table table-striped">
          <thead>
          <tr>
            <th scope="col">Thời điểm</th>
            <th scope="col">Người mua</th>
            <th scope="col">Giá</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
          </tr>
          <tr>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
          </tr>
          <tr>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </jsp:body>
</t:main>