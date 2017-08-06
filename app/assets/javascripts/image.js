$(document).on('turbolinks:load', function() {
  $('.cover-image-upload').on('change', function(e) {
    var $preview = $("#js-image-upload");
    imageupload(e, $preview);
  });

  $('.image-upload-0').on('change', function(e) {
    var $preview = $("#sub-image-upload-0");
    imageupload(e, $preview);
  });

  $('.image-upload-1').on('change', function(e) {
    var $preview = $("#sub-image-upload-1");
    imageupload(e, $preview);
  });

});

function imageupload(e, $preview) {
  var file = e.target.files[0],
      reader = new FileReader(),
      t = this;

  // 画像ファイル以外の場合は何もしない
  if(file.type.indexOf("image") < 0) {
    return false;
  }

  // ファイル読み込みが完了した際のイベント登録
  reader.onload = (function(file) {
    return function(e) {
      // 既存のプレビューを削除
      $preview.empty();
      // $previewの領域の中にロードした画像を表示するimageタグを追加
      $preview.prepend($('<img>').attr({
        src: e.target.result,
        class: "user-image",
        title: file.name
      }));
    };
  })(file);

  reader.readAsDataURL(file);
}
