angular.module('song.chat.actions', [

])
.value('CreateMessageAction', CreateMessageAction)
.value('ReceiveMessagesAction', ReceiveMessagesAction)
.value('LoadMessagesAction', function LoadMessagesAction(){})
.value('ClickThreadAction', ClickThreadAction)
;

function ReceiveMessagesAction(msgData){ this.messages = msgData; }
function CreateMessageAction(msgData){ this.msgData = msgData; }
function ClickThreadAction(threadID){ this.threadID = threadID; }
