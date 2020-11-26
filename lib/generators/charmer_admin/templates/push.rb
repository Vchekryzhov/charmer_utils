class Push < ApplicationRecord
  belongs_to :pushable, polymorphic: true
  after_create :send_push

  def send_push
    raise "push_worker is not presented, define it in config charmer_admin" unless CharmerAdmin::Config.push_worker_klass
    CharmerAdmin::Config.push_worker_klass.new.perform(pushable_id, pushable_type, id, ENV['RAILS_ENV'].to_sym)
  end
end
