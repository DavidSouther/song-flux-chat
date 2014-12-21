angular.module('song.chat', [
  'song.chat.message.service',
  'song.chat.actions'
])
.run(function(MessageStore){ return MessageStore; })
;
