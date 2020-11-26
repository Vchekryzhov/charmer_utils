module CharmerUtils
  extend ActiveSupport::Concern
  require 'html_to/jsonb_admin.rb'
  require 'html_to/meta.rb'
  require 'html_to/publishable.rb'
  require 'html_to/searchkick_content_prepare.rb'
  require 'html_to/template_list.rb'
  included do
    after_commit :share_image_generate, unless: :skip_share_image_generate
    attr_accessor :skip_share_image_generate
  end

  def share_image_generate
    SharingImageGenerate.perform_async(id, self.class.to_s)
  end

end
