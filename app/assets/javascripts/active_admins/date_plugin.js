

  var picker_options = {
    lang:'ch',
    format: "Y-m-d",
    closeOnDateSelect: true,
    scrollMonth: false,
    scrollTime:  false,
    scrollInput: false,
    weeks: true,
  };
  $.datetimepicker.setLocale('en');
$(function(){

  var _options = jQuery.extend({}, picker_options);
  _options.timepicker = false;
  _options.format= "Y-m-d";
  jQuery('.jquery-datepicker').datetimepicker(_options);
});

$(function(){
  var _options = jQuery.extend({}, picker_options);
  _options.timepicker = true;
  _options.format= "Y-m-d";
  jQuery('.jquery-datetimepicker').datetimepicker(_options);

});
