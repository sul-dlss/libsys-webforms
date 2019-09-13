###
#  Superclass for all app models in rails 5
###
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
