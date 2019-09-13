if Rails.env.development? || Rails.env.production?
  if Rails.env.development?
    require 'activerecord-oracle_enhanced-adapter'
    require 'ruby-plsql'
  end
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
      # self.emulate_* methods deprecated in rails 5

      # id columns and columns which end with _id will always be converted to integers
      # self.emulate_integers_by_column_name = true

      # DATE columns which include "date" in name will be converted to Date, otherwise to Time
      # self.emulate_dates_by_column_name = false

      # true and false will be stored as 'Y' and 'N'
      # self.emulate_booleans_from_strings = true

      # start primary key sequences from 1 (and not 10000) and take just one next value in each session
      # self.default_sequence_start_value = "1 NOCACHE INCREMENT BY 1"

      # Use old visitor for Oracle 12c database
      # self.use_old_oracle_visitor = true

      # Initialize ruby-plsql gem here
      plsql.activerecord_class = ActiveRecord::Base

      # See https://github.com/rsim/oracle-enhanced/issues/1679
      NATIVE_DATABASE_TYPES = {
        primary_key: 'NUMBER(38) NOT NULL PRIMARY KEY',
        string: { name: 'VARCHAR2', limit: 255 },
        text: { name: 'CLOB' },
        ntext: { name: 'NCLOB' },
        integer: { name: 'NUMBER', limit: 38 },
        float: { name: 'BINARY_FLOAT' },
        decimal: { name: 'DECIMAL' },
        datetime: { name: 'DATE' },
        timestamp: { name: 'TIMESTAMP' },
        time: { name: 'TIMESTAMP' },
        date: { name: 'DATE' },
        binary: { name: 'BLOB' },
        boolean: { name: 'NUMBER', limit: 1 },
        raw: { name: 'RAW', limit: 2000 },
        bigint: { name: 'NUMBER', limit: 19 }
      }.freeze

      def initialize_type_map(my_map = type_map)
        super
        # oracle
        register_class_with_limit my_map, /date/i, ActiveRecord::Type::DateTime
        register_class_with_precision my_map, /TIMESTAMP/i, ActiveRecord::Timestamp
        register_class_with_limit my_map, /raw/i, ActiveRecord::OracleEnhanced::Type::Raw
        register_class_with_limit my_map, /char/i, ActiveRecord::OracleEnhanced::Type::String
        register_class_with_limit my_map, /clob/i, ActiveRecord::OracleEnhanced::Type::Text

        my_map.register_type 'NCHAR', ActiveRecord::OracleEnhanced::Type::NationalCharacterString.new
        my_map.alias_type /NVARCHAR2/i, 'NCHAR'

        my_map.register_type(/NUMBER/i) do |sql_type|
          precision = extract_precision(sql_type)
          limit = extract_limit(sql_type)
          ActiveRecord::OracleEnhanced::Type::Integer.new(precision: precision, limit: limit)
        end

        my_map.register_type /^NUMBER\(1\)/i, ActiveRecord::OracleEnhanced::Type::Boolean.new if emulate_booleans
      end
    end

    ActiveRecord::ConnectionAdapters::Quoting.class_eval do
      def self.quoted_date(value)
        if value.acts_like?(:time)
          zone_conversion_method = ActiveRecord::Base.default_timezone == :utc ? :getutc : :getlocal

          value = value.send(zone_conversion_method) if value.respond_to?(zone_conversion_method)
        end

        value.to_s(:db)
      end
    end
  end
end
