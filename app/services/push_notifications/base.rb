# frozen_string_literal: true

module PushNotifications
  class Base < ::ApplicationService
    def notificator
      @notificator ||= FCM.new(ENV.fetch('FCM_SERVER_KEY', nil))
    end

    def build_payload(body:, data:, title: 'Hello')
      {
        notification: {
          title:,
          body:
        },
        data:
      }
    end
  end
end
