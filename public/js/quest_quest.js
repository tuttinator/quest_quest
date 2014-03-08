window.QuestQuest = QuestQuest = {
  socket: new WebSocket('ws://localhost:8080'),

  sendMessage: function (message, type) {
    if(this.socket_id === undefined) {
      alert('Cannot send any data to the server, handshake has failed.');
    } else {
      this.socket.send(JSON.stringify({ message: message, handler: handler, socket_id: this.socket_id }));
    }
  }

}


// Open the socket
QuestQuest.socket.onopen = function(event) {

  console.log(event);

  // Send an initial message
  socket.send(JSON.stringify({ message: 'New connection' }));

  // Listen for messages
  socket.onmessage = function(event) {
    parsedMessage = JSON.parse(event.data);
    console.log(parsedMessage);
  };

  // Listen for socket closes
  socket.onclose = function(event) {
    console.log('Client notified socket has closed', event);
  };

  // To close the socket....
  //socket.close()
};

window.sendMessage = function (message, handler) {
  if(QuestQuest.socket_id === undefined) {
    alert('Cannot send any data to the server, handshake has failed.');
  } else {
    window.socket.send(JSON.stringify({ message: message, handler: handler, socket_id: Cranberry.socket_id }));
  }
};
