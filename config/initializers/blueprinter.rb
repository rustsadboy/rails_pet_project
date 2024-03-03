# frozen_string_literal: true

require 'global_decorator_extractor'

Blueprinter.configure do |config|
  config.extractor_default = GlobalDecoratorExtractor
  config.datetime_format = ->(datetime) { datetime.nil? ? datetime : datetime.strftime('%s').to_i }
end
