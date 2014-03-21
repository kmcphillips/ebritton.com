//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  $("#col_right a:has(img)").fancybox({
    openEffect: "elastic",
    closeEffect: "elastic",
    helpers: {
      title : {
        type : 'inside'
      }
    }
  });
});
