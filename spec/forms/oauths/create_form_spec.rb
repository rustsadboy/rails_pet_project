# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Oauths::CreateForm do
  let(:params) { { access_token: 'asdasd', provider: UserOauth::PROVIDERS.first, email: 'test@snail.ru', name: 'Name' } }

  it_behaves_like :valid_form
  it_behaves_like :valid_form, without: %i[email name]

  it_behaves_like :invalid_form, without: %i[access_token provider]
  it_behaves_like :invalid_form, with: { access_token: 0 }
  it_behaves_like :invalid_form, with: { provider: 'wrong_provider' }
  it_behaves_like :invalid_form, with: { provider: 999 }
  it_behaves_like :invalid_form, with: { email: 999 }
  it_behaves_like :invalid_form, with: { email: 'wrong_email_format' }
  it_behaves_like :invalid_form, with: { name: 999 }
  it_behaves_like :invalid_form, with: { name: 'a' }
  it_behaves_like :invalid_form, with: { name: 'zdec bolshe 20 symbolov otvechayu' }
end
