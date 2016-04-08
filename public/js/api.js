$(function(){
  console.log($("#api-form"));
  $("#api-form").submit(function(event){
    console.log('送信');
    event.preventDefault();
    var form = $(this);
    var comment = $("#comment");
    var text = comment.val();
    console.log(text);
    var btn = $("#btn");
    if(text.length<=70){
      $.ajax({
        type:'GET',
        url: '/api'+'?comment='+text,
        dataType: 'json',
        timeout: 10000,
        beforeSend: function(xhr,settings){
          btn.attr('disabled',true);
          $("#category").text('処理中です...');
            $("#evaluation").text('');
        },
        complete: function(xhr,settings){
          btn.attr('disabled',false);
        },
        success: function(json){
          comment.val('');
          if(json['status']=='OK'){
            console.log(json['categoty']);
            $("#category").text(json['category'][0]);
            $("#evaluation").text(json['rate']);
            console.log('OK');
          }else{
            console.log('error');
          $("#category").text('エラー');
          $("#evaluation").text('');
          }
        },
        error: function(){
          $("#category").text('エラー');
          $("#evaluation").text('');
        }
      })
    }else{
      //エラー処理
    }
  })
})
