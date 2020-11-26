namespace :admin do
  desc "TODO"
  task create_entities: :environment do
    create_entities
  end

  def create_entities
    CharmerAdmin::Config.menu.each do |record|
      case record
      when CharmerAdmin::Config::Menu::Entity
        result = Entity.find_or_create_by(entity: record.model.to_s)&.update(title: record.title) if record.external? == false
      when CharmerAdmin::Config::Menu::Group
        record.items.each do |item|
          result = Entity.find_or_create_by(entity: item.model.to_s)&.update(title: "#{record.title} => #{item.title}")if item.external? == false
        end
      end
    end
  end

end
