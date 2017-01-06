$(document).on('ready page:load', function() {
  if (window.webshim) {
    var webShimOptions = {
      lazyCustomMessages: true,
      replaceUI: true,
      waitReady: true,
      type: 'date',
      date: {
        openOnFocus: true,
        startView: 2,
        'yearSelect': false,
		    'monthSelect': false
      }
    };

    if ($('[data-behavior="rerun-date-picker"]').length === 0) {
      webShimOptions.date.popover = {
        position: {
          my: 'center bottom',
          at: 'center top',
          collision: 'none'
        }
      };
    }

    window.webshim.setOptions('forms-ext', webShimOptions);
    window.webshim.polyfill('forms-ext');
  }
});
