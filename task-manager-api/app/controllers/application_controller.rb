class ApplicationController < ActionController::API
    before_action :authenticate_user!

    def authenticate_user!
        token = request.headers["Authorization"]&.split(" ")&.last
        decoded = JwtService.decode(token)
        @current_user = User.find_by(id: decoded&.[]("user_id"))
        render json: {error: "Unauthorized"}, status: :unauthorized unless @current_user
    end
end
