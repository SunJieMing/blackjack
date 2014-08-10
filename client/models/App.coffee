#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('stand', =>
      @get('dealerHand').map (card) ->
        if card.get('revealed') is false
          card.flip()

      dealerScore = @checkDealer()
      while dealerScore < 17
        @get('dealerHand').hit()
        dealerScore = @checkDealer()
      @get('dealerHand').stand()
    )

    @get('dealerHand').on('stand', =>
      if @checkDealer() <= 21 and @checkPlayer() <= 21
        if @checkDealer() < @checkPlayer()
          @trigger('win')
        if @checkDealer() >= @checkPlayer()
          @trigger('lose')
    )

  checkDealer: ->
    if @get('dealerHand').scores()[1]? and @get('dealerHand').scores()[1] < 21
      dealerScore = @get('dealerHand').scores()[1]
    else
      dealerScore = @get('dealerHand').scores()[0]

  checkPlayer: ->
    if @get('playerHand').scores()[1]? and @get('playerHand').scores()[1] < 21
      dealerScore = @get('playerHand').scores()[1]
    else
      dealerScore = @get('playerHand').scores()[0]

  refresh: ->
    $('div').remove()
    new AppView(model: new App()).$el.appendTo 'body'
