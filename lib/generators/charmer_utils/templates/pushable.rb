module CharmerAdmin::Pushable
  extend ActiveSupport::Concern

  included do
    has_one :feature, as: :pushable
  end
end
