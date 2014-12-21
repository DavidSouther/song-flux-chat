class SongThreadDirectiveController
  constructor: (@_threadStore, dispatcher)->
    @dispatcher = dispatcher.get('song.chat')
    @_threadStore.addUpdateListener @update.bind @

  update: ->
    @threads = @_threadStore.getAllChrono()
    @currentThreadID = @_threadStore.getCurrentID()

SongThreadDirectiveController.$inject = [
  'ThreadStore'
  'dispatcher'
]

class SongChatThreadDirective
  constructor: (threadStore, dispatcher)->
    @templateUrl = 'chat/thread'
    @controller = SongThreadDirectiveController
    @controllerAs = 'state'
    @scope = {}

SongChatThreadDirective.factory = ->
  new SongChatThreadDirective

angular.module('song.chat.thread.directive', [
  'song.chat.thread.service'
  'song.chat.thread.item.directive'
  'chat.thread.template'
]).directive 'chatThreads', SongChatThreadDirective.factory
