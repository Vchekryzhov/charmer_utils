require 'active_support/concern'

module CharmerUtils::SearchkickContentPrepare
  extend ActiveSupport::Concern

  included do
    def content_prepare(str)
        content = remove_html_tags(str)
        contents = Array.new(5, '')
        inner_index = 0
        content_index = 0
        content.split('').each_with_index do |character, _index|
          contents[content_index] += character
          inner_index += 1
          next unless inner_index > 17_000 && character == ' '

          inner_index = 0
          content_index += 1
          contents[content_index] ||= ''
        end

        if contents.length > 5
          Rails.logger.error("#{self.class} - #{id} Content Length = #{content.length}")
          contents.map! { |con| con.truncate(17_000) }
        end
        contents
    end
    def remove_html_tags(text)
      text = text.nil? ? '' : text
      ActionController::Base.helpers.strip_tags(text.gsub('<br>', ' ')
                                                      .gsub('<p>', ' ')
                                                      .gsub('</p>', ' ')
                                                      .gsub('  ', ' ')
                                                      .strip)
    end
  end

end
