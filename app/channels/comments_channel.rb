class CommentsChannel < ApplicationCable::Channel
  def subscribed
     # stream_from "some_channel"
     stream_from "comments_#{params['category_name']}_#{params['product_name']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
