class SongChatDirective
  constructor: ->
    this.templateUrl = 'chat'

SongChatDirective.factory = ->
  new SongChatDirective

angular.module('song.chat.directive', [
  'song.chat.thread.directive',
  'chat.template'
]).directive 'songChat', SongChatDirective.factory
