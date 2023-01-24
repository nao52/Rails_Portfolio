class ParticipationsController < ApplicationController

  def create
    group = PrivateGroup.find(params[:private_group_id])
    current_user.join(group)
    redirect_to group
  end

  def destroy
    group = Participation.find(params[:id]).private_group
    current_user.leave(group)
    redirect_back(fallback_location: root_url, status: :see_other)
  end

end