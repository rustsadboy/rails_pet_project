# frozen_string_literal: true

module ErrorsHandlerable
  extend ActiveSupport::Concern
  # rubocop:disable Metrics/BlockLength
  included do
    rescue_from StandardError do |e|
      render json: { errors: e.as_json }, status: 500
    end

    rescue_from Api::UnprocessableEntityError do |e|
      render json: { errors: e.error_hash }, status: :unprocessable_entity
    end

    rescue_from Api::UnauthorizedError do |e|
      render json: { errors: e.error_hash }, status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: {
               errors: {
                 title: I18n.t('api.errors.record_not_found'),
                 status: 404,
                 detail: I18n.t('api.errors.messages.record_not_exists'),
                 model_name: e.model
               }
             },
             status: 404
    end

    rescue_from Api::AccessForbiddenError do |e|
      render json: { errors: e.error_hash }, status: 403
    end

    rescue_from Api::NotAcceptableError do |e|
      render json: { errors: e.error_hash }, status: 406
    end

    rescue_from Api::ConflictError do |e|
      render json: { errors: e.error_hash }, status: 409
    end
  end
  # rubocop:enable Metrics/BlockLength
end
