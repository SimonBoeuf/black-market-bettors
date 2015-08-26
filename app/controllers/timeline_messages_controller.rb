class TimelineMessagesController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def update msg
    broadcast_message :my_event_server, {message: msg}
  end

  def client_connected
    CurrentGameSingleton.instance.add_observer(self)
    broadcast_message :my_event_server, {message: {status: "loading", data: CurrentGameSingleton.instance.champions}} if CurrentGameSingleton.instance.status == :loading
  end

  def delete_user

  end

  def send_message
    new_message = {:message => "this is a message from server. Original message :"}
    broadcast_message :my_event_server, new_message
  end
end