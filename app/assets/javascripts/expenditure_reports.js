// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(document).ready(function($) {
  $('table').DataTable({
    "columns": [
      { "orderable": false },
      null,
      null,
      null,
      null,
      null
    ]
  });

  var input_checked = 'input[name="expenditure_report[fund][]"]';
  var max_funds = $("div#fundalert").attr('data-max');
  $(input_checked).click(function() {
    var checked_funds = $(input_checked + ':checked').length;
    if (checked_funds > max_funds) {
      addAlert();
    } else {
      removeAlert();
    }
  });
});

function addAlert(){
  $(".alert").addClass('in').removeClass('out');
  return false;
}

function removeAlert(){
  $(".alert").addClass('out').removeClass('in');
  return false;
}
