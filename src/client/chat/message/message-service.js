angular.module('song.chat.message.service', [
  'song.dispatcher'
]).service('MessageStore', MessageStore);

function CreateMessageAction(msgData){ this.msgData = msgData; }
function LoadMessagesAction(){}

MessageStore.$inject = ['$http', 'dispatcher'];
function MessageStore($http, dispatcher){
  this.messages = [];
  this.dispatcher = dispatcher.get('song.chat.message');

  this._load = function(){return $http.get('/messages');};

  this.dispatcher.register(CreateMessageAction, this.addMessage.bind(this));
  this.dispatcher.register(LoadMessagesAction, this.loadMessages.bind(this));

  this.dispatcher.dispatch(new LoadMessagesAction());
}

MessageStore.prototype.loadMessages = function(){
  this._load().success(function(messages){
    while ( messages.length ){
      this.dispatcher.dispatch(new CreateMessageAction(messages.shift()));
    }
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
