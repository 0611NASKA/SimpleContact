class Inquiry < ApplicationRecord
  attr_accessor :email_confirmation
  belongs_to :genre

  validates :name, presence: true
  validates :body, presence: true
  validates :email, presence: true
  validates :email_confirmation, presence: true
  validate :email_format, if: -> { errors[:email].blank? }
  validate :email_match, if: -> { errors[:email_confirmation].blank? }

  def self.ransackable_associations(auth_object = nil)
    ["genre"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[company name name_kana email telephone_number body is_deleted created_at updated_at]
  end
  
  private

  def email_format
    unless email =~ URI::MailTo::EMAIL_REGEXP
      errors.add(:email, "は不正な値です")
    end
  end

  def email_match
    if email != email_confirmation
      errors.add(:email_confirmation, "とメールアドレスが一致しません")
    end
  end
end
