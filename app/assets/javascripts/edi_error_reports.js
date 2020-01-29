// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('table').DataTable({
      "order": [[ 0, "desc" ]]
  });

  $('input#edi_errors_day').on('change', function() {
      var url = window.location.href;
      var level;
      var type;
      if (url.indexOf('?') > -1) {
          if (url.indexOf('level') > -1) {
              level = '&' + url.substr(url.indexOf('level='));
          }
          if (url.indexOf('type') > -1) {
              type = '&' + url.substr(url.indexOf('type='));
          }
          url = url.substr(0, url.indexOf('?'));
      }
      url += '?day=' + this.value;
      if (level !== undefined) {
          url += level;
      }
      if (type !== undefined) {
          url += type;
      }
      window.location.href = url;
  });

  $.webshim.polyfill('forms-ext');

  $.webshim.setOptions('forms-ext', {
    replaceUI: 'auto',
    types: 'date',
    date: {
      startView: 2,
      openOnFocus: true
    }
  });
});

