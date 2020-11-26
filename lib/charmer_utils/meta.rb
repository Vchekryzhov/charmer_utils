require 'active_support/concern'

module CharmerUtils::Meta
  extend ActiveSupport::Concern

  included do
    jsonb_accessor :meta, {
      meta_title: :string,
      meta_description: :string,
      meta_keywords: :string
    }
  end

end
