$(document).on('ready page:load', function() {
  if (window.webshim && $('[data-behavior="rerun-date-picker"]').length > 0) {
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

    window.webshim.setOptions('forms-ext', webShimOptions);
    window.webshim.polyfill('forms-ext');
    window.webshim.activeLang('en');
  }
});
