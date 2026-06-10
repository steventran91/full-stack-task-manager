class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:register, :login]
  def register

    new_user = User.new(user_params)
    if new_user.save
      token = JwtService.encode({user_id: new_user.id})
      render json: {token: token, user: new_user}, status: :created
    else
      render json: {errors: new_user.errors.full_messages}, status: :unprocessable_entity

    end

  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JwtService.encode({user_id: user.id})
      render json: {token: token, user: user}, status: :ok
    else
      render json: {error: "Invalid email or password"}, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
