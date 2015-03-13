# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require 'helpers/utilities.rb'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include Capybara::DSL
end

FactoryGirl.define do
  factory :user do
    name                  "Alex"
    email                 "aleksey.senkou@gmail.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end