angular.module('song.chat.message.service', [
  'song.dispatcher',
  'song.chat.actions'
]).factory('MessageStore', MessageStoreFactory);

MessageStoreFactory.$inject = [
  '$http',
  'dispatcher',
  'CreateMessageAction',
  'ReceiveMessagesAction',
  'LoadMessagesAction'
];
function MessageStoreFactory( $http, dispatcher, Create, Receive, Load ){
  function MessageStore($http, dispatcher){
    this.messages = [];
    this.dispatcher = dispatcher.get('song.chat');

    this._load = function(){return $http.get('/messages');};

    this.dispatcher.register(Create, this.addMessage.bind(this));
    this.dispatcher.register(Load, this.loadMessages.bind(this));

    this.dispatcher.dispatch(new Load());
  }

  MessageStore.prototype.loadMessages = function(){
    this._load().success(function(messages){
      while ( messages.length ){
        this.dispatcher.dispatch(new Create(messages.shift()));
      }
      this.dispatcher.dispatch(new Receive(this.messages));
    }.bind(this));
  };

  MessageStore.prototype.addMessage = function(createMessageAction){
    var msgData = createMessageAction.msgData;

    if ( ! msgData ) { return false; }
    if ( ! angular.isDate(msgData.date) ){
      msgData.date = new Date(msgData.timestamp);
    }
    this.messages.push(msgData);
    return true;
  };

  return new MessageStore($http, dispatcher);
}
