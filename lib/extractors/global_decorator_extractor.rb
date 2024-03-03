# frozen_string_literal: true

class GlobalDecoratorExtractor < Blueprinter::AutoExtractor
  def initialize
    super
    @decorator_extractor = ::DecoratorExtractor.new
  end

  def extractor(object, options)
    if object.try(:decorator_class?)
      @decorator_extractor
    else
      super
    end
  end
end
