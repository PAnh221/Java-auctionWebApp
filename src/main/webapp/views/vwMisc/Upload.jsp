<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="subcategory" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.SubCategory>"/>


<t:main>
  <jsp:attribute name="css">
    <link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
  </jsp:attribute>
  <jsp:attribute name="js">
    <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/themes/fa/theme.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/js/locales/vi.min.js"></script>
    <script src="https://cdn.tiny.cloud/1/kr8w0r5fuhf6ct3y26bbhqco9zkw8umtqcz3lfc5sjwj9rhh/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script>
      $('#fuMain').fileinput({
        theme: 'fa',
        language: 'vi',
        dropZoneEnabled: false,
        allowedFileExtensions: ['jpg', 'png', 'gif']
      });
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
    <form method="post" enctype="multipart/form-data">
      <div class="card">
        <h4 class="card-header">
          Đăng sản phẩm
        </h4>
        <div class="card-body">
          <div class="form-group">
            <label for="txtProName">Tên sản phẩm <label style="color: red">( * )</label></label>
            <input type="text" class="form-control" id="txtProName" name="ProName" autofocus>
            <br>
            <label>Danh mục con <label style="color: red">( * )</label></label>
            <br>
            <select class="form-control" aria-label="Default select example" name="SubCategory">
              <c:forEach items="${subcategory}" var="s">
                <option value="{${s.getSubCatID()}}">${s.getSubCatName()}</option>
              </c:forEach>
            </select>
            <br>
            <label for="numStartPrice">Giá khởi điểm <label style="color: red">( * )</label></label>
            <input type="number" min="0" class="form-control" id="numStartPrice" name="StartPrice" autofocus>
            <label for="numStepPrice">Bước giá <label style="color: red">( * )</label></label>
            <input type="number" min="1" class="form-control" id="numStepPrice" name="StepPrice" autofocus>
            <label for="numBin">Giá mua ngay</label>
            <input type="number" min="0" class="form-control" id="numBin" name="Bin" autofocus>
            <label for="txtTinyDes">Mô tả ngắn gọn <label style="color: red">( * )</label></label>
            <input type="text" class="form-control" id="txtTinyDes" name="TinyDes" autofocus>
            <label for="txtFullDes">Mô tả chi tiết <label style="color: red">( * )</label></label>
            <textarea id="txtFullDes" name="FullDes"></textarea>
          </div>
          <div class="form-group">
            <label for="fuMain">Thêm tối thiểu 3 ảnh mô tả <label style="color: red">( * )</label></label>
            <input id="fuMain" name="fuMain" type="file" />
          </div>
        </div>
        <div class="card-footer">
          <button type="submit" class="btn btn-primary">
            <i class="fa fa-check" aria-hidden="true"></i>
            Post
          </button>
        </div>
      </div>
    </form>
  </jsp:body>
</t:main>