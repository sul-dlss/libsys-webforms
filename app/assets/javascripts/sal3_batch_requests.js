// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('table').DataTable();

  $.webshim.polyfill('forms-ext');

  $.webshim.setOptions('forms-ext', {
    replaceUI: 'auto',
    types: 'date',
    date: {
      startView: 2,
      openOnFocus: true
    }
  });
} );
