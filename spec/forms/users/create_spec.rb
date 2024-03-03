# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::CreateForm do
  let!(:params) { { age: User::AGES.first, gender: User::GENDERS.first } }

  it_behaves_like :valid_form

  it_behaves_like :invalid_form, without: :age
  it_behaves_like :invalid_form, without: :gender
  it_behaves_like :invalid_form, with: { age: 'pozhilaya_monada' }
  it_behaves_like :invalid_form, with: { gender: 'apache_helicopter' }
end
