# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Completed do
  subject { described_class.new.call(user) }

  let!(:user) { create(:user, registration_completed: status) }

  context 'completed' do
    let(:status) { true }
    it { is_expected.to be true }
  end

  context 'non-complited' do
    let(:status) { false }
    it { is_expected.to be false }
  end
end
