class WelcomeController < ApplicationController

  def index
    new_message = {:message => "Server received connection"}
    #broadcast_message :my_event_server, new_message
    #WebsocketRails.users[0].send_message('new_notification', {:message => 'you\'ve got an upvote '})
  end


end
