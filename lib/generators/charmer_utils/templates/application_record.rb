class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def full_url
    ENV["FRONT_HOST"] + front_object_url
  end

  def admin_url
    "#{ENV['ADMIN_HOST']}/#{region.code}/list/#{self.class.name.pluralize.underscore.gsub('/','~')}/#{id}"
  end
end
