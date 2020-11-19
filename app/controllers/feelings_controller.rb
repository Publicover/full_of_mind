class FeelingsController < ApplicationController
  before_action :set_user
  before_action :set_feeling, only: %i[show update destroy]

  def index
    @feelings = @user.feelings.current
    json_response(@feelings.order(page_order: :asc), :ok)
  end

  def show; end

  def create
    @user.feelings.create!(feelings_params)
    json_response(@user.feelings.last, :created)
  end

  def update
    json_response(@feeling, :ok) if @feeling.update(feelings_params)
  end

  def destroy
    @feeling.destroy
    json_response(@user, :ok)
  end

  private

    def feelings_params
      params.require(:feeling).permit(:body, :page_order, :user_id)
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_feeling
      @feeling = @user.feelings.find(params[:id]) if @user
    end
end
