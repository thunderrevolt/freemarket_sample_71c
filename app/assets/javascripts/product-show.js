// クリックした商品の写真差し替え
$(function() {
  $(document).on('click', '.sub-size', function(e) {
    var src = $(this).attr('src');
    $(".main-size").attr("src",src);
    拡大用のリンク先も書き換え
    $(".data-lightbox").attr("href",src);
  });
});