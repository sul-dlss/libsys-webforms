$(document).on('ready page:load', function () {
  $('table').tablesorter();
});

$(document).on('focus', '#dp1', function() {
    $(this).datepicker({
      minDate: 0,
      dateFormat: "dd-M-y"
    });
});

$(document).on('focus', '#dp2', function() {
    $(this).datepicker({
      minDate: 7,
      dateFormat: "dd-M-y"
    });
});
