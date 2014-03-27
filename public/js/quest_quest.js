window.QuestQuest = QuestQuest = {
  playerName: null,
  socket: null,

  sendMessage: function(message, type) {

    console.log(message, type);

    this.socket.send(JSON.stringify({
      message: message,
      type: type,
    }));

  },

  renderMap: function(map) {
    console.log(map);
    $.each(map, function(index, rows) {
      $('.map').append('<ul class="grid-row row-' + index + '"></ul>');
      $.each(rows, function(colIndex, item) {
        var thing = '&nbsp;';
        if(item) { thing = 'x'; }
        $('.row-' + index).append('<li>' + thing + '</li>');
      });
    });
  },

  parseMessage: function(message) {
    switch(message.type) {
      case 'announcement':
        console.log('announcement');
        $('.message-log ul').prepend('<li>' + message.message + '</li>');
        break;
      case 'map_update':
        this.renderMap(message.map);
        break;
      default:
        console.log(message);
    }
    if(message.player_count) {
      $('.player-count').text(message.player_count + ' players');
    }
    if(message.players) {
      $('.players ul').empty();
      $.each(message.players, function(index, name) {
        console.log(name);
        $('.players ul').prepend('<li>' + name + '</li>');
      });
    }
  },

  init: function() {
    this.playerName = prompt("What's your handle?");
    var that = this;

    this.socket = new WebSocket('ws://localhost:8080');

    this.socket.onopen = function(event) {

      // Send an initial message
      that.socket.send(JSON.stringify({
        message: 'Set name',
        type: 'name_change',
        name: that.playerName
      }));

    };

    // Listen for messages
    that.socket.onmessage = function(event) {
      QuestQuest.parseMessage(JSON.parse(event.data));
    };

    // Listen for socket closes
    that.socket.onclose = function(event) {
      console.log('Client notified socket has closed', event);
    };

  }

};

$(function() {
  QuestQuest.init();

  // object to hold movement key information
  var inputs = {};
  // add wasd inputs to object with a handler of movement
  inputs[107] = { key: 'k', handler: 'movement', message: 'up' }
  inputs[106] = { key: 'j', handler: 'movement', message: 'down' }
  inputs[104] = { key: 'h', handler: 'movement', message: 'left' }
  inputs[108] = { key: 'l', handler: 'movement', message: 'right' }

  // jquery bindings listening for keypress events
  $("body").keypress(function(event) {
    if(event.which in inputs) { // check for key in inputs object before proceeding
      var input = inputs[event.which]; // assign an input from our object
      QuestQuest.sendMessage(input.message, input.handler); // send a movement message to the server, of handler 'movement'
    }
  });
});


