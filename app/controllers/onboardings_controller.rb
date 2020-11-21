class OnboardingsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @user.feelings.create!(feelings_params) unless @user.check_current_total > 4
    @user.complete_onboarding if @user.check_current_total == 4
  end

  private

    def feelings_params
      params.require(:feeling).permit(:body, :page_order, :user_id)
    end
end
