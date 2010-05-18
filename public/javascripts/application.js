// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.fn.showHideFunc = function() {
  return $(this).click(function() {
    var $this = $(this);
    $(labelHide).each(function(index, obj){
      var $i = this;
      $($this).parents("#label_" + $i).addClass("hidden").hide('slow');

      if (($("#label_" + $i).hasClass("hidden")) == true) {
        $("#tab_" + $i).show();
        $.cookie('label_' + $i, 'hide', { expires: 7 });
        $.cookie('tab_' + $i, 'show', { expires: 7 });
      }
      
      $("#tab_" + $i).click(function() {
        $($this).parents("#label_" + $i).removeClass("hidden").show('slow');
        $("#tab_" + $i).hide();
        $.cookie('tab_' + $i, null);
        $.cookie('label_' + $i, null);
      });
    });
  });
};

jQuery.fn.showHideCookies = function() {
  return $(this).each(function(index, obj){
    var $i = this;
    var cook_label = $.cookie('label_' + $i);
    var cook_tab = $.cookie('tab_' + $i);

    if (cook_label == 'hide') {
      $('.ui-icon-circle-close').parents("#label_" + $i).addClass("hidden").hide();
    };
    if (cook_tab == 'show') {
      $("#tab_" + $i).show().click( function() {
      $('.ui-icon-circle-close').parents("#label_" + $i).removeClass("hidden").show('slow');
      $("#tab_" + $i).hide()
      $.cookie('tab_' + $i, null);
      $.cookie('label_' + $i, null);
      });
    };
  });
}
