# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Index do
  subject { described_class.call(params) }

  let(:user) { create(:user, search_id: 1488) }

  context 'with valid params' do
    let(:params) { { search_id: user.search_id } }

    it 'finds user' do
      expect(subject.success?).to eq true
      expect(subject.value!).to eq user
    end
  end

  context 'with invalid params' do
    let(:params) { { search_id: 'sobaka' } }

    it 'fails' do
      expect(subject.failure?).to eq true
      expect(subject.failure.error_hash[:detail]).to eq I18n.t('dry_validation.errors.int?.failure')
    end
  end

  context 'with non-existent id' do
    let(:params) { { search_id: user.search_id - 228 } }

    it 'fails' do
      expect { subject }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
