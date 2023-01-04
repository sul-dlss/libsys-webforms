# Controller to show, create, and edit AuthorizedUsers
class AuthorizedUsersController < ApplicationController
  load_and_authorize_resource

  before_action :redirect_cancel, only: %i[create update]

  def index
    @authorized_users = AuthorizedUser.all.order(:user_id)
  end

  def new
    @authorized_user = AuthorizedUser.new
    respond_to do |format|
      format.js # new.js.erb
    end
  end

  def edit
    @edit ||= AuthorizedUser.find_by(user_id: params[:user_id])
  end

  def create
    @authorized_user = AuthorizedUser.find_or_initialize_by(user_id: authorized_user_params[:user_id])
    if @authorized_user.new_record?
      @authorized_user = AuthorizedUser.create(authorized_user_params)
      if @authorized_user.errors.any?
        @authorized_user.errors.full_messages.each do |msg|
          flash[:error] = msg
        end
      else
        @authorized_user.save
        flash[:success] = 'User created!'
      end
    else
      flash[:error] = 'User already exists!'
    end
    redirect_to authorized_users_index_path
  end

  def update
    @authorized_user ||= AuthorizedUser.find_by(user_id: params[:user_id])
    @authorized_user.update(authorized_user_params)
    if @authorized_user.errors.any?
      @authorized_user.errors.full_messages.each do |msg|
        flash[:error] = msg
      end
      render action: 'edit'
    else
      flash[:success] = 'User updated!'
      redirect_to authorized_users_index_path
    end
  end

  def delete
    @authorized_user ||= AuthorizedUser.find_by(user_id: params[:user_id])
    if @authorized_user.destroy
      flash[:notice] = 'User deleted!'
    else
      flash[:error] = 'User has access to other forms and cannot be deleted!'
    end
    redirect_to authorized_users_index_path
  end

  private

  def authorized_user_params
    params.require(:authorized_user).permit!
  end

  def redirect_cancel
    redirect_to authorized_users_index_path if params[:cancel]
  end
end
