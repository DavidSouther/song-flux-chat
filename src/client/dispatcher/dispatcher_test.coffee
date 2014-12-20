describe 'Dispatcher', ->
  beforeEach module 'song.dispatcher'

  sut = null
  beforeEach inject ($injector)->
    sut = $injector.get('dispatcher')

  it 'exists', ->
    should.exist sut

  it 'can return an dispatcher scoped to a module', ->
    sut.should.have.property 'getDispatcher'
    sut.getDispatcher.should.be.instanceof Function

    should.exist sut.getDispatcher('song.dispatcher')
    a1 = sut.getDispatcher('song.dispatcher')
    a2 = sut.getDispatcher('song.dispatcher')
    a1.should.equal a2

  
