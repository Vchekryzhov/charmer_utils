# == Schema Information
#
# Table name: team_roles
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class TeamRole < ApplicationRecord

  has_many :admins, dependent: :restrict_with_error

  extend Enumerize

  has_many :ability_crud_relations, class_name: 'CharmerUtils::Ability::CrudRelation', dependent: :destroy
  has_many :crud_entities, through: :ability_crud_relations, source: :entity

  has_many :ability_read_relations, class_name: 'CharmerUtils::Ability::ReadRelation', dependent: :destroy
  has_many :read_entities, through: :ability_read_relations, source: :entity

  has_many :ability_create_relations, class_name: 'CharmerUtils::Ability::CreateRelation', dependent: :destroy
  has_many :create_entities, through: :ability_create_relations, source: :entity

  has_many :ability_update_relations, class_name: 'CharmerUtils::Ability::UpdateRelation', dependent: :destroy
  has_many :update_entities, through: :ability_update_relations, source: :entity

  has_many :ability_delete_relations, class_name: 'CharmerUtils::Ability::DeleteRelation', dependent: :destroy
  has_many :delete_entities, through: :ability_delete_relations, source: :entity

end
