# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::UpdateForm do
  let(:params) do
    {
      name: 'aboba',
      email: 'snail_lover1243@gmail.com',
      old_password: 'ulitka_ulitochka_228',
      password: 'lublu_ulitok_1387',
      password_confirmation: 'lublu_ulitok_1387'
    }
  end

  it_behaves_like :valid_form
  it_behaves_like :valid_form, without: :name
  it_behaves_like :valid_form, without: :email
  it_behaves_like :valid_form, without: %i[old_password password password_confirmation]

  it_behaves_like :invalid_form, without: :password
  it_behaves_like :invalid_form, without: :password_confirmation
  it_behaves_like :invalid_form, with: { password: 'lublu_ulitok_1387', password_confirmation: 'lublu_ulitok_1488' }
  it_behaves_like :invalid_form, with: { email: '3f23f' }
end
