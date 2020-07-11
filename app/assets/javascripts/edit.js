$(window).on("turbolinks:load", function() {
  var dropzone = $(".item__img__dropzone__input");
  var dropzone2 = $(".item__img__dropzone2__input2");
  var appendzone = $(".item__img__dropzone2")
  var input_area = $(".input-area");
  var preview = $("#preview");
  var preview2 = $("#preview2");

  // 登録済画像と新規追加画像を全て格納する配列（ビュー用）
  var images = [];
  // 登録済画像データだけの配列（DB用）
  var registered_images_ids =[]
  // 新規追加画像データだけの配列（DB用）
  var new_image_files = [];


  // 登録済画像のプレビュー表示
  gon.item_images.forEach(function(image, index){
    var img = $(`<div class= "add_img"><div class="img_area"><img class="image"></div></div>`);

    // カスタムデータ属性を付与
    img.data("image", index)

    var btn_wrapper = $('<div class="btn_wrapper"><a class="btn_edit">編集</a><a class="btn_delete">削除</a></div>');

    // 画像に編集・削除ボタンをつける
    img.append(btn_wrapper);

    binary_data = gon.item_images_binary_datas[index]

    // 表示するビューにバイナリーデータを付与
    img.find("img").attr({
      src: "data:image/jpeg;base64," + binary_data
    });

    // 登録済画像のビューをimagesに格納
    images.push(img)
    registered_images_ids.push(image.id)
  })

  // 画像が４枚以下のとき
  if (images.length <= 4) {
    $('#preview').empty();
    $.each(images, function(index, image) {
      image.data('image', index);
      preview.append(image);
    })
    dropzone.css({
      'width': `calc(100% - (20% * ${images.length}))`
    })

    // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
  } else if (images.length == 5) {
    $("#preview").empty();
    $.each(images, function(index, image) {
      image.data("image", index);
      preview.append(image);