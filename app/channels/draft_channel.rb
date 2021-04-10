class DraftChannel < ApplicationCable::Channel
  def subscribed
    stream_from "draft:#{params[:id]}"
  end
end
