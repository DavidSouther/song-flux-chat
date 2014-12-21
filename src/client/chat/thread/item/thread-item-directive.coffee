class ThreadItemController
  constructor: (dispatcher, @Click)->
    @dispatcher = dispatcher.get('song.chat')
    @lastMessage = @thread.lastMessage

  clickThread: ->
    @dispatcher.dispatch(new @Click(@key))

ThreadItemController.$inject = [
  'dispatcher',
  'ClickThreadAction'
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
      currentThreadID: '@'

ThreadItemDirective.factory = ->
  new ThreadItemDirective

angular.module('song.chat.thread.item.directive', [
  'song.dispatcher'
  'song.chat.actions'
  'chat.thread.item.template'
]).directive 'threadItem', ThreadItemDirective.factory
