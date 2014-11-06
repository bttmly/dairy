require("chai").should()

Dairy = require "../src/index.coffee"

describe "Dairy()", ->
  instance = undefined

  beforeEach ->
    instance = Dairy 10, 1

  it "basically works", (done) ->
    instance
      .add "a", 1
      .add "b", 2
      .add "c", 3

    instance.size().should.equal 3

    setTimeout ->
      instance.size().should.equal 0
      do done
    , 20


