class TimelineMessagesController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def update msg
    send_message :event_msg, {message: msg}
  end

  def client_connected
    CurrentGameSingleton.instance.add_observer(self)
    CurrentGameSingleton.instance.status == :loading ?
        send_message(:loading_screen_msg, {message: {status: "loading", data: CurrentGameSingleton.instance.champions}}) :
        send_message(:game_state_msg, {message: {status: "running", data: {type: "game_state", data: CurrentGameSingleton.instance.game_state}}})
  end

  def delete_user

  end

end