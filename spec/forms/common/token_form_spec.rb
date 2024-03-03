# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TokenForm do
  let!(:params) { { token: 'secret' } }

  it_behaves_like :valid_form

  it_behaves_like :invalid_form, without: :token
  it_behaves_like :invalid_form, with: { token: 1 }
end
