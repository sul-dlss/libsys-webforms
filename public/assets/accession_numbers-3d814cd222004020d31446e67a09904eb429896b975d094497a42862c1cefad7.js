// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(document).ready(function($) {
    jQuery.extend( jQuery.fn.dataTableExt.oSort, {
        "non-empty-string-asc": function (str1, str2) {
            if(str1 === "")
                return 1;
            if(str2 === "")
                return -1;
            return ((str1 < str2) ? -1 : ((str1 > str2) ? 1 : 0));
        },
        "non-empty-string-desc": function (str1, str2) {
            if(str1 === "")
                return 1;
            if(str2 === "")
                return -1;
            return ((str1 < str2) ? 1 : ((str1 > str2) ? -1 : 0));
        }
    } );

    $('table').DataTable({
        columnDefs: [
            {type: 'non-empty-string', targets: 0} // define 'name' column as non-empty-string type
        ]
    });
});
