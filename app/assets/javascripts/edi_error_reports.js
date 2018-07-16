// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(document).ready(function($) {
    jQuery.extend( jQuery.fn.dataTableExt.oSort, {
        "date-uk-pre": function ( a ) {
            var ukDatea = a.split('/');
            var yearWithoutTime = ukDatea[2].split(' ')[0];
            return (yearWithoutTime + ukDatea[1] + ukDatea[0]) * 1;
        },
        "date-uk-asc": function ( a, b ) {
            console.log("asc");
            return ((a < b) ? -1 : ((a > b) ? 1 : 0));
        },
        "date-uk-desc": function ( a, b ) {
            console.log("desc");
            return ((a < b) ? 1 : ((a > b) ? -1 : 0));
        }
    } );

    $('table').DataTable({
        "order": [[ 0, "desc" ]],
        columnDefs: [
            { type: 'date-uk', targets: 0 } // define 'run' column as date
        ]
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
    })
});

