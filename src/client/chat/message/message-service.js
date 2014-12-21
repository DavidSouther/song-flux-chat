angular.module('song.chat.message.service', [
  'song.dispatcher',
  'song.chat.actions',
  'song.chat.thread.service'
]).factory('MessageStore', MessageStoreFactory);

MessageStoreFactory.$inject = [
  '$http',
  'dispatcher',
  'ThreadStore',
  'CreateMessageAction',
  'ReceiveMessagesAction',
  'LoadMessagesAction',
  '$log'
];
function MessageStoreFactory(
  $http,
  dispatcher,
  ThreadStore,
  Create,
  Receive,
  Load,
  $log
){
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

  MessageStore.prototype.getAllForCurrentThread = function(){
    var currentThreadID = ThreadStore.getCurrentID();
    return this.messages.filter(function(message){
      return message.threadID === currentThreadID;
    });
  };

  var listeners = [];
  MessageStore.prototype.addUpdateListener = function(callback){
    listeners.push(callback);
  };
  MessageStore.prototype.emitUpdate = function(){
    for(var i = 0; i < listeners.length ; i++){
      try {
        listeners[i]();
      } catch (e) {
        $log.warn(e);
      }
    }
  };

  return new MessageStore($http, dispatcher);
}
