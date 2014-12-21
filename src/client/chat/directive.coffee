class SongChatDirective
  constructor: ->
    this.templateUrl = 'chat'

SongChatDirective.factory = ->
  new SongChatDirective

angular.module('song.chat.directive', [
  'chat.template'
]).directive 'songChat', SongChatDirective.factory
