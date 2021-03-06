angular.module('song.chat.thread.service', [
  'songDispatcher',
  'song.chat.actions'
]).factory('ThreadStore', ThreadStoreFactory);

ThreadStoreFactory.$inject = [
  'songDispatcherFactory',
  'Actions',
  '$log'
];
function ThreadStoreFactory(dispatcher, Actions, $log){
  var _currentID = '';
  var _threads = {};

  function ThreadStore(){
    this.dispatcher = dispatcher.get('song.chat');
    this.dispatcher.register( Actions.Receive, this.addMessages.bind(this) );
    this.dispatcher.register( Actions.Click, this.click.bind(this) );
  }

  ThreadStore.prototype.addMessages = function(receive){
    receive.messages.forEach(function(message){
      var threadID = message.threadID;
      var thread = _threads[threadID];
      if (thread && thread.lastTimestamp > message.timestamp) {
        return;
      }
      message.isRead = message.threadID === _currentID;
      _threads[threadID] = {
        id: threadID,
        name: message.threadName,
        lastMessage: message
      };
    }.bind(this));

    if (!_currentID) {
      var allChrono = this.getAllChrono();
      _currentID = allChrono[allChrono.length - 1].id;
    }

    _threads[_currentID].lastMessage.isRead = true;
    this.emitUpdate();
  };

  ThreadStore.prototype.getAllChrono = function(){
    var orderedThreads = [];
    for (var id in _threads) {
      var thread = _threads[id];
      orderedThreads.push(thread);
    }
    orderedThreads.sort(function(a, b) {
      if (a.lastMessage.date < b.lastMessage.date) {
        return -1;
      } else if (a.lastMessage.date > b.lastMessage.date) {
        return 1;
      }
      return 0;
    });
    return orderedThreads;
  };

  ThreadStore.prototype.click = function(click){
    _currentID = click.threadID;
    _threads[_currentID].lastMessage.isRead = true;
    this.emitUpdate();
  };

  ThreadStore.prototype.getCurrentID = function(){
    return _currentID;
  };

  ThreadStore.prototype.getCurrent = function(){
    return _threads[_currentID];
  };

  var listeners = [];
  ThreadStore.prototype.addUpdateListener = function(callback){
    listeners.push(callback);
  };
  ThreadStore.prototype.emitUpdate = function(){
    for(var i = 0; i < listeners.length ; i++){
      try {
        listeners[i]();
      } catch (e) {
        $log.warn(e);
      }
    }
  };

  return new ThreadStore();
}
