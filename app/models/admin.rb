class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  attr_writer :login

  def login
    @login || self.number || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    puts "Login: #{login}"
    puts "Conditions: #{conditions.to_h}"
    where(conditions.to_h).where(["number = :value OR email = :value", { value: login }]).first
  end
end
