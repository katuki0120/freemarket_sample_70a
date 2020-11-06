$(document).on("turbolinks:load", function () {
  const uploadProducts = '#input-form ul';
  const uploadDrop = '#upload-drop';
   
  $('#product_images').on('change',function(e){
    let files = e.target.files;
    $.each(files, function(i,file) {
      let reader = new FileReader();
      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        return false;
      }
    reader.onload =(function(file){
      return function(e){
        let itemLength = $(uploadProducts).children('li').length;
        if (itemLength == 10){
          return false;
        } else{
          $(uploadProducts).children('label').before(`<li class="main_image__input-list">
                                  <figure class="main_image__input-list-figure">
                                    <img src='${e.target.result}' title='${file.name}'>
                                  </figure>
                                  <div class="main_image__input-upload-buttun">
                                    <a class="main_image__input-upload-edit" href="">編集
                                    </a><a class="main_image__input-upload-delete" >削除
                                    </a>
                                  </div></li>`);
          $(uploadProducts).removeClass().addClass(`main_image__input__form-upload main_image__form-upload--have-product-${itemLength % 5 + 1}`);
          if(itemLength == 9){
            $(uploadDrop).removeClass().addClass(`main_image__input__form-upload-drop main_image__input__form-upload-drop--have-product-10`);
          } else {
          $(uploadDrop).removeClass().addClass(`main_image__input__form-upload-drop main_image__input__form-upload-drop--have-product-${(itemLength + 1) % 5}`);
          }
        }
      };
    })(file);
    reader.readAsDataURL(file);
  });
  });

  $(document).on('click','.main_image__input-upload-delete',function(){
    $(this).parents('.main_image__input-list').remove();
    let uploadItemLength = $(uploadProducts).children('li').length;
    $(uploadProducts).removeClass().addClass(`main_image__input__form-upload main_image__form-upload--have-product-${uploadItemLength % 5}`);
    $(uploadDrop).removeClass().addClass(`main_image__input__form-upload-drop main_image__input__form-upload-drop--have-product-${uploadItemLength % 5}`);
  });

  $(".input-sentences").keyup(function () {
    var count = $(this).val().length;
    $(".count").text(count);
  });

  $(function () {
    function appendOption(category) {
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    function appendChidrenBox(insertHTML) {
      var childSelectHtml = "";
      childSelectHtml = `<select class="main_select-wrapper__box--select" id="child_category" name="product[category_id]">
                          <option value="---">---</option>
                          ${insertHTML}
                        </select>`;
      $(".main_select-wrapper__box").append(childSelectHtml);
    }
    function appendGrandchidrenBox(insertHTML) {
      var grandchildSelectHtml = "";
      grandchildSelectHtml = `<select class="main_select-wrapper__box--select" id="grand_child_category" name="product[category_id]">
                                <option value="---">---</option>
                                ${insertHTML}
                              </select>`;
      $(".main_select-wrapper__box").append(grandchildSelectHtml);
    }
    $("#parent_category").on("change", function () {
      var parentCategory = document.getElementById("parent_category").value;
      if (parentCategory != "---") {
        $.ajax({
          url: "get_category_children",
          type: "GET",
          data: { parent_name: parentCategory },
          dataType: "json",
        })
          .done(function (children) {
            $("#child_category").remove();
            $("#grand_child_category").remove();
            $("#size_wrapper").remove();
            $("#brand_wrapper").remove();
            var insertHTML = "";

            children.forEach(function (child) {
              insertHTML += appendOption(child);
            });
            appendChidrenBox(insertHTML);
          })

          .fail(function () {
            alert("カテゴリー取得に失敗しました");
          });
      } else {
        $("#child_category").remove();
        $("#grand_child_category").remove();
        $("#size_wrapper").remove();
        $("#brand_wrapper").remove();
      }
    });

    $(".main_details__category").on("change", "#child_category", function () {
      var childId = $("#child_category option:selected").data("category");
      if (childId != "---") {
        $.ajax({
          url: "get_category_grand_children",
          type: "GET",
          data: { child_id: childId },
          dataType: "json",
        })
          .done(function (grandchildren) {
            if (grandchildren.length != 0) {
              $("#grand_child_category").remove();
              $("#size_wrapper").remove();
              $("#brand_wrapper").remove();
              var insertHTML = "";
              grandchildren.forEach(function (grandchild) {
                insertHTML += appendOption(grandchild);
              });
              appendGrandchidrenBox(insertHTML);
            }
          })
          .fail(function () {
            alert("カテゴリー取得に失敗しました");
          });
      } else {
        $("#rand_child_category").remove();
        $("#brand_wrapper").remove();
      }
    });
  });

  $("#price").keyup(function () {
    let price = $(this).val();
    if (price >= 300 && price <= 9999999) {
      let fee = Math.floor(price * 0.1);

      let profit = price - fee;
      $("#fee-value").text("¥" + fee.toLocaleString());

      $("#profit-value").text("¥" + profit.toLocaleString());
    } else {
      $("#fee-value").html("ー");
      $("#profit-value").html("ー");
    }
  });

  $(".upload-drop-box").on("click", function (e) {
    console.log(e.target.files.length);
    $("#error-image").text("");

    $("#error-image").text("");
    let imageLength = $("#output").children("li").length;
    if (imageLength == 0) {
      $("#error-image").text("画像がありません");
    } else if (imageLength > 10) {
      $("#error-image").text("画像を10枚以下にして下さい");
    } else {
      $("#error-image").text("");
    }
  });
  
  
  

  $(".input-name").on("blur", function () {
    let value = $(this).val();
    if (value == "") {
      $("#error-name").text("入力してください");
      $(this).css("border-color", "red");
    } else {
      $("#error-name").text("");
      $(this).css("border-color", "rgb(204, 204, 204)");
    }
  });

  $(".input-sentences").on("blur", function () {
    let value = $(this).val();
    if (value == "") {
      $("#error-text").text("入力してください");
      $(this).css("border-color", "red");
    } else {
      $("#error-text").text("");
      $(this).css("border-color", "rgb(204, 204, 204)");
    }
  });

  function categoryError(categorySelect) {
    let value = $(categorySelect).val();
    if (value == "---") {
      $("#error-category").text("選択して下さい");
      $(categorySelect).css("border-color", "red");
    } else {
      $("#error-category").text("");
      $(categorySelect).css("border-color", "rgb(204, 204, 204)");
    }
  }

  $("#parent_category").on("blur", function () {
    categoryError("#parent_category");
  });

  $(".main_details__category").on("blur", "#child_category", function () {
    categoryError("#child_category");
  });

  $(".main_details__category").on("blur", "#grand_child_category", function () {
    categoryError("#grand_child_category");
  });

  $("#product_size_id").on("blur", function () {
    let value = $(this).val();
    if (value == "") {
      $("#error-size").text("選択して下さい");
      $(this).css("border-color", "red");
    } else {
      $("#error-size").text("");
      $(this).css("border-color", "rgb(204, 204, 204)");
    }
  });

  //状態
  $("#product_product_condition_id").on("blur", function () {
    let value = $(this).val();
    if (value == "") {
      $("#error-condition").text("選択して下さい");
      $(this).css("border-color", "red");
    } else {
      $("#error-condition").text("");
      $(this).css("border-color", "rgb(204, 204, 204)");
    }
  });

  $("#product_delivery_fee_id").on("blur", function () {
    let value = $(this).val();
    if (value == "") {
      $("#error-deliverycost").text("選択して下さい");
      $(this).css("border-color", "red");
    } else {
      $("#error-deliverycost").text("");
      $(this).css("border-color", "rgb(204, 204, 204)");
    }
  });

  $("#product_prefecture_id").on("blur", function () {
    let value = $(this).val();
    if (value == "") {
      $("#error-pref").text("選択して下さい");
      $(this).css("border-color", "red");
    } else {
      $("#error-pref").text("");
      $(this).css("border-color", "rgb(204, 204, 204)");
    }
  });

  $("#product_delivery_days_id").on("blur", function () {
    let value = $(this).val();
    if (value == "") {
      $("#error-delivery_days").text("選択して下さい");
      $(this).css("border-color", "red");
    } else {
      $("#error-delivery_days").text("");
      $(this).css("border-color", "rgb(204, 204, 204)");
    }
  });

  $("#price").on("blur", function () {
    let value = $(this).val();
    if (value < 300 || value > 9999999) {
      $("#error-price").text("入力してください");
      $(this).css("border-color", "red");
    } else {
      $("#error-price").text("");
      $(this).css("border-color", "rgb(204, 204, 204)");
    }
  });
});
