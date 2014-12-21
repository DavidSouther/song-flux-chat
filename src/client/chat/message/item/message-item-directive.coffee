class MessageItemController
  constructor: ($err)->
    unless @key? and @message?
      msg = 'ThreadItemController must be constructed with bound scope.'
      $err new Error msg

MessageItemController.$inject = [
  '$exceptionHandler'
]

class MessageItemDirective
  constructor: ->
    @templateUrl = 'chat/message/item'
    @controller = MessageItemController.name
    @controllerAs = 'state'
    @bindToController = yes
    @scope =
      key: '@'
      message: '='

MessageItemDirective.factory = -> new MessageItemDirective()

angular.module('song.chat.message.item.directive', [
  'chat.message.item.template'
])
.controller(MessageItemController.name, MessageItemController)
.directive('messageItem', MessageItemDirective.factory)
