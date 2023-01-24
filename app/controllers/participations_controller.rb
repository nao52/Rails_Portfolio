class ParticipationsController < ApplicationController

  def create
    group = PrivateGroup.find(params[:private_group_id])
    current_user.join(group)
    redirect_to group
  end

  def destroy
    # group = Participation.find(params[:id]).
  end

end
