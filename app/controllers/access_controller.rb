class AccessController < ApplicationController
  skip_before_action :verify_access, only: [ :new, :create ]

  def new
  end

  def create
    if Access.authenticate(params[:password])
      session[:authenticated] = true
      redirect_to root_path, notice: "Access granted!"
    else
      flash.now[:alert] = "Incorrect password."
      render :new, status: :unprocessable_entity
    end
  end
end
