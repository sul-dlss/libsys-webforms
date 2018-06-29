# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( accession_number_updates.js
                                                  accession_numbers.js
                                                  authorized_users.js
                                                  batch_record_updates.js
                                                  circulation_statistics_reports.js
                                                  digital_bookplates_batches.js
                                                  edi_error_reports.js
                                                  edi_invoices.js
                                                  encumbrance_reports.js
                                                  endowed_funds_reports.js
                                                  expenditure_reports.js
                                                  expenditures_with_circ_stats_reports.js
                                                  forms.js
                                                  html5_webshim.js
                                                  sal3_batch_requests.js
                                                  shelf_selection_reports.js
                                                )
