class SongThreadDirectiveController
  constructor: (@_threadStore)->
    @_threadStore.addUpdateListener @update.bind @

  update: ->
    @threads = @_threadStore.getAllChrono()
    @currentThreadID = @_threadStore.getCurrentID()

SongThreadDirectiveController.$inject = [
  'ThreadStore'
]

class SongChatThreadDirective
  constructor: ->
    @templateUrl = 'chat/thread'
    @controller = SongThreadDirectiveController
    @controllerAs = 'state'
    @bindToController = yes
    @scope = {}

SongChatThreadDirective.factory = ->
  new SongChatThreadDirective

angular.module('song.chat.thread.directive', [
  'song.chat.thread.service'
  'song.chat.thread.item.directive'
  'chat.thread.template'
])
.directive('chatThreads', SongChatThreadDirective.factory)
