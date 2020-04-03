$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 親リストのリセット
  function chidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `
                        <select class="exhibit-category-select" id="categories_list_id" name="category">
                          <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          </select>`;
    $('#category-reset-js').append(childSelectHtml);
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='exhibit-select-wrapper__added' id= 'children_wrapper'>
                        <div class='exhibit-select-wrapper__box'>
                          <select class="exhibit-select-wrapper__box--select" id="child_categories" name="category_id">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.exhibit-detail-categories').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='exhibit-select-wrapper__added' id= 'grandchildren_wrapper'>
                              <div class='exhibit-select-wrapper__box'>
                                <select class="exhibit-select-wrapper__box--select" id="grandchild_categories" name="category_id">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.exhibit-detail-categories').append(grandchildSelectHtml);
  }

  // 親カテゴリー選択後のイベント
  $('#parent_categories').on('click', function(){
    var parentCategory = document.getElementById('parent_categories').value;
    $.ajax({
        url: '/products/category_list',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
    .done(function(roots){
      $('#parent_categories').remove();
      var insertHTML = '';
      roots.forEach(function(root){
        insertHTML += appendOption(root);
      });
      chidrenBox(insertHTML);
    })
  });

  $('.exhibit-detail-categories').on('change', '#categories_list_id', function(){
    var categoryId = $('#categories_list_id option:selected').data('category');
    if (categoryId != "---"){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_id: categoryId },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.exhibit-detail-categories').on('change', '#child_categories', function(){
    var childId = $('#child_categories option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除する
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });

// --------------------画像プレビューの表示------------------------

if(document.URL.match(/product/&&/edit/)){

  var price = ($('#exhibit-price').val())
  // Math.floorで小数点以下切り捨て
  $('#tax-price').text(Math.floor( price * 0.1));
  $('#profit-price').text(price - (Math.floor(price * 0.1)));

  let image_count = $('.image_box').length
  $('#image-box__container').attr('class', `item-num-${image_count}`)
  if(image_count >= 10 ){
    $('#image-box__container').css({'display': `none`})
  }

  // 画像データをインプットするボタンと削除ボタンを追加する
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file hidden" type="file"
                    name="product[images_attributes][${num}][image]"
                    id="product_images_attributes_${num}_image"><br>
                    <div data-index="${num}" class="js-remove hidden">削除(${num})</div>
                  </div>`;
    return html;
  }
  // プレビュー用の画像を表示する
  const buildImg = (index, url)=> {
    const html = `<div class="image_box">
                    <img data-index="${index}" src="${url}" width="114px" height="80px">
                    <div class="js_remove__btn" data-index="${index}">削除</div>
                  </div>`;
    return html;
  }

  // 画像に連番をつけるためのメソッド
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われた番号を削除し末尾に１１以降の数字を追加
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  // 要素を非表示にする
  $('.hidden-destroy').hide();

  // jsファイルの画像が変更された時にメソッドが発火する
  $(document).on('change', '.js-file', function(e) {
    // jsファイルの親要素のインデックス番号を取得
    const targetIndex = $(this).parent().data('index');

    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // もし押されたjsファイル要素に既に画像が入っている場合
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {

      // 画像を新しく選択したものに更新する
      img.setAttribute('image', blobUrl);

    } else {  // 押されたjsファイル要素に画像が入っていない場合

      // #image-box__containerの前に画像表示要素を追加
      $('#image-box__container').before(buildImg(targetIndex, blobUrl));

      // image-boxに画像データインプットボタンと削除ボタンを追加する
      $('#image-box').append(buildFileField(fileIndex[0]));

      // fileindexの若番号を削除し末尾に11以降の数字を追加する
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);

      // 10個目の画像が投稿された時、画像投稿ボタンを非表示にする
      let count = $('.image_box').length
      $('#image-box__container').attr('class', `item-num-${count}`)
      if(count >= 10 ){
        $('#image-box__container').css({
          'display': `none`
        })
      }
      // 投稿された時、画像の削除ボタンを表示する
      $('.js_remove__btn').css({
        'display': `block`
      })
    }
  });

  // もし削除ボタンが押された場合
    $('#image-box').on('click', '.js-remove', function() {

      // 押された削除ボタンの親要素のインデックス番号を取得
      const targetIndex = $(this).parent().data('index');

      //↑の番号を含むインプット要素のチェックボックスを取得
      const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);

      // もしチェックボックスが存在すればチェックを入れる
      if (hiddenCheck) hiddenCheck.prop('checked', true);

      // 親要素もろともインプット要素と削除ボタンを取り除く
      $(this).parent().remove();

      // プレビュー表示画像を削除する
      $(`img[data-index="${targetIndex}"]`).parent().remove();

    let image_count = $('.image_box').length
    $('#image-box__container').attr('class', `item-num-${image_count}`)

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));

      // 10個目の画像が削除された時画像投稿ボタンを表示する
      let count = $('.image_box').length
      if(count <= 9 ){
        $('#image-box__container').css({
          'display': `flex`
        })
      }
    });

    // グレーのエリアがクリックされた時最後のフォームに画像を投稿する
    $('#image-box').on('click', '#image-box__container', function(){
      $('.js-file:last').click();
      return false;
    });

    // 画像したの削除ボタンが押された時隠された削除ボタンを押す
    $(document).on('click', '.js_remove__btn', function(){
      let remove_index = $(this).data('index');
      $(`.js-remove[data-index="${remove_index}"]`).click();
      // 「画像が一枚なら削除ボタン」を消す
      if($('.js-file').length <= 2){
        $('.js_remove__btn').css({
          'display': `none`
        })
      }
    });
    // 「画面を読み込んだ時に画像が一枚なら削除ボタン」を消す
    if($('.js-file').length <= 2){
      $('.js_remove__btn').css({
        'display': `none`
      })
    }
  };
});

// 商品説明文の文字数カウント

if(document.URL.match(/product/&&/edit/)){
  var text_max = 1000; // 最大入力値
  $(".exhibit-text").on("keydown keyup keypress change",function(){
    $(".exhibit-text__length").text(text_max - $(".exhibit-text").val().length);
    var text_length = $(this).val().length;
    var countdown = text_max - text_length;
    $(".exhibit-text__length").text(countdown);
    // CSS
    if(countdown < 0){
      $('.exhibit-text__length').css({
        color:'#ff0000',
        fontWeight:'bold'
      });
    } else {
      $('.exhibit-text__length').css({
          color:'#000000',
          fontWeight:'normal'
      });
    };
  });
};

