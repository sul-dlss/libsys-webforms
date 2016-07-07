$(document).on('ready page:load', function() {
  $('#shelf_selection_report_lib').change(function() {
    $("#shelf_selection_report_loc_array option").remove();
    lib = $('#shelf_selection_report_lib').find(':selected').text();
    $.ajax({
      url: '/shelf_selection_reports/home_locations',
      cache: false,
      data: { lib: lib },
      success: function(html){
        $('#shelf_selection_report_loc_array').append(html);
      }
    })
  })
  $('input[type="radio"]').click(function (){
    $('#lc-show-hide').css('display', ($(this).val() == 'lc') ? 'block' : 'none');
    $('#classic-show-hide').css('display', ($(this).val() == 'classic') ? 'block' : 'none');
    $('#other-show-hide').css('display', ($(this).val() == 'other') ? 'block' : 'none');
  })
});
