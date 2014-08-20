window.Papa = {
  submitLink: function(){
    console.log('link');
    var serialize = $("form#new-article textarea#article-body").val();
    $.post("article/create", {body: serialize});
  }
}
