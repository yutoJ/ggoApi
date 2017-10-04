class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:logout]

  def facebook
    if params[:facebook_access_token]
      graph = Koala::Facebook::API.new(params[:facebook_access_token])
      user_data = graph.get_object("me?fields=name,email,id,picture")
      user = User.find_by(email: user_data['email'])
      if user
        user.generate_authentication_token
        user.save
        render json: user, status: :ok
      else
        random_password =Devise.friendly_token[0,20]
        user = User.new(
                    name: user_data['name'],
                    email: user_data['email'],
                    uid: user_data['id'],
                    provider: 'Facebook',
                    sns_image: user_data['picture']['data']['url'],
                    confirmed_at: DateTime.now,
                    password: random_password,
                    password_confirmation: random_password
                )
        user.generate_authentication_token
        if user.save
          render json: user, status: :ok
        else
          render json: { error: user.errors, is_success: false}, status: 422
        end
      end
    else
      render json: { error: "Invalid Facebook Token", is_success: false}, status: :unprocessable_entity
    end
  end

  def logout
    user = User.find_by(access_token: params[:access_token])
    user.generate_authentication_token
    user.save
    render json: { is_success: true}, status: :ok
  end

  def add_card
  end
end
