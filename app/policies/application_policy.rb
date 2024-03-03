# frozen_string_literal: true

class ApplicationPolicy
  class << self
    ruby2_keywords def call(*args)
      new.call(*args)
    end
  end
end
