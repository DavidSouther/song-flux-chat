class MessageItemController
  constructor: ()->

MessageItemController.$inject = [
]

class MessageItemDirective
  constructor: ->
    @templateUrl = 'chat/message/item'
    @controller = MessageItemController
    @controllerAs = 'state'
    @bindToController = yes
    @scope =
      key: '@'
      message: '='

MessageItemDirective.factory = -> new MessageItemDirective()

angular.module('song.chat.message.item.directive', [
  'chat.message.item.template'
])
.directive('messageItem', MessageItemDirective.factory)
