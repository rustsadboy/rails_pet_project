# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationships::IndexForm do
  let(:params) { { page: 1, limit: 1, user_id: 1 } }

  it_behaves_like :valid_form
  it_behaves_like :invalid_form, without: :user_id
  it_behaves_like :invalid_form, with: { user_id: 0 }
end
