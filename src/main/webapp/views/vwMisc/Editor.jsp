<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="product" scope="request" type="com.ute.auctionwebapp.beans.Product"/>
<jsp:useBean id="tinyDes" scope="request" type="java.lang.String"/>

<t:main>
  <jsp:attribute name="js">
    <script src="https://cdn.tiny.cloud/1/kr8w0r5fuhf6ct3y26bbhqco9zkw8umtqcz3lfc5sjwj9rhh/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script>
      tinymce.init({
        selector: '#txtFullDes',
        height: 450,
        plugins: 'paste image link autolink lists table media',
        menubar: false,
        toolbar: [
          'undo redo | bold italic underline strikethrough | numlist bullist | alignleft aligncenter alignright | forecolor backcolor | table link image media'
        ],
        // entity_encoding: 'raw'
      });
    </script>
  </jsp:attribute>
  <jsp:body>
    <form action="" method="post">
      <div class="card">
        <h4 class="card-header">
          WYSIWYG HTML Editor
        </h4>
        <div class="card-body">
          <div class="form-group">
            <label for="txtTinyDes">Chỉnh sửa mô tả ngắn gọn</label>
            <input type="text" class="form-control" id="txtTinyDes" name="TinyDes" autofocus placeholder="${tinyDes}" value="${tinyDes}"/>
          </div>
          <div class="form-group">
            <label for="txtFullDes">Bổ sung mô tả chi tiết</label>
            <textarea id="txtFullDes" name="FullDes"></textarea>
          </div>
        </div>
        <div class="card-footer">
          <button type="submit" class="btn btn-primary">
            <i class="fa fa-check" aria-hidden="true"></i>
            Save
          </button>
        </div>
      </div>
    </form>
  </jsp:body>
</t:main>