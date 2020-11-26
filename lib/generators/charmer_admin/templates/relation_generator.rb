
class RelationGenerator < Rails::Generators::NamedBase
  def create_initializer_file
    create_file "db/migrate/#{ Time.now.strftime("%Y%m%d%H%M%S")}_create_#{file_name.underscore}_relations.rb", "
class Create#{file_name.camelcase}Relations < ActiveRecord::Migration[6.0]
  def change
    create_table :#{file_name.underscore}_relations do |t|
      t.references :#{file_name.underscore}
      t.references :#{file_name.underscore}able, polymorphic: true, index: true, null: false
      t.timestamps
    end
  end
end"
    create_file "app/models/#{file_name.underscore.singularize}_relation.rb", "
class #{file_name.camelcase.singularize}Relation < ApplicationRecord
  belongs_to :#{file_name.underscore}able, polymorphic: true
  belongs_to :#{file_name.underscore}
end
"
    create_file "app/models/concerns/#{file_name.underscore}able.rb", "
require 'active_support/concern'
module #{file_name.camelcase}able
  extend ActiveSupport::Concern

  included do
    has_many :#{file_name.underscore}_relations, -> {order(:id)}, as: :#{file_name.underscore}able, dependent: :destroy, inverse_of: :#{file_name.underscore}able
    has_many :#{file_name.underscore.pluralize}, through: :#{file_name.underscore}_relations

    has_one :#{file_name.underscore}_relation, as: :#{file_name.underscore}able, dependent: :destroy, inverse_of: :#{file_name.underscore}able
    has_one :#{file_name.underscore.singularize}, through: :#{file_name.underscore}_relation

    def #{file_name.camelcase.singularize}=(val)
      if val.is_a?(Integer)
        self.#{file_name.camelcase.singularize} = #{file_name.camelcase}.find(val)
      else
        super
      end
    end

    def #{file_name.camelcase.singularize}_ids=(val)
      ActiveRecord::Base.transaction do
        #{file_name.underscore}_relations.destroy_all
        super(val)
      end
    end

  end

end
"
  end
end
