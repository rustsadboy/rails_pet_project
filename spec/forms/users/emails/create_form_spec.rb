# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Emails::CreateForm do
  let!(:params) { { email: 'bebra@mail.ru', name: 'mrBebra', password: 'supersecret' } }

  it_behaves_like :valid_form

  it_behaves_like :invalid_form, without: :email
  it_behaves_like :invalid_form, without: :name
  it_behaves_like :invalid_form, without: :password

  it_behaves_like :invalid_form, with: { email: 'da-da-ya@@mail.ru' }
  it_behaves_like :invalid_form, with: { name: 'a' }
  it_behaves_like :invalid_form, with: { password: 'short' }
end
