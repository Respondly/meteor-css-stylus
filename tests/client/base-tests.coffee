@expect = chai.expect

Meteor.startup ->
  $('title').html('Tests:stylus-compiler')


# ----------------------------------------------------------------------


###
The base tests ported over from the core Meteor pacakge.
###

describe 'Stylus (Meteor Tests)', ->
  div = null
  beforeEach -> div = document.createElement('div')
  afterEach -> document.body.removeChild(div)



  it 'compiles [.styl] files', ->
    UI.materialize(Template.stylus_test_presence, div)
    div.style.display = 'block'
    document.body.appendChild(div)

    p = div.querySelector('p')
    leftBorder = getStyleProperty(p, 'border-left-style')
    expect(leftBorder).to.equal 'dashed'




  it 'imports a [.import.styl] file', ->
    UI.materialize(Template.stylus_test_import, div)
    div.style.display = 'block'
    document.body.appendChild(div)

    p = div.querySelector('p')
    expect(getStyleProperty(p, 'font-size')).to.equal '20px'
    expect(getStyleProperty(p, 'border-left-style')).to.equal 'dashed'




