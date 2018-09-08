class CheckoutForm {

  static cardswipe(data){
    new CheckoutForm().cardswipe(data)
  }

  cardswipe(data){
    this.numberField().val(data.account)
    this.expiryField().val(`$(data.expMonth)/$(data.expYear)`)
    this.cvcField().focus()
  }

  format(data){
    this.numberField().payment("formatCardNumber")
    this.expiryField().payment("formatCardExpiry")
    this.cvcField().payment("formatCardCVC")
    this.disableButton()
  }

  form(){ return $("#payment.form") }

  validFields(){}

  numberField(){}

  expiryField(){}

  cvcField(){}

  displayStatus(){}
}


