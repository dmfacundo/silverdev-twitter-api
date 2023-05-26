class Api::V1::AccountsController < ApplicationController
  # POST /accounts
  def create
    # We should verify that is not an current_user already logged in
    # As we are not using sessions, we will skip this step
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:name)
  end
end
