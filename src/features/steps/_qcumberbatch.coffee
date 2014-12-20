mappings = require '../mappings'

steps = ->

rupertSteps = require('rupert-grunt/src/features/steps')
module.exports = rupertSteps(steps, {protractor: yes})
