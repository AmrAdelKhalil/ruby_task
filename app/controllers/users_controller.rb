class UsersController < ApplicationController
  def index;end
  def verify_email
    respond_to do |format|
      format.json{ render json: UserServices::VerifyUserEmail.new(params[:email]).call }
    end
  end
end
