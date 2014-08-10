class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.get('playerHand').on('bust', =>
      alertFunction = () ->
        alert 'You busted! Dealer won!'
      setTimeout(alertFunction, 100)
      setTimeout(@model.refresh, 200)

    )
    @model.get('dealerHand').on('bust', =>
      alertFunction = () ->
        alert 'Dealer busted! You are awesome!'
      setTimeout(alertFunction, 100)
      setTimeout(@model.refresh, 200)
    )
    @model.on('win', =>
      alertFunction = () ->
        alert 'You won!'
      setTimeout(alertFunction, 100)
      setTimeout(@model.refresh, 200)
    )
    @model.on('lose', =>
      alertFunction = () ->
        alert 'You lost!'
      setTimeout(alertFunction, 100)
      setTimeout(@model.refresh, 200)
    )

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
