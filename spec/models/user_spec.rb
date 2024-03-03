# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }

  it 'raise error with given arguments: name' do
    subject.name = 'test'
    expect { subject.save! }.not_to raise_error
  end

  it 'raise error with invalid arguments: gender' do
    subject.name = 'test'
    subject.email = 'test'
    subject.password = 'lubluulitok1488'
    subject.age = 'over40'
    expect { subject.gender = 'vertolyot-shturmovik' }.to raise_error ArgumentError
  end

  it 'create successfully with given arguments: name, email, password' do
    subject.name = 'test'
    subject.email = 'test'
    subject.password = 'lubluulitok1488'
    expect { subject.save! }.not_to raise_error
  end

  it 'create successfully with given arguments: name, email, password, age, gender' do
    subject.name = 'test'
    subject.email = 'test'
    subject.password = 'lubluulitok1488'
    subject.age = 'over40'
    subject.gender = 'male'
    expect { subject.save! }.not_to raise_error
  end
end
