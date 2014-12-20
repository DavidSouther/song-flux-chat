describe 'CORS Access Control', ->
  it 'attaches Allow headers', (done)->
    superroute(require('./allow'))
    .get('/')
    .expect('Access-Control-Allow-Origin', '*')
    .expect('Access-Control-Allow-Headers', 'Content-Type')
    .end(done)
