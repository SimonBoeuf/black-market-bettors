class StaticData < ActiveRecord::Base
  self.abstract_class = true
  def self.table_name_prefix
    'static_data_'
  end
end
