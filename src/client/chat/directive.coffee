class SongChatDirective
  constructor: ->
    this.templateUrl = 'chat'

SongChatDirective.factory = ->
  new SongChatDirective

angular.module('song.chat.directive', [
  'song.chat.thread.directive',
  'song.chat.message.directive',
  'chat.template'
]).directive 'songChat', SongChatDirective.factory
