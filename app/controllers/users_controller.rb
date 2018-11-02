class UsersController < ApplicationController
  MAX_NUMBER_OF_VERIFY_REQUESTS = 5
  before_action :exceeded_verifying_requests, only: [:verify_email]
  def index;end
  def verify_email
    result = UserServices::VerifyUserEmail.new(params[:email]).call
    respond_to do |format|
      format.json{render json: result, status: result['error'] ? :not_found : :ok}
    end
  end

  private
  def exceeded_verifying_requests
    params[:number_of_attempts] && (params[:number_of_attempts].to_i <= MAX_NUMBER_OF_VERIFY_REQUESTS)
  end
end
