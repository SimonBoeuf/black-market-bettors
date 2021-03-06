class TimelineMessagesController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def update msg
    msg[:status] ? send_message(:status_msg, msg) : send_message(:event_msg, msg)
    send_message(:bet_results_msg, {score: CurrentGameSingleton.instance.bettor_score(@_event.connection.id)}) if CurrentGameSingleton.instance.status == :ended
  end

  def client_connected
    g = CurrentGameSingleton.instance
    g.add_bettor(@_event.data[:connection_id])
    g.add_observer(self)
    send_message(:status_msg, {status: "loading", data: CurrentGameSingleton.instance.champions}) if g.status == :loading
    send_message(:status_msg, {status: "running", data: CurrentGameSingleton.instance.game_state}) if g.status == :running
  end

  def place_bet
    CurrentGameSingleton.instance.place_bet(@_event.connection.id, message)
    send_message(:bet_received_msg, {team: message})
  end


  def delete_user
    CurrentGameSingleton.instance.remove_bettor @_event.connection.id
  end

end