#ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :update, :destroy, to: :cud

    if user.present?

      can :crud, :all


      cannot_from_menu if !user.super_admin?
      if user.team_role.present?
        user.team_role.crud_entities.each do |entity|
          begin
            can(:crud, entity.entity.constantize)
          rescue
          end
        end

        user.team_role.read_entities.each do |entity|
          begin
            can(:read, entity.entity.constantize)
          rescue
          end
        end

        user.team_role.create_entities.each do |entity|
          begin
            can(:create, entity.entity.constantize)
          rescue
          end
        end

        user.team_role.update_entities.each do |entity|
          begin
            can(:update, entity.entity.constantize)
          rescue
          end
        end

        user.team_role.delete_entities.each do |entity|
          begin
            can(:destroy, entity.entity.constantize)
          rescue
          end
        end

      end
    end
  end

  def cannot_from_menu
    CharmerAdmin::Config.menu.each do |record|
      case record
      when CharmerAdmin::Config::Menu::Entity
        cannot(:cud, record.model) if record.external? == false
      when CharmerAdmin::Config::Menu::Group
        record.items.each do |item|
          cannot(:cud, item.model) if item.external? == false
        end
      end
    end
  end

end
