$(document).ready(function() {
    var dispatcher = new WebSocketRails('127.0.0.1:3000/websocket');
    dispatcher.on_open = function (data) {
        console.log('Connection has been established: ', data);
        // You can trigger new server events inside this callback if you wish.
    }
    dispatcher.bind('my_event_server', function (data) {
        console.log(data.message); // would output 'this is a message'
    });
});