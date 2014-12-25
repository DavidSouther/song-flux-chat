describe 'Chat Messages', ->
  sut = null
  beforeEach module(
    'song.chat.message.service'
    'song.chat.message.service.mock'
  )

  beforeEach inject (MessageMocks)->
    httpBackend MessageMocks, afterEach

  $httpBackend = null
  beforeEach inject ($injector)->
    $httpBackend = $injector.get('$httpBackend')
    sut = $injector.get('MessageStore')

  it 'loads an array of messages', ->
    $httpBackend.expectGET '/messages'
    $httpBackend.flush()
    sut.messages.length.should.equal 7

  it 'parses message timestamps into dates', ->
    $httpBackend.expectGET '/messages'
    $httpBackend.flush()
    sut.messages[0].date.should.be.instanceof Date

  it 'returns all messages in the current thread', ->
    $httpBackend.expectGET '/messages'
    $httpBackend.flush()
    current = sut.getAllForCurrentThread()
    current.length.should.equal 2
