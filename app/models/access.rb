class Access < ApplicationRecord
  # Authenticate by checking input against the database record
  def self.authenticate(input_password)
    record = Access.first
    record.present? && record.password == input_password
  end
end
