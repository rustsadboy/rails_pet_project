# frozen_string_literal: true

class BaseController < ActionController::Base
  include JsonRenderable
  include TemplateRenderable
  include ErrorsHandlerable
  include Localable
end
