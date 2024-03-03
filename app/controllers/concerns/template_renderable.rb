# frozen_string_literal: true

module TemplateRenderable
  extend ActiveSupport::Concern

  def render_template(result, template = 'application/index', title: 'Page')
    @title = title
    result.either(
      lambda { |success_data|
        @message = success_data
        @status = 200
      },
      lambda { |failure_obj|
        @message = failure_obj.detail
        @status = failure_obj.status
      }
    )

    render template, formats: :html, status: @status
  end
end
