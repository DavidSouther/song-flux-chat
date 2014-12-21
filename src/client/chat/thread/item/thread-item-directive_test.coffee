lastMessage =
    id: "m_3"
    threadID: "t_1"
    threadName: "Jing and Bill"
    authorName: "Jing"
    text: "Sounds good.  Will they be serving dessert?"
    timestamp: 1419135814671
    isRead: true
lastMessage.date = new Date lastMessage.timestamp
thread = {
  id: "t_1"
  name: "Jing and Bill"
  lastMessage
}

describe 'ThreadItemDirective', ->
  sut = null

  beforeEach module 'song.chat.thread.item.directive'
  beforeEach module ($exceptionHandlerProvider)->
    $exceptionHandlerProvider.mode('log')
    return false

  describe 'ThreadItemController', ->
    beforeEach inject ($controller)->
      $el = renderElement 'thread-item',
        { thread: thread }, # data
        { thread: 'thread', key: 't_1', 'current-thread-id': 't_1' } #HTML Attrs
      sut = $el.isolateScope().state

    it 'manages a thread', ->
      sut.key.should.equal 't_1'
      sut.currentThreadId.should.equal 't_1'
      sut.lastMessage.id.should.equal lastMessage.id

    it 'generates click actions', inject (dispatcher, ClickThreadAction)->
      clickedId = 'bad_id'
      dispatcher.get('song.chat').register ClickThreadAction, (click)->
        clickedId = click.threadID
      sut.clickThread()
      clickedId.should.equal 't_1'

  describe 'rendering', ->
    beforeEach ->
      sut = renderElement 'thread-item',
        { thread: thread, key: 't_1', currentThreadID: 't_1' },
        { thread: 'thread', key: 'key', 'current-thread-id': 'currentThreadID' }

    it 'shows thread details', ->
      name = sut[0].querySelector('.thread-name').innerText
      time = sut[0].querySelector('.thread-time').innerText
      message = sut[0].querySelector('.thread-last-message').innerText

      name.should.equal thread.name
      message.should.match /dessert\?/
      time.length.should.be.greaterThan 2
