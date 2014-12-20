describe 'Dispatcher', ->
  beforeEach module 'song.dispatcher'

  SUT = null
  beforeEach inject ($injector)->
    SUT = $injector.get('dispatcher')

  it 'exists', ->
    should.exist SUT

  it 'can return an dispatcher scoped to a module', ->
    SUT.should.have.property 'get'
    SUT.get.should.be.instanceof Function

    should.exist SUT.get('song.dispatcher')
    sut1 = SUT.get('song.dispatcher')
    sut2 = SUT.get('song.dispatcher')
    sut1.should.equal sut2

  it 'fails on getting dispatcher for unloaded module', ->
    sut = -> SUT.get('undefined.module')
    sut.should.throw()

  it 'can register actions', ->
    sut = SUT.get('song.dispatcher')
    class TestAction
      constructor: ->
        this.data = 123
    testData = null
    sut.register TestAction, (testAction)->
      testData = testAction.data

    sut.dispatch new TestAction()

    testData.should.equal 123
