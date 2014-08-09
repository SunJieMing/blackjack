#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', =>
      console.log 'Hello world!'
      #todo: uncover dealer hand cards.  Then we need to trigger dealer.hit while dealer score is < 17.  Call stand if it is above 17.
      )
    @get('dealerHand').on('stand', =>
      #compare the scores and declare a winner.
      )
