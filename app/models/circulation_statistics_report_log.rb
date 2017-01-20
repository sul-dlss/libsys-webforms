# app/models/circulation_statistics_report_log.rb
class CirculationStatisticsReportLog < ActiveRecord::Base
  self.table_name = 'circ_stats_rpt_log'

  def self.save_stats(circ_stats)
    complete_params = other_params(circ_stats).merge process_range_type_params(circ_stats)
    complete_params.merge! CirculationStatisticsReportLog.build_output_type(circ_stats)
    if circ_stats.barcodes
      FileUtils.chmod 0o664, circ_stats.barcodes.tempfile.path
      symphony_location = '/symphony/Dataload/Uploads/CircStats/'
      user = circ_stats.email.split('@')[0]
      file_path = "#{symphony_location}#{user}_#{circ_stats.barcodes.original_filename}"
      FileUtils.mv circ_stats.barcodes.tempfile.path, file_path
    end
    CirculationStatisticsReportLog.create(complete_params)
  end

  def self.other_params(circ_stats)
    { email: circ_stats.email, selcall_src: circ_stats.source,
      format: circ_stats.format_array.reject! { |a| a == '' || a == 'All Formats' }.join(','),
      exclude_inactive: circ_stats.exclude_inactive,
      exclude_bad_year: circ_stats.exclude_bad_yr, summary_only: circ_stats.no_qtrly,
      ckey_url: circ_stats.ckey_url, extras_url: circ_stats.tags_url,
      include_inhouse: circ_stats.include_inhouse, min_pub_year: circ_stats.min_yr,
      max_pub_year: circ_stats.max_yr, extra_field: circ_stats.tag_field,
      extra_field2: circ_stats.tag_field2, link_type: circ_stats.link_type,
      blank_columns: String(circ_stats.blank_col_array).split(',').join(','),
      status: 'SAVED' }
  end

  # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength
  def self.process_range_type_params(circ_stats)
    range_type_params = {}
    case circ_stats.range_type
    when 'barcodes'
      range_type_params['call_range'] = "Any call (Selection is barcode list #{circ_stats.barcodes.original_filename})"
      range_type_params['input_path'] = "/symphony/Dataload/Uploads/CircStats/#{circ_stats.barcodes.original_filename}"
      range_type_params['libs_locs'] = 'Any lib-loc'
    when 'lc'
      if circ_stats.call_lo.include?('#')
        range_type_params['call_range'] = "#{circ_stats.call_lo[0]}0-9999"
      elsif circ_stats.call_hi.blank?
        range_type_params['call_range'] = circ_stats.call_lo
      else
        range_type_params['call_range'] = "#{circ_stats.call_lo}-#{circ_stats.call_hi}"
      end
      range_type_params['libs_locs'] = circ_stats.lib_loc_array
    when 'classic'
      if circ_stats.call_alpha.blank?
        range_type_params['call_range'] = "#{circ_stats.call_lo}-#{circ_stats.call_hi}"
      else
        range_type_params['call_range'] = "#{circ_stats.call_alpha}#{circ_stats.call_lo}-#{circ_stats.call_hi}"
      end
      range_type_params['libs_locs'] = circ_stats.lib_loc_array
    when 'other'
      range_type_params['call_range'] = if circ_stats.call_hi.blank?
                                          'NOT LC/DEWEY'
                                        else
                                          "NOT LC/DEWEY: #{circ_stats.call_hi}"
                                        end
      range_type_params['libs_locs'] = circ_stats.lib_loc_array
    end
    range_type_params
  end
  # rubocop:enable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength

  def self.build_output_type(circ_stats)
    if circ_stats.range_type == 'barcodes'
      file_basename = File.basename(circ_stats.barcodes.original_filename, '.*')
      { output_name: "#{file_basename}#{Time.zone.now.strftime('%y%m%d%H%M%S')}" }
    else
      { output_name: "circ_rpt#{Time.zone.now.strftime('%y%m%d%H%M%S')}" }
    end
  end
end
