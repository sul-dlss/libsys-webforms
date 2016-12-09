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
  $('#shelf_selection_report_searchName').change(function(){
    /* don't show delete link for another user's search if searchName is the same */
    searchName = $('#shelf_selection_report_searchName').find(':selected').text();
    user = searchName.substr(searchName.indexOf(',')).substr(2);
    searchNameParam = searchName.substr(0, searchName.indexOf(','));
    searchId = searchName.substr(0, searchName.indexOf(',')).replace(/\s/g, '_') + user;
    currentUser = $('#shelf_selection_report_email').val().split('@')[0];
    $('#' + searchId).show();
    $('#' + searchId).click(function(){
      $.ajax({
        url: '/shelf_sel_searches/delete_saved_search',
        type: 'GET',
        data: { user: user, searchName: searchNameParam },
        cache: false,
        success: function(result) {
          $('#' + searchId).remove();
          $('#shelf_selection_report_searchName option[value="' + searchName + '"]').remove();
          location.reload();
        }
      })
    });
    $.ajax({
      url: '/shelf_selection_reports/load_saved_options',
      cache: false,
      data: { searchName: searchName },
      success: function(htmlOpts) {
        $('#shelf_selection_report_lib').val($(htmlOpts).find('lib').text());
        $("#shelf_selection_report_loc_array option").remove();
        $.ajax({
          url: '/shelf_selection_reports/home_locations',
          cache: false,
          data: { lib: $(htmlOpts).find('lib').text() },
          success: function(html){
            $('#shelf_selection_report_loc_array').append(html);
            $.each($(htmlOpts).find('locsstring').text().split(','), function(i,e){
              $("#shelf_selection_report_loc_array option[value='" + e + "']").prop('selected', true);
            })
          }
        })
        $.each($(htmlOpts).find('fmtsstring').text().split(','), function(i,e){
          $("#shelf_selection_report_fmt_array option[value='" + e + "']").prop('selected', true);
        });
        $.each($(htmlOpts).find('itypesstring').text().split(','), function(i,e){
          $("#shelf_selection_report_itype_array option[value='" + e + "']").prop('selected', true);
        });
        $('#shelf_selection_report_icat1_array' +
          'option[value="All Item Category 1s"]').prop('selected', false);
        $.each($(htmlOpts).find('icat1sstring').text().split(','), function(i,e){
          $("#shelf_selection_report_icat1_array option[value='" + e + "']").prop('selected', true);
        });
        $('#shelf_selection_report_lang').val($(htmlOpts).find('lang').text());
        $('#shelf_selection_report_min_yr').val($(htmlOpts).find('minyr').text());
        $('#shelf_selection_report_max_yr').val($(htmlOpts).find('maxyr').text());
        $('#shelf_selection_report_min_circ').val($(htmlOpts).find('mincirc').text());
        $('#shelf_selection_report_max_circ').val($(htmlOpts).find('maxcirc').text());
        $('#shelf_selection_report_shadowed').val($(htmlOpts).find('shadowed').text());
        $('#shelf_selection_report_digisent').val($(htmlOpts).find('digisent').text());
        $('#shelf_selection_report_url').val($(htmlOpts).find('url').text());
        $('#shelf_selection_report_mhlds').val($(htmlOpts).find('mhlds').text());
        $('#shelf_selection_report_has_dups').val($(htmlOpts).find('hasdups').text());
        $('#shelf_selection_report_multvol').val($(htmlOpts).find('multvol').text());
        $('#shelf_selection_report_multcop').val($(htmlOpts).find('multcop').text());
        $('#noboundw').val($(htmlOpts).find('noboundw').text());
        $('#shelf_selection_report_call_lo').val($(htmlOpts).find('calllo').text());
        $('#shelf_selection_report_call_hi').val($(htmlOpts).find('callhi').text());
        $('#shelf_selection_report_subj_name').val($(htmlOpts).find('subjname').text());
        if (user == currentUser) {
          $('#shelf_selection_report_save_opt_save').val('update');
        }
      }
    })
  })
});
