class ThreadItemController
  constructor: (dispatcher, @Actions, $err)->
    @dispatcher = dispatcher.get('song.chat')
    @lastMessage = @thread.lastMessage

  clickThread: ->
    @dispatcher.dispatch(new @Actions.Click(@key))

ThreadItemController.$inject = [
  'dispatcher'
  'Actions'
  '$exceptionHandler'
]

class ThreadItemDirective
  constructor: ->
    @templateUrl = 'chat/thread/item'
    @controller = ThreadItemController
    @controllerAs = 'state'
    @bindToController = yes
    @scope =
      key: '@'
      thread: '='
      currentThreadId: '@'

ThreadItemDirective.factory = ->
  new ThreadItemDirective

angular.module('song.chat.thread.item.directive', [
  'song.dispatcher'
  'song.chat.actions'
  'chat.thread.item.template'
])
.directive 'threadItem', ThreadItemDirective.factory
