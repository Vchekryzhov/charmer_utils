class Admin < ApplicationRecord
  has_secure_password
  extend Enumerize
  belongs_to :team_role, class_name: "CharmerUtils::TeamRole"

  enumerize :timezone, in: TZInfo::Timezone.all_data_zones.map(&:name), default: 'Europe/Moscow'

  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/ }, uniqueness: true


  def super_admin?
    team_role.super_admin
  end

end
