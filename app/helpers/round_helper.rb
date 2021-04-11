module RoundHelper
  def self.users_in_round(active_round_id)
    return User.select("user_id").where(round_id: [active_round_id]).distinct.order("user_id")
  end
end
