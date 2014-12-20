describe 'Dispatcher', ->
  beforeEach module 'song.dispatcher'

  sut = null

  describe 'factory', ->
    beforeEach inject ($injector)->
      sut = $injector.get('dispatcher')

    it 'exists and has a good API', ->
      should.exist sut
      sut.should.have.property 'get'
      sut.get.should.be.instanceof Function

    it 'fails on getting dispatcher for unloaded module', ->
      (-> sut.get('undefined.module')).should.throw()

  describe 'instance', ->
    beforeEach inject ($injector)->
      sut = $injector.get('dispatcher').get('song.dispatcher')
      sutb = $injector.get('dispatcher').get('song.dispatcher')

    it 'can return an dispatcher scoped to a module', ->
      should.exist sut
      sut.should.equal sutb

    it 'can register and dispatch actions', ->
      class TestAction
        constructor: ->
          this.data = 123

      testData = null
      sut.register TestAction, (testAction)->
        testData = testAction.data

      sut.dispatch new TestAction()

      testData.should.equal 123
