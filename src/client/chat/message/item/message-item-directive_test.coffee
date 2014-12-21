message =
  id: 'm_4',
  threadID: 't_2',
  threadName: 'Dave and Bill',
  authorName: 'Bill',
  text: 'Hey Dave, want to get a beer after the conference?',
  timestamp: Date.now() - 69999
message.date = new Date message.timestamp

describe 'MessageItemDirective', ->
  sut = null
  beforeEach module 'song.chat.message.item.directive'

  describe 'Controller', ->
    beforeEach inject ($controller)->
      Ctor = $controller 'MessageItemController', {}, true
      sut = Ctor()

  describe 'render', ->
    beforeEach ->
      sut = renderElement 'message-item',
        {message}, # Data
        {key: 'm_4', message: 'message'} # Attributes to bind with

    it 'show a message', ->
      sut.find('h5').text().should.equal 'Bill'
