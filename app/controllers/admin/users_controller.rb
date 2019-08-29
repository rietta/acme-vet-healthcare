module Admin
  class UsersController < ActionController::Base
    respond_to :json

    def index
      render(json: User.all)
    end

    def show
      @user = User.find params[:id]
      render json: @user
    end
  end
end