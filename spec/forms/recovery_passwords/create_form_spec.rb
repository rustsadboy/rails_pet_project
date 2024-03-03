# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecoveryPasswords::CreateForm do
  let(:params) { { email: 'bebra@mail.ru' } }

  it_behaves_like :valid_form
  it_behaves_like :invalid_form, without: :email
  it_behaves_like :invalid_form, with: { email: 'no_batches?' }
end
