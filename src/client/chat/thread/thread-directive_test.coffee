now = Date.now()
threads = [
  id: 't_1'
  name: 'Jing and Bill'
  lastMessage:
    id: 'm_3',
    threadID: 't_1',
    threadName: 'Jing and Bill',
    authorName: 'Jing',
    text: 'Sounds good.  Will they be serving dessert?',
    timestamp: now - 79999
    date: new Date(now - 79999)
,
  id: 't_2'
  name: 'Dave and Bill'
  lastMessage:
    id: 'm_4',
    threadID: 't_2',
    threadName: 'Dave and Bill',
    authorName: 'Bill',
    text: 'Hey Dave, want to get a beer after the conference?',
    timestamp: now - 69999
    date: new Date(now - 69999)
]

describe 'ThreadDirective', ->
  sut = null
  updateListener = null
  mockStore =
    addUpdateListener: (cb)-> updateListener = cb
    getCurrentID: -> 't_1'
    getAllChrono: -> threads

  beforeEach module 'song.chat.thread.directive'
  beforeEach module ($provide)->
    $provide.value 'ThreadStore', mockStore
    return false

  describe 'Controller', ->
    beforeEach inject ($controller)->
      Ctor = $controller('SongThreadDirectiveController', {
        ThreadStore: mockStore
      }, true)
      sut = Ctor()

    it 'loads thread data on update', ->
      updateListener()
      sut.threads.length.should.equal 2
      sut.currentThreadID.should.equal 't_1'

  describe 'render', ->
    beforeEach ->
      sut = renderElement 'chat-threads'
      updateListener()
      sut.$scope.$digest()

    it 'binds a list of thread-items', ->
      sut.find('li').length.should.equal 2
