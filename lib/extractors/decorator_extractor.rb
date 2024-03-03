# frozen_string_literal: true

class DecoratorExtractor < Blueprinter::PublicSendExtractor
  def extract(field_name, object, local_options, options = {})
    return options[:block].call(object.decorate, local_options) if options[:block]

    super(field_name, object.decorate, local_options, options)
  end
end
