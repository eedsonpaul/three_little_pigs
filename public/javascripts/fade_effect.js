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
        },function() {
         $(this).stop().animate({ opacity: 0.0 }, 500);
       });
    });
});

$(document).ready(function(){
  $(function () {
    $('#page_effect').fadeIn(1500);
  });
  
  var icon;
  $(".hover").hover(function () {
    $(this).addClass("hilite");
    icon = $(this);
    $(this).children(".storyDetailIcon").show().hover(function() {
      if (icon.offset().left + icon.width() + icon.parent().outerWidth() > window.outerWidth) {
        $(this).siblings(".story_card").addClass('left').offset({left: (icon.offset().left - icon.parent().outerWidth()), top: icon.offset().top }).show();
      } else {
        $(this).siblings(".story_card").addClass('right').offset({left: (icon.offset().left + icon.outerWidth()), top: icon.offset().top }).show();
        }  
      }, function () {
        $(this).siblings(".story_card").hover(function() {
          $(this).show();
          }, function () {
            $(this).hide();
            });
          });
  }, function () {
    $(this).removeClass("hilite");
    $(this).children(".storyDetailIcon").hide();
    $(this).children(".story_card").hide();
  });

  $(function(){
    Header.addFade("#head_image");
  });

  $(function() {
    $(window).scroll(function(){
      var scrollTop = $(window).scrollTop();
      if(scrollTop != 0)
        $('#head-board').stop().animate({'opacity':'0.2'},400);
      else	
        $('#head-board').stop().animate({'opacity':'1'},400);
      });
      $('#hear-board').hover(
        function (e) {
          var scrollTop = $(window).scrollTop();
          if(scrollTop != 0){
            $('#head-board').stop().animate({'opacity':'1'},400);
            }
        }, function (e) {
          var scrollTop = $(window).scrollTop();
          if(scrollTop != 0){
            $('#head-board').stop().animate({'opacity':'0.2'},400);
          }
        });
    });
});

