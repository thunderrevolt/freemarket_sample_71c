$(function() {
  $(".category-index__box__list").on("click", function(){
    let box_id   = $(this).attr('id');
    let category = $(`.category-index__list__name[id = ${box_id}]`)
    let height   = category.offset().top
    $("html,body").animate({scrollTop: height});
  });
});