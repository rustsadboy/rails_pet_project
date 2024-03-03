# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::IndexForm do
  let(:params) { { search_id: 2 } }

  it_behaves_like :valid_form

  it_behaves_like :invalid_form, without: :search_id
  it_behaves_like :invalid_form, with: { search_id: 0 }
  it_behaves_like :invalid_form, with: { search_id: 'sobaka' }
end
