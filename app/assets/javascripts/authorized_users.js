$(document).ready(function() {
    clickRow();

    $('table').DataTable({
        clickablerow: clickRow
    });

    function clickRow() {
        $(".clickable-row").click(function() {
            window.location = $(this).data("href");
        });
    }
} );
