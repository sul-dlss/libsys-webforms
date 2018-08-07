$(document).ready(function() {
    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });

    $('table').DataTable({
        clickablerow: clickRow
    });

    function clickRow() {
        $(".clickable-row").click(function() {
            window.location = $(this).data("href");
        });
    }
} );
