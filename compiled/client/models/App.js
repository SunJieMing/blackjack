// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = (function(_super) {
    __extends(App, _super);

    function App() {
      return App.__super__.constructor.apply(this, arguments);
    }

    App.prototype.initialize = function() {
      var deck;
      this.set('deck', deck = new Deck());
      this.set('playerHand', deck.dealPlayer());
      this.set('dealerHand', deck.dealDealer());
      this.get('playerHand').on('stand', (function(_this) {
        return function() {
          var dealerScore;
          _this.get('dealerHand').map(function(card) {
            if (card.get('revealed') === false) {
              return card.flip();
            }
          });
          dealerScore = _this.checkDealer();
          while (dealerScore < 17) {
            _this.get('dealerHand').hit();
            dealerScore = _this.checkDealer();
          }
          return _this.get('dealerHand').stand();
        };
      })(this));
      return this.get('dealerHand').on('stand', (function(_this) {
        return function() {
          if (_this.checkDealer() <= 21 && _this.checkPlayer() <= 21) {
            if (_this.checkDealer() < _this.checkPlayer()) {
              _this.trigger('win');
            }
            if (_this.checkDealer() >= _this.checkPlayer()) {
              return _this.trigger('lose');
            }
          }
        };
      })(this));
    };

    App.prototype.checkDealer = function() {
      var dealerScore;
      if ((this.get('dealerHand').scores()[1] != null) && this.get('dealerHand').scores()[1] < 21) {
        return dealerScore = this.get('dealerHand').scores()[1];
      } else {
        return dealerScore = this.get('dealerHand').scores()[0];
      }
    };

    App.prototype.checkPlayer = function() {
      var dealerScore;
      if ((this.get('playerHand').scores()[1] != null) && this.get('playerHand').scores()[1] < 21) {
        return dealerScore = this.get('playerHand').scores()[1];
      } else {
        return dealerScore = this.get('playerHand').scores()[0];
      }
    };

    App.prototype.refresh = function() {
      $('div').remove();
      return new AppView({
        model: new App()
      }).$el.appendTo('body');
    };

    return App;

  })(Backbone.Model);

}).call(this);

//# sourceMappingURL=App.map
