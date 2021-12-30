<%@ page import="java.util.List" %>
<%@ page import="com.ute.auctionwebapp.beans.Ban" %>
<%@ page import="java.util.concurrent.atomic.AtomicReference" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="product" scope="request" type="com.ute.auctionwebapp.beans.Product" />
<jsp:useBean id="relevantProducts" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />
<jsp:useBean id="bidHistory" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Bid>" />
<jsp:useBean id="isBanned" scope="request" type="java.lang.Boolean" />
<jsp:useBean id="seller" scope="request" type="com.ute.auctionwebapp.beans.User" />
<jsp:useBean id="reputation" scope="request" type="java.lang.Float"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>

<t:main>
  <jsp:body>
    <div class="card">
      <h4 class="card-header">
          ${product.proName}
          <c:choose>
            <c:when test="${product.status==0}">
              <i style="font-weight: lighter"> - ${product.tinyDes}</i>
            </c:when>
            <c:otherwise>
              <c:choose>
                <c:when test="${product.status==1}">
                  <i style="font-weight: lighter"> - (Đã bán)</i>
                </c:when>
                <c:otherwise>
                  <i style="font-weight: lighter"> - (Đã hết hạn đấu giá)</i>
                </c:otherwise>
              </c:choose>
            </c:otherwise>
          </c:choose>
      </h4>

      <div class="card-body">
        <div class="w-50">
          <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img class="d-inline w-100" src="${pageContext.request.contextPath}/public/imgs/sp/${product.proID}/main.jpg" alt="First slide">
              </div>
              <div class="carousel-item">
                <img class="d-inline w-100" src="${pageContext.request.contextPath}/public/imgs/sp/${product.proID}/1.jpg" alt="Second slide">
              </div>
              <div class="carousel-item">
                <img class="d-inline w-100" src="${pageContext.request.contextPath}/public/imgs/sp/${product.proID}/2.jpg" alt="Third slide">
              </div>
            </div>
            <a class="carousel-control-prev h-100 w-10" href="#carouselExampleControls" role="button" data-slide="prev">
                  <i class="fa fa-arrow-left text-info" aria-hidden="true"></i>

            </a>
            <a class="carousel-control-next h-100 w-10" href="#carouselExampleControls" role="button" data-slide="next">
                  <i class="fa fa-arrow-right text-info" aria-hidden="true"></i>

            </a>
          </div>
        </div>
<%--        <img src="${pageContext.request.contextPath}/public/imgs/sp/1/main.jpg" alt="${product.proName}" title="${product.proName}">--%>
        <div class="mt-3">
          <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/Product/AddWatchlist?ProID=${product.proID}&UserID=${authUser.userID}" role="button">
            <i class="fa fa-heart" aria-hidden="true"></i>
          </a>
          <p class="card-text mt-3 d-inline ml-2">
            Giá hiện tại:
            <h5 class="card-title text-danger d-inline">
              <u><small>đ</small></u><fmt:formatNumber value="${product.currentPrice}" type="number" />
            </h5>
            <c:if test="${product.bin != 0}">
              (mua ngay với
              <h5 class="card-title text-danger d-inline">
                <u><small>đ</small></u><fmt:formatNumber value="${product.bin}" type="number" />
              </h5>
              )
            </c:if>
          </p>
        </div>

<%--        <p class="card-text">Tồn kho: ${product.quantity}</p>--%>
        <p>Mô tả chi tiết: </p>
        <p class="card-text">${product.fullDes}</p>
        <p class="card-text"><i>Ngày được đăng bán:</i> ${product.uploadDate}</p>

        <h5 class="mt-5">Lịch sử đấu giá</h5>

        <table class="table table-striped">
          <thead class="thead-light">
          <tr>
            <th scope="col"><i>Thời điểm</i></th>
            <th scope="col"><i>Người ra giá</i></th>
            <th scope="col"><i>Kick người đấu giá</i></th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${bidHistory.size()==0}">
              <tr>
                <td>Chưa có</td>
                <td>Chưa có</td>
                <td>Chưa có</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach items="${bidHistory}" var="h">
                <tr>
                  <td>${h.time}</td>
                  <td>${h.userName}<a href="${pageContext.request.contextPath}/Rating/Detail?Username=${h.userName}"> (${h.reputationOfBidder}%)</a></td>
                  <td>
                    <c:if test="${authUser.userID == product.sellerID && product.status == 0}">
                    <button class="btn btn-secondary" onclick="if (confirm('Bạn có muốn ban user: ${h.userName} khỏi sản phẩm hiện tại không?')) {
                      <%--window.location = '${pageContext.request.contextPath}/Bid/AddBid?proid=${product.proID}?price='+document.getElementById('price').value;--%>
                            const Http = new XMLHttpRequest();
                            const url='${pageContext.request.contextPath}/Ban/AddBan?proid=${product.proID}&bidderusername=${h.userName}';
                      <%--const url = '${pageContext.request.contextPath}/Product/AddWatchlist?proid=${product.proID}'--%>
                            Http.open('POST', url);
                            Http.send();
                            console.log('Đã ban user');
                            } else {
                            console.log('Hủy thao tác ban user');}">
                      <i class="fa fa-ban" aria-hidden="true"></i>
                      Kick
                    </button>
                  </c:if>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
        <div class="form-inline mt-2">
          <div class="form-group mb-2">
            <span>Nhập giá tối đa </span>
          </div>
          <c:choose>
            <c:when test="${product.status == 0 && authUser.userID != product.sellerID && !isBanned}">
              <div class="form-group mx-sm-3 mb-2">
                <input type="number" class="form-control" min="${product.currentPrice + product.stepPrice}" id="price" value="${product.currentPrice + product.stepPrice}">
              </div>
              <button <%--type="submit"--%>onclick="if (confirm('Bạn có muốn đấu giá món đồ: ${product.proName} với giá ' + document.getElementById('price').value +' vnđ?')) {
                <%--window.location = '${pageContext.request.contextPath}/Bid/AddBid?proid=${product.proID}?price='+document.getElementById('price').value;--%>
                      const Http = new XMLHttpRequest();
                      const url='${pageContext.request.contextPath}/Bid/AddBid?proid=${product.proID}&bidderid=${authUser.userID}&price='+document.getElementById('price').value;
                <%--const url = '${pageContext.request.contextPath}/Product/AddWatchlist?proid=${product.proID}'--%>
                      Http.open('POST', url);
                      Http.send();
                      } else {
                      console.log('Hủy thao tác ra giá');}" class="btn btn-danger btn-lg">
                <i class="fa fa-gavel" aria-hidden="true"></i>
                Ra giá
              </button>
            </c:when>
            <c:otherwise>
              <div class="form-group mx-sm-3 mb-2">
                <input type="number" class="form-control" disabled>
              </div>
              <button class="btn btn-secondary btn-lg" disabled>
                <i class="fa fa-gavel" aria-hidden="true"></i>
                Ra giá
              </button>
            </c:otherwise>
          </c:choose>
        </div>

        <div class="alert alert-primary mt-3" role="alert">
          <p><i class="fa fa-id-badge mr-2" aria-hidden="true"></i>${seller.name}</p>
          <p><i class="fa fa-envelope mr-1" aria-hidden="true"></i>${seller.email}</p>
          <a href="${pageContext.request.contextPath}/Rating/Detail?Username=${seller.userName}"><h5 class="mt-3"><i class="fa fa-star mr-1" aria-hidden="true"></i> ${reputation}%</h5></a></div>
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