$(document).ready(function() {
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
  $('#shelf_selection_report_range_type_lc').click(function(){
    $('#classic-call-alpha-label').hide();
    $('#classic-call-alpha-form-element').hide();
    $('#lc-call-lo-label').show();
    $('#classic-call-lo-label').hide();
    $('#lc-classic-call-lo-form-element').show();
    $('#lc-call-hi-label').show();
    $('#classic-call-hi-label').hide();
    $('#other-call-hi-label').hide();
  })
  $('#shelf_selection_report_range_type_classic').click(function(){
    $('#classic-call-alpha-label').show();
    $('#classic-call-alpha-form-element').show();
    $('#lc-call-lo-label').hide();
    $('#classic-call-lo-label').show();
    $('#lc-classic-call-lo-form-element').show();
    $('#lc-call-hi-label').hide();
    $('#classic-call-hi-label').show();
    $('#other-call-hi-label').hide();
  })
  $('#shelf_selection_report_range_type_other').click(function(){
    $('#classic-call-alpha-label').hide();
    $('#classic-call-alpha-form-element').hide();
    $('#lc-call-lo-label').hide();
    $('#classic-call-lo-label').hide();
    $('#lc-classic-call-lo-form-element').hide();
    $('#lc-call-hi-label').hide();
    $('#classic-call-hi-label').hide();
    $('#other-call-hi-label').show();
  })
  $('#shelf_selection_report_search_name').change(function(){
    search_name = $('#shelf_selection_report_search_name').find(':selected').text();
    $.ajax({
      url: '/shelf_selection_reports/load_saved_options',
      cache: false,
      data: { search_name: search_name },
      success: function(html_opts) {
        $('#shelf_selection_report_lib').val($(html_opts).find('lib').text());
        $("#shelf_selection_report_loc_array option").remove();
        $.ajax({
          url: '/shelf_selection_reports/home_locations',
          cache: false,
          data: { lib: $(html_opts).find('lib').text() },
          success: function(html){
            $('#shelf_selection_report_loc_array').append(html);
            $.each($(html_opts).find('locsstring').text().split(','), function(i,e){
              $("#shelf_selection_report_loc_array option[value='" + e + "']").prop('selected', true);
            })
          }
        })
        $.each($(html_opts).find('fmtsstring').text().split(','), function(i,e){
          $("#shelf_selection_report_fmt_array option[value='" + e + "']").prop('selected', true);
        });
        $.each($(html_opts).find('itypesstring').text().split(','), function(i,e){
          $("#shelf_selection_report_itype_array option[value='" + e + "']").prop('selected', true);
        });
        $('#shelf_selection_report_icat1_array option[value="ALL"]').prop('selected', false);
        $.each($(html_opts).find('icat1sstring').text().split(','), function(i,e){
          $("#shelf_selection_report_icat1_array option[value='" + e + "']").prop('selected', true);
        });
        $('#shelf_selection_report_lang').val($(html_opts).find('lang').text());
        $('#shelf_selection_report_min_yr').val($(html_opts).find('minyr').text());
        $('#shelf_selection_report_max_yr').val($(html_opts).find('maxyr').text());
        $('#shelf_selection_report_min_circ').val($(html_opts).find('mincirc').text());
        $('#shelf_selection_report_max_circ').val($(html_opts).find('maxcirc').text());
        $('#shelf_selection_report_shadowed').val($(html_opts).find('shadowed').text());
        $('#shelf_selection_report_digisent').val($(html_opts).find('digisent').text());
        $('#shelf_selection_report_url').val($(html_opts).find('url').text());
        $('#shelf_selection_report_mhlds').val($(html_opts).find('mhlds').text());
        $('#shelf_selection_report_has_dups').val($(html_opts).find('hasdups').text());
        $('#shelf_selection_report_multvol').val($(html_opts).find('multvol').text());
        $('#shelf_selection_report_multcop').val($(html_opts).find('multcop').text());
        $('#noboundw').val($(html_opts).find('noboundw').text());
        $('#shelf_selection_report_call_lo').val($(html_opts).find('calllo').text());
        $('#shelf_selection_report_call_hi').val($(html_opts).find('callhi').text());
        $('#shelf_selection_report_subj_name').val($(html_opts).find('subjname').text());
      }
    })
  })
});
