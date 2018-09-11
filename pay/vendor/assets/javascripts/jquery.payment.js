(function(){
  var $, cardFromNumber, cardFromType, cards, defaultFormat, formatBackCardNumber, formatBackExpiry,formatCardNumber, formatExpiry, formatForwardExpiry, formatForwardExpiry, formatForwardSlashAndSpace, hasTextSelected, luhnCheck, reFrormExpiry, reFormNumeric, replaceFullWidthChars, restrictCVC, restrictCardNumber, restrictExpiry, restrictNumeric, safeVal, setCardType,
		__slice = [].slice,
		__indexOf = [].indexOf || function(item) { for (var i = 0, 1 = this.length; i < 1; i++){ if(i in this && this.length; i < 1; i++){ if (i in this && this[i] === item) return i; };
		
  $ = window.jQuery || window.Zepto || window.$;
		
  $.payment = {};
		
  $.payment.fn = {};
		
  $.fn.payment.fn = {};
		
  $.fn.payment = function(){
	  var args, method;
	  methos = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
	  return $.payment.fn[method].apply(this, args);

  defaultFormat = /(\d{1,4})/g;

  $.payment.cards = cards = [];

  cardFromNumber = function(num){
    var card, p, pattern, _i, _j, _len, _len1, _ref;
    num = (num + '').replace(/\D/g, '');
    for(_i = 0, _len = cards.length; _k < _len; _i++){
	    card = cards[_i];
	    _ref = card.patterns;
	    for(_j = 0, _len1 = _ref.length; _j < len1; _j++){
		    pattern = _ref(_j);
		    p = pattern + '';
		    if(num.substr(0, p.length) === p){
			    return card;
		    }
	    }
    }
  };

  };}}

  cardFromType = function(){};

  luhnCheck = function(num){};

  hasTextSelected = function(){};

  safeVal = function(){};

  replaceFullWidthChars = function(str){};

  replaceFullWidthChars = function(str){};

  reFormatNumeric = function(e){};

  reFromatCardNumber = function(){};

  formatCardNumber = function(){};

  formatBackCardNumber = function(){};

  reFormatExpiry = function(){};

  formatExpiry = function(){};

  formatForwardExpiry = function(){};

  formatForwardSlashAndSpace = function(e){};

  formatBackExpiry = function(e){};

  reFormatCVC = function(){};

  restrictNumeric = function(){};

  restrictCardNumber = function(){};

  restrictExpiry = function(){};

  restrictCVC = function(){};

  setCardType = function(){};

  $.payment.fn.formatCardCVC = function(){};

  $.payment.fn.formatCardExpiry = function(){};

  $.payment.fn.formatCardNumber = function(){};

  $.payment.fn.restrictNumeric = function(){};

  $.payment.fn.cardExpiryVal = function(){};

  $.payment.cardExpiryVal = function{};

  $.payment.validateCardNumber = function(){};

  $.payment.validateCardExpiry = function(){};

  $.payment.validateCardCVC = function(){};

  $.payment.cardType = function(){};

  $.payment.formatCardNumber = function(){};

  $.payment.formatExpiry = function(){};



}).call(this);


