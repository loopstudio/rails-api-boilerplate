class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  nilify_blanks nullables_only: false
end
