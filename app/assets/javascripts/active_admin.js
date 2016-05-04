//= require active_admin/base
//= require php-date-formatter/js/php-date-formatter.min
//= require datetimepicker/jquery.datetimepicker
//= require active_admins/date_plugin

//= require fancybox/lib/jquery.mousewheel-3.0.6.pack.js
//= require fancybox/source/jquery.fancybox.pack.js
//= require fancybox/source/helpers/jquery.fancybox-buttons.js
//= require fancybox/source/helpers/jquery.fancybox-thumbs.js
//= require fancybox/source/helpers/jquery.fancybox-media.js

$(document).ready(function() {
  $('select').select2({
    placeholder: "Select",
    width: '40%',

  });

  $(".fancybox-thumb").fancybox({
    loop: false,
    prevEffect  : 'none',
    nextEffect  : 'none',
    helpers : {
      title : {
        type: 'outside'
      },
      thumbs  : {
        width : 50,
        height  : 50
      }
    }
  });
});

$(".fancybox-single").fancybox({
  loop: false,
  helpers : {
    title : {
      type : 'over'
    }
  }
});
