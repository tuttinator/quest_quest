window.QuestQuest = QuestQuest = {
  playerName: null,
  socket: null,

  renderMap: function(map) {
    console.log(map);
    //$('.map');
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
});

