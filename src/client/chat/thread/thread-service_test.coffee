messages = [
  id: 'm_3',
  threadID: 't_1',
  threadName: 'Jing and Bill',
  authorName: 'Jing',
  text: 'Sounds good.  Will they be serving dessert?',
  timestamp: Date.now() - 79999
  date: new Date(this.timestamp)
,
  id: 'm_4',
  threadID: 't_2',
  threadName: 'Dave and Bill',
  authorName: 'Bill',
  text: 'Hey Dave, want to get a beer after the conference?',
  timestamp: Date.now() - 69999
]
messages.forEach (_)->_.date = new Date(_.timestamp)

describe 'Thread Store', ->
  beforeEach module(
    'song.chat.thread.service'
    'song.chat.actions'
  )

  sut = null
  Actions = null
  beforeEach inject ($injector)->
    sut = $injector.get('ThreadStore')
    Actions = $injector.get('Actions')

  it 'initializes an array of messages', ->
    receive = new Actions.Receive(messages)

    sut.addMessages(receive)

    sut.getCurrentID().should.equal('t_2')

  it 'returns the current thread', ->
    receive = new Actions.Receive(messages)
    sut.addMessages(receive)
    sut.getCurrent().id.should.equal('t_2')
