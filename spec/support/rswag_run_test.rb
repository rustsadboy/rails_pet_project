# frozen_string_literal: true

require 'rswag/specs/example_group_helpers'

module Rswag::Specs::ExampleGroupHelpers
  alias_method :run_test_orig!, :run_test!

  def run_test!(vcr: nil, &block)
    if vcr
      around do |example|
        VCR.use_cassette(vcr, record: :once) do
          example.run
        end
      end
    end

    run_test_orig!(&block)
  end
end
