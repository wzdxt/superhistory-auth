class User2 < ActiveRecord::Base
  establish_connection :visit
  self.table_name = 'users'
end
