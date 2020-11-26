# == Schema Information
#
# Table name: read_relations
#
#  id           :bigint(8)        not null, primary key
#  team_role_id :bigint(8)
#  entity_id    :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#

class CharmerUtils::Ability::ReadRelation < ApplicationRecord
  belongs_to :team_role
  belongs_to :entity
end
