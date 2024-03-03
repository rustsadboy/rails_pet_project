# frozen_string_literal: true

module RecoveryPasswordsSchema
  RECOVERY_SCHEMA = {
    type: :object,
    properties: {
      id: { type: :integer, example: 1 },
      recovery_password_expired_at: { type: :integer, example: DateTime.now.to_time.to_i }
    }
  }.freeze
end
