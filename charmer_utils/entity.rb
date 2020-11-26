# == Schema Information
#
# Table name: entities
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  entity     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class CharmerUtils::Entity < ApplicationRecord
    Rails.application.eager_load!
    MODELS = ApplicationRecord.descendants.map(&:name)
    extend Enumerize
    enumerize :entity, in: MODELS
end
