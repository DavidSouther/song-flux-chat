angular.module('song.chat.actions', [

])
.value('CreateMessageAction', CreateMessageAction)
.value('LoadMessagesAction', LoadMessagesAction)
;

function CreateMessageAction(msgData){ this.msgData = msgData; }
function LoadMessagesAction(){}
