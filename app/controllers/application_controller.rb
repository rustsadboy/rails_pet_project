# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonRenderable
  include JwtAuthorizable
  include ErrorsHandlerable
  include PolicyAuthorizable
  include Localable
  require 'json_web_token'
end
