# frozen_string_literal: true

class ApplicationForm < Dry::Validation::Contract
  config.messages.backend = :i18n
  Dir[Rails.root.join('config', 'locales', '*.yml')].each { |f| config.messages.load_paths << f }

  include Macros::Emails::EmailFormatMacros
  include Macros::Emails::EmailUniqMacros
  include Macros::PasswordUpdateMacros
  include Macros::Audios::AudioFileMacros
end
