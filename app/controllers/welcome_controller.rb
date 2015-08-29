
class WelcomeController < ApplicationController

  def index
    #broadcast_message :my_event_server, new_message
    #WebsocketRails.users[0].send_message('new_notification', {:message => 'you\'ve got an upvote '})
  end

  def game_state
    @game_state = CurrentGameSingleton.instance.game_state

    respond_to do |format|
      format.html { render layout: false}
      format.json { render json: @game_state }
    end
  end

end
