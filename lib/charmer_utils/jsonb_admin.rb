require 'active_support/concern'

module CharmerUtils::JsonbAdmin
  extend ActiveSupport::Concern

  included do
    def self.admin_attributes(field)
      input_type = self.accessor_content[field.to_sym] == :text ? :html : self.accessor_content[field.to_sym]
      {
        input_type: input_type,
        editable: true
      }
    end
  end

end
