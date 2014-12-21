messages = [
  id: 'm_4',
  threadID: 't_2',
  threadName: 'Dave and Bill',
  authorName: 'Bill',
  text: 'Hey Dave, want to get a beer after the conference?',
  timestamp: Date.now() - 69999
,
  id: 'm_5',
  threadID: 't_2',
  threadName: 'Dave and Bill',
  authorName: 'Dave',
  text: 'Totally!  Meet you at the hotel bar.',
  timestamp: Date.now() - 59999
]
messages.forEach (_)->_.date = new Date(_.timestamp)

mockThreadStore =
  listener: null
  addUpdateListener: (cb)-> mockThreadStore.listener = cb
  getCurrent: ->
    id: 't_2'
    name: 'Dave and Bill'
    lastMessage: messages[1]
mockMessageStore =
  listener: null
  addUpdateListener: (cb)-> mockMessageStore.listener = cb
  getAllForCurrentThread: -> messages

describe 'MessageDirective', ->
  sut = null
  beforeEach module 'song.chat.message.directive'
  beforeEach module ($provide)->
    $provide.value 'ThreadStore', mockThreadStore
    $provide.value 'MessageStore', mockMessageStore
    return false

  describe 'Controller', ->
    beforeEach inject ($controller)->
      Ctor = $controller 'MessageSectionController', {}, true
      sut = Ctor()
      mockThreadStore.listener()

    it 'loads the current thread', ->
      sut.thread.id.should.equal 't_2'
      sut.messages.length.should.equal 2

  describe 'render', ->
    beforeEach ->
      sut = renderElement 'chat-messages'
      mockMessageStore.listener()
      sut.$scope.$digest()

    it 'prints the thread name', ->
      sut.find('h3').text().should.equal 'Dave and Bill'
