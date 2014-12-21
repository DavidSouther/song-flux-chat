function Receive(msgData){ this.messages = msgData; }
function Create(msgData){ this.msgData = msgData; }
function Click(threadID){ this.threadID = threadID; }
function Load(){}

angular.module('song.chat.actions', [

])
.value('Actions', {
  Receive: Receive,
  Create: Create,
  Click: Click,
  Load: Load
})
;
