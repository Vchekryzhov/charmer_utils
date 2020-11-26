class CreateAdminAbilities < ActiveRecord::Migration[5.1]
  def change
    create_table :entities do |t|
      t.string :title
      t.string :entity
      t.timestamps
      t.datetime :deleted_at
    end

    create_table :read_relations do |t|
      t.references :team_role
      t.references :entity
      t.timestamps
      t.datetime :deleted_at
    end

    create_table :create_relations do |t|
      t.references :entity
      t.references :team_role
      t.timestamps
      t.datetime :deleted_at
    end

    create_table :update_relations do |t|
      t.references :entity
      t.references :team_role
      t.timestamps
      t.datetime :deleted_at
    end

    create_table :delete_relations do |t|
      t.references :entity
      t.references :team_role
      t.timestamps
      t.datetime :deleted_at
    end

    create_table :crud_relations do |t|
      t.references :entity
      t.references :team_role
      t.timestamps
      t.datetime :deleted_at
    end

    create_table :team_roles do |t|
      t.string :title
      t.boolean "super_admin", default: false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
