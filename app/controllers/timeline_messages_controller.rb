class TimelineMessagesController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def update msg
    msg[:status] ? send_message(:status_msg, msg) : send_message(:event_msg, msg)
  end

  def client_connected
    g = CurrentGameSingleton.instance
    g.add_observer(self)
    send_message(:status_msg, {status: "loading", data: CurrentGameSingleton.instance.champions}) if g.status == :loading
    send_message(:status_msg, {status: "running", data: CurrentGameSingleton.instance.game_state}) if g.status == :running
  end

  def delete_user

  end

end