$(document).ready(function() {
    clickRow();

    $('table').DataTable({
        clickablerow: clickRow,
        scrollX: true
    });

    function clickRow() {
        $(".clickable-row").click(function() {
            window.location = $(this).data("href");
        });
    }
} );
