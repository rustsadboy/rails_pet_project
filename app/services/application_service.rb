# frozen_string_literal: true

class ApplicationService
  include Dry::Monads[:result, :do]
  extend Dry::Initializer
  Dry::Validation.load_extensions :monads

  class << self
    ruby2_keywords def call(*args)
      new(*args).call
    end
  end

  def validate_contract(contract, params)
    params = params.to_unsafe_h unless params.is_a?(Hash)
    result = contract.new.call(params)

    if result.success?
      Success(result.to_h)
    else
      Failure(Api::UnprocessableEntityError.new(result.errors.to_h))
    end
  end
end
