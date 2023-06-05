# frozen_string_literal: true
# rubocop:disable all

namespace :init_db do
  desc "Initialize databases if databases aren't exist"
  task setup: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    compose_database unless databases_exists?
  end

  desc 'Reset databases'
  task reset: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    Rake::Task['db:drop'].execute if databases_exists?
    compose_database 
  end

  def compose_database
    system 'bundle exec rails db:create'
    system 'bundle exec rails db:migrate'
  end

  def databases_exists?
    ActiveRecord::Base.connection
    true
  rescue ActiveRecord::NoDatabaseError
    false
  end
end 
