# frozen_string_literal: true

module JsonRenderable
  extend ActiveSupport::Concern

  def render_ok(status: 200)
    render json: {}, status:
  end

  def render_blueprint(entity, entity_blueprint, status: 200, options: {})
    render json: entity_blueprint.render(entity, options), status:
  end

  def render_failure(error_obj)
    render json: { errors: error_obj.error_hash }, status: error_obj.status
  end

  def render_result(result, blueprint: nil, status: 200, options: {})
    result.either(
      lambda { |success_data|
        if blueprint && success_data.present?
          render_blueprint(success_data, blueprint, status:, options:)
        else
          render_ok(status:)
        end
      },
      ->(failure_obj) { render_failure(failure_obj) }
    )
  end
end
