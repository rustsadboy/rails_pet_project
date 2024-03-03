# frozen_string_literal: true

module Localable
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  private

  def set_locale
    I18n.locale = request.headers['User-Locale'] || I18n.default_locale
  end
end
