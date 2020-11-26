require 'active_support/concern'

module CharmerUtils::Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> {
      columns = self.columns.map(&:name)
      if columns.include?('published_at') && columns.include?('published_before') && columns.include?('published')
        where(published: true)
          .where("#{self.table_name}.published_at <= ?", Time.current)
          .where("#{self.table_name}.published_before >= ?", Time.current)
          .or(
            where(published: true)
              .where("#{self.table_name}.published_at <= ?", Time.current)
              .where("#{self.table_name}.published_before IS NULL")
          )
      elsif columns.include?('published_at') && columns.include?('published')
        where(published: true).where("#{self.table_name}.published_at <= ?", Time.current)
      elsif columns.include?('published')
        where(published: true)
      end
    }

    scope :admin_published, -> (admin_user) {
      published if admin_user.nil?
    }

    before_validation :handle_published_at

    private def handle_published_at
      if published == true
        self.published_at = Time.current if self.class.columns.map(&:name).include?('published_at') && !published_at.present?
      end

    end
  end

end
