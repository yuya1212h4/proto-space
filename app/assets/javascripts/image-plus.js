$(document).on('turbolinks:load', function(){
  $(document).on('click', '.image-upload-plus', function(e) {
    var list_count = $('.list-group-item').length;

    if (list_count <= 3) {
      $('#add-form').append(buildhtmlform(list_count));
      $('#remove-form').remove();
    };
    if (list_count <= 2){
      $('#add-form').append(buildhtmluploadplus());
    };
    list_count++;
  });
});

function buildhtmlform(i) {
  html = `
    <li class = 'list-group-item col-md-4' style ='display: list-item;' data-image-id=${i}>
        <div class = 'image-upload image-upload-${i}'>
          <div id = "sub-image-upload-${i}"></div>
            <input type = 'file' name = "prototype[prototype_images_attributes][${i}][image]" id = "prototype_prototype_images_attributes_${i}_image" />
            <input value = 'sub' type = 'hidden' name = "prototype[prototype_images_attributes][${i}][image_type]" id = "prototype_prototype_images_attributes_${i}_image_type" />
        </div>
    </li>
  `
  return html;
}

function buildhtmluploadplus() {
  html =`
    <li class = 'list-group-item col-md-4' id ='remove-form'>
      <div class = "image-upload-plus">
        <span>+</span>
      </div>
    </li>
  `
  return html;
}
