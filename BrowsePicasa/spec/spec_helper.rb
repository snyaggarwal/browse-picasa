# -*- encoding : utf-8 -*-
ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'

SimpleCov.start do
  add_filter '/vendor/'
  add_filter '/spec/'
  add_filter '/config/'
  minimum_coverage 99
  refuse_coverage_drop
end

require File.expand_path("../../config/environment", __FILE__)
Rails.env = 'test'

require 'rspec/rails'
require 'pry'

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = "random"
end
