class window.CardView extends Backbone.View

  className: 'card'

  template: ->
    if @model.get 'revealed'
      _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'
    else
      _.template '<img src="img/card-back.png">'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template() @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
