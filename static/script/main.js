window.Papa = {
    articleMoreLock: false,
    articleLoad: function(){
      var _present = window.Papa;
      _present.articleMoreLock = true;
      var lastArticleId = $(".article:last").data("article-id");
      $.get("/article/more", {last_article_id: lastArticleId}, function(data){
          if (data.status){
            $(".articles").append(data.articles);
            _present.articleMoreLock = false;
          }
      });
    },
    // //距离底部的距离
    bottomDistance: function(){
      return $(document).height() - $(window).height() - $(document).scrollTop();
    },
    loadArticleLoad: function(){
      var _present = window.Papa;
      if (_present.bottomDistance() < 40 && !_present.articleMoreLock){
        _present.articleLoad();
      }
    }
}
