class ThreadItemController
  constructor: (dispatcher, @Actions, $err)->
    @dispatcher = dispatcher.getDispatcher('song.chat')
    @lastMessage = @thread.lastMessage

  clickThread: ->
    @dispatcher.dispatch(new @Actions.Click(@key))

ThreadItemController.$inject = [
  'songDispatcherFactory'
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
  'songDispatcher'
  'song.chat.actions'
  'chat.thread.item.template'
])
.directive 'threadItem', ThreadItemDirective.factory
