MessageSectionController.$inject = [
  'ThreadStore',
  'MessageStore'
];
function MessageSectionController(ThreadStore, MessageStore){
  this.ThreadStore = ThreadStore;
  this.MessageStore = MessageStore;

  this.ThreadStore.addUpdateListener(this.update.bind(this));
  this.MessageStore.addUpdateListener(this.update.bind(this));
}

MessageSectionController.prototype.update = function(){
  this.messages = this.MessageStore.getAllForCurrentThread();
  this.thread = this.ThreadStore.getCurrent();
};

function MessageSectionDirective(){
  this.templateUrl = 'chat/message';
  this.controller = 'MessageSectionController';
  this.controllerAs = 'state';
  this.scope = {};
}
MessageSectionDirective.factory = function(){
  return new MessageSectionDirective();
};

angular.module('song.chat.message.directive', [
  'song.chat.message.service',
  'song.chat.thread.service',
  'song.chat.message.item.directive',
  'chat.message.template'
])
.controller('MessageSectionController', MessageSectionController)
.directive('chatMessages', MessageSectionDirective.factory)
;
