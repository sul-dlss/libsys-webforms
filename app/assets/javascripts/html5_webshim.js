$(document).on('ready page:load', function() {
  if (window.webshim) {
    var webShimOptions = {
      lazyCustomMessages: true,
      replaceUI: true,
      waitReady: true,
      type: 'date',
      date: {
        startView: 2,
        'yearSelect': false,
		    'monthSelect': false,
        openOnFocus: true
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

    window.webshim.activeLang('en-US');
    window.webshim.polyfill('forms-ext');
  }
});
