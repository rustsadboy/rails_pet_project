# frozen_string_literal: true

module PushNotifications
  class Test < ::ApplicationService
    param :tokens
    param :params
    option :contract, default: -> { ::TestPushNotifications::IndexForm }

    def call
      valid_params = yield validate_contract(contract, params)
      Success(send(valid_params[:notification_type], valid_params))
    end

    private

    def daily(_params)
      yield ::PushNotifications::DailyNotification.(tokens, DailyNotificationsJob::NOTIFICATION_NUMBERS)
    end

    def streak(params)
      yield ::PushNotifications::StreakNotification.(tokens, StreakNotificationsJob::NOTIFICATION_NUMBERS.sample, params[:extra_info])
    end

    def subscription(_params)
      yield ::PushNotifications::SubscriptionNotification.(tokens, SubscriptionNotificationsJob::NOTIFICATION_NUMBERS)
    end

    def achievement(params)
      yield ::PushNotifications::AchievementNotification.(tokens, params[:achievement_type], params[:extra_info])
    end

    def friends_success(params)
      friend = User.find(params[:friend_id])
      yield ::PushNotifications::FriendsSuccessNotification.(friend, tokens, params[:success_type], params[:extra_info])
    end
  end
end
