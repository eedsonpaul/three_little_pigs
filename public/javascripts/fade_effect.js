var Header = {
 addFade : function(selector){
  $('span.fake-hover> span').css("display", "none").prependTo($(selector));
  $(selector+" a").bind("mouseenter",function(){
    $(selector+" .fake-hover").fadeIn("slow");
  });
  $(selector+" a").bind("mouseleave",function(){
    $(selector+" .fake-hover").fadeOut("slow");
    });
  }
};

$(document).ready(function() {
    $(".navi").each(function() {
        $(this).hover(function() {
            $(this).stop().animate({ opacity: 1.0 }, 500);
        },
       function() {
           $(this).stop().animate({ opacity: 0.5 }, 500);
       });
    });
});

$(document).ready(function() {
    $(".hide").each(function() {
        $(this).hover(function() {
            $(this).stop().animate({ opacity: 1.0 }, 500);
        },
       function() {
           $(this).stop().animate({ opacity: 0.0 }, 500);
       });
    });
});

$(document).ready(function(){
  $(document).ready(function () {
    $('#page_effect').fadeIn(1500);
  });

  $(function(){
    Header.addFade("#head_image");
  });

  $(function() {
    $(window).scroll(function(){
      var scrollTop = $(window).scrollTop();
      if(scrollTop != 0)
        $('#nav').stop().animate({'opacity':'0.2'},400);
      else	
        $('#nav').stop().animate({'opacity':'1'},400);
      });

      $('#nav').hover(
        function (e) {
          var scrollTop = $(window).scrollTop();
          if(scrollTop != 0){
            $('#nav').stop().animate({'opacity':'1'},400);
            }
        },

        function (e) {
          var scrollTop = $(window).scrollTop();
          if(scrollTop != 0){
            $('#nav').stop().animate({'opacity':'0.2'},400);
            }
        }
      );
  });
});

