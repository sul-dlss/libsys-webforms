$(document).ready(function() {
    $('table').DataTable();

    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });
} );
