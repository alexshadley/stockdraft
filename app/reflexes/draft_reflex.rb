class DraftReflex < ApplicationReflex
  def newUser
    @round = Round.find(params[:id])

    user = User.new(session_id: session.id, display_name: params[:name], round_id: @round.round_id)
    user.save

    # re-query all users
    @users = User.where(round_id: @round.round_id)
  end
end
