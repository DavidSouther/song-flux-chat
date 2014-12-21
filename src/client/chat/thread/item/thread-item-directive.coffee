class ThreadItemController
  constructor: (dispatcher, @Click, $err)->
    unless @key? and @thread? and @currentThreadId?
      msg = 'ThreadItemController must be constructed with bound scope.'
      return $err new Error msg
    @dispatcher = dispatcher.get('song.chat')
    @lastMessage = @thread.lastMessage

  clickThread: ->
    @dispatcher.dispatch(new @Click(@key))

ThreadItemController.$inject = [
  'dispatcher'
  'ClickThreadAction'
  '$exceptionHandler'
]

class ThreadItemDirective
  constructor: ->
    @templateUrl = 'chat/thread/item'
    @controller = ThreadItemController.name
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
.controller ThreadItemController.name, ThreadItemController
.directive 'threadItem', ThreadItemDirective.factory
