class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user
      flash[:success] = "Welcome back to the Sample App!"
      redirect_to user
    elsif user && !user.authenticate(params[:session][:password])
      # Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid password.'
      render 'new'
    else
      flash.now[:error] = 'Invalid email. User does not exist.'
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = 'Successfully signed out'
    redirect_to root_url
  end

end
