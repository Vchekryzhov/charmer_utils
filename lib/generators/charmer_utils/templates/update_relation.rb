# == Schema Information
#
# Table name: update_relations
#
#  id           :bigint(8)        not null, primary key
#  entity_id    :bigint(8)
#  team_role_id :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#

class Ability::UpdateRelation < ApplicationRecord
  belongs_to :team_role
  belongs_to :entity
end
