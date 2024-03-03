# frozen_string_literal: true

module Db
  module_function

  def transaction(&)
    ActiveRecord::Base.transaction(&)
  end

  def preload(records, associations)
    ActiveRecord::Associations::Preloader.new(records:, associations:).call
  end
end
