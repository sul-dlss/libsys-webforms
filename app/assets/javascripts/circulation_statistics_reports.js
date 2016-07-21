$(document).ready(function(){
  $('#circulation_statistics_report_range_type_lc').click(function(){
    $('.classic-call-alpha-label').hide();
    $('#classic-call-alpha-form-element').hide();
    $('.lc-call-lo-label').show();
    $('#classic-call-lo-label').hide();
    $('#lc-classic-call-lo-form-element').show();
    $('#lc-call-hi-label').show();
    $('#classic-call-hi-label').hide();
    $('#other-call-hi-label').hide();
    $('#lc-classic-other-call-hi-form-element').show();
    $('#barcodes-label').hide();
    $('#bardoces-form-element').hide();
  })
  $('#circulation_statistics_report_range_type_classic').click(function(){
    $('.classic-call-alpha-label').show();
    $('#classic-call-alpha-form-element').show();
    $('.lc-call-lo-label').hide();
    $('#classic-call-lo-label').show();
    $('#lc-classic-call-lo-form-element').show();
    $('#lc-call-hi-label').hide();
    $('#classic-call-hi-label').show();
    $('#other-call-hi-label').hide();
    $('#lc-classic-other-call-hi-form-element').show();
    $('#barcodes-label').hide();
    $('#bardoces-form-element').hide();
  })
  $('#circulation_statistics_report_range_type_other').click(function(){
    $('.classic-call-alpha-label').hide();
    $('#classic-call-alpha-form-element').hide();
    $('.lc-call-lo-label').hide();
    $('#classic-call-lo-label').hide();
    $('#lc-classic-call-lo-form-element').hide();
    $('#lc-call-hi-label').hide();
    $('#classic-call-hi-label').hide();
    $('#other-call-hi-label').show();
    $('#lc-classic-other-call-hi-form-element').show();
    $('#barcodes-label').hide();
    $('#bardoces-form-element').hide();
  })
  $('#circulation_statistics_report_range_type_barcodes').click(function(){
    $('.classic-call-alpha-label').hide();
    $('#classic-call-alpha-form-element').hide();
    $('.lc-call-lo-label').hide();
    $('#classic-call-lo-label').hide();
    $('#lc-classic-call-lo-form-element').hide();
    $('#lc-call-hi-label').hide();
    $('#classic-call-hi-label').hide();
    $('#other-call-hi-label').hide();
    $('#lc-classic-other-call-hi-form-element').hide();
    $('#barcodes-label').show();
    $('#bardoces-form-element').show();
  })
  $('#populate-home-locations').click(function() {
    $('#next-step').show();
    $('#populate-home-locations').hide();
    var selected_libs = $.map($('#circulation_statistics_report_lib_array option:selected'), function(el, i){
      return $(el).text();
    })
    $.each(selected_libs, function(index, value){
      $.ajax({
        url: '/circulation_statistics_reports/home_locations',
        cache: false,
        data: { lib: value },
        success: function(html){
          $('#' + value + 'select').append(html);
        }
      })
      $('#' + value).show();
    })
  })
  $('.btn').click(function(){
    var col1 = $('#circulation_statistics_report_col_header1').val();
    var col2 = $('#circulation_statistics_report_col_header2').val();
    var col3 = $('#circulation_statistics_report_col_header3').val();
    var col4 = $('#circulation_statistics_report_col_header4').val();
    var col5 = $('#circulation_statistics_report_col_header5').val();
    var blank_col_array = col1 + ',' + col2 + ',' + col3 + ',' + col4 + ',' + col5;
    $('#circulation_statistics_report_blank_col_array').val(blank_col_array);
    var selected_libs = $.map($('#circulation_statistics_report_lib_array option:selected'), function(el, i){
      return $(el).text();
    })
    var lib_loc_array = '';
    $.each(selected_libs, function(index, value){
      lib_loc_array += ',' + value + '|'
      $('#' + value).find(':selected').each(function(){
        lib_loc_array += $(this).html() + '|'
      })
    })
    $('#circulation_statistics_report_lib_loc_array').val(lib_loc_array);
  })
});
