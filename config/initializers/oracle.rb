# This is for the rails 4.2 version. See https://github.com/rsim/oracle-enhanced#rails-42
# When upgrading to rails 5 we can remove the deprecated self.emulate_* lines from config/initializers/oracle.rb
if Rails.env.development? || Rails.env.production?
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
      # id columns and columns which end with _id will always be converted to integers
      self.emulate_integers_by_column_name = true

      # DATE columns which include "date" in name will be converted to Date, otherwise to Time
      self.emulate_dates_by_column_name = false

      # true and false will be stored as 'Y' and 'N'
      # self.emulate_booleans_from_strings = true

      # start primary key sequences from 1 (and not 10000) and take just one next value in each session
      # self.default_sequence_start_value = "1 NOCACHE INCREMENT BY 1"

      # Use old visitor for Oracle 12c database
      # self.use_old_oracle_visitor = true

      # Initialize ruby-plsql gem here
      plsql.activerecord_class = ActiveRecord::Base
    end
  end
end
