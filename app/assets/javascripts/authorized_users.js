$(document).ready(function() {
    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });

    $('table').DataTable({
        $(".clickable-row").click(function() {
            window.location = $(this).data("href");
        });
    });
} );
