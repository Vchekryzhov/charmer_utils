require 'active_support/concern'
module CharmerUtils::TemplateList
  extend ActiveSupport::Concern
  def self.all_template
    result = []
    template_files(Rails.root.join('app/templates/*'), result)
    result
  end

  def self.template_files(path, result)
    Dir[path].each do |subdir|
      if Dir.exist?(subdir)
        self.template_files(subdir + '/*', result)
      else
        result.push(File.basename(subdir, ".*").gsub('_template', '').to_sym)
      end
    end
  end
end
