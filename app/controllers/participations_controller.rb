class ParticipationsController < ApplicationController

  def create
    @group = PrivateGroup.find(params[:private_group_id])
    current_user.join(@group)
    respond_to do |format|
      format.html { redirect_to @group }
      format.turbo_stream
    end
  end

  def destroy
    @group = Participation.find(params[:id]).private_group
    current_user.leave(@group)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url, status: :see_other) }
      format.turbo_stream
    end
  end

end