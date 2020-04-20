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

  var input_checked = 'input[name="encumbrance_report[fund][]"]';
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
  $('input[name="commit"]').attr("disabled", true);
  return false;
}

function removeAlert(){
  $(".alert").addClass('out').removeClass('in');
  $('input[name="commit"]').attr("disabled", false);
  return false;
}
