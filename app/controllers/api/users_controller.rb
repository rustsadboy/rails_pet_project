# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    authorize_with! except: :create do
      ::Users::Completed.(current_user)
    end

    def index
      result = ::Users::Index.(params)

      result.either(
        lambda { |success_data|
          render_blueprint(
            success_data, ::Users::ProfilesBlueprint,
            options: {
              view: success_data.id == current_user.id ? :extended : :normal,
              is_followed: current_user.following?(success_data)
            }
          )
        },
        ->(failure_obj) { render_failure(failure_obj) }
      )
    end

    def create
      user = ::Users::Create.(current_user, params)

      render_result(
        user, blueprint: ::Users::ProfilesBlueprint,
              options: { view: :registered }
      )
    end

    def show
      user = User.find(params[:id])

      render_blueprint(
        user, ::Users::ProfilesBlueprint,
        options: {
          view: user.id == current_user.id ? :extended : :normal,
          is_followed: current_user.following?(user)
        }
      )
    end

    def update
      result = ::Users::Update.(current_user, params)

      render_result(result, blueprint: ::Users::ProfilesBlueprint, options: { view: :extended })
    end

    def destroy
      current_user.destroy!

      render_ok
    end

    def followings
      result = ::Relationships::Index.(params, :followings)

      result.either(
        lambda { |success_data|
          render_blueprint(
            success_data[:relation],
            ::Users::ProfilesBlueprint,
            options: {
              root: 'users',
              view: :subs,
              meta: { users_count: success_data[:relation_count] }
            }
          )
        },
        ->(failure_obj) { render_failure(failure_obj) }
      )
    end

    def followers
      result = ::Relationships::Index.(params, :followers)

      result.either(
        lambda { |success_data|
          render_blueprint(
            success_data[:relation],
            ::Users::ProfilesBlueprint,
            options: {
              root: 'users',
              view: :subs,
              meta: { users_count: success_data[:relation_count] }
            }
          )
        },
        ->(failure_obj) { render_failure(failure_obj) }
      )
    end
  end
end
