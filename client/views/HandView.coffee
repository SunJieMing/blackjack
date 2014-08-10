class window.HandView extends Backbone.View

  className: 'hand'
  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @render()
    @collection.on 'add remove change', =>
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el

    if @collection.scores()[1]? and @collection.scores()[1] < 21
      score = @collection.scores()[1]
    else
      score = @collection.scores()[0]

    @$('.score').text score
