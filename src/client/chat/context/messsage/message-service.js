angular.module('song.chat.message.service', [
  'songDispatcher',
  'song.chat.actions',
  'song.chat.thread.service'
]).factory('MessageStore', MessageStoreFactory);

MessageStoreFactory.$inject = [
  '$http',
  'songDispatcherFactory',
  'ThreadStore',
  'Actions',
  '$log'
];
function MessageStoreFactory(
  $http,
  dispatcher,
  ThreadStore,
  Actions,
  $log
){
  function MessageStore(){
    this.messages = [];
    this.dispatcher = dispatcher.getDispatcher('song.chat');

    this._load = function(){return $http.get('/messages');};

    this.dispatcher.register( Actions.Create, this.addMessage.bind(this) );
    this.dispatcher.register( Actions.Load, this.loadMessages.bind(this) );

    this.dispatcher.dispatch(new Actions.Load());
  }

  MessageStore.prototype.loadMessages = function(){
    this._load().success(function(messages){
      while ( messages.length ){
        var create = new Actions.Create(messages.shift());
        this.dispatcher.dispatch(create);
      }
      this.dispatcher.dispatch(new Actions.Receive(this.messages));
    }.bind(this));
  };

  MessageStore.prototype.addMessage = function(create){
    var msgData = create.msgData;

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

  return new MessageStore();
}
