describe 'Chat Messages', ->
  beforeEach module(
    'song.chat.message.service'
    'song.chat.message.service.mock'
  )

  beforeEach inject (MessageMocks)->
    httpBackend MessageMocks, afterEach

  $httpBackend = null
  beforeEach inject ($injector)->
    $httpBackend = $injector.get('$httpBackend')

  it 'loads an array of messages', inject (MessageStore)->
    $httpBackend.expectGET '/messages'
    $httpBackend.flush()
    MessageStore.messages.length.should.equal 7

  it 'parses message timestamps into dates', inject (MessageStore)->
    $httpBackend.expectGET '/messages'
    $httpBackend.flush()
    MessageStore.messages[0].date.should.be.instanceof Date
