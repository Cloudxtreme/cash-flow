$(function() {

  $.externalScript('https://js.stripe.com/v1/').done(function(script, textStatus) {

      $('input.credit-card-number').payment('formatCardNumber');
      $('input.cvv').payment('formatCardCVC')

      Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

      var victory_purchase = {
        setupForm: function() {
          return $('form.signup_form').submit(function(e) {
            $('input[type=submit]').prop('disabled', true).val('Processing...');
            if ($('#credit_card_number').length) {
              victory_purchase.processCard();
              return false;
            } else {
              return true;
            }
          });
        },
        processCard: function() {
          console.log('processing')
          var card;
          card = {
            name: $('.first-name').val() + ' ' + $('.last-name').val(),
            number: $('#credit_card_number').val(),
            cvc: $('#cvv').val(),
            expMonth: $('#_expiry_date_2i').val(),
            expYear: $('#_expiry_date_1i').val()
          };
          return Stripe.createToken(card, victory_purchase.handleStripeResponse);
        },
        handleStripeResponse: function(status, response) {
          if (status === 200) {
            console.log('RESPONSE')
            console.log(response)
            $('#victory_purchase_stripe_token').val(response.id)
            $('form.signup_form')[0].submit()
          } else {
            console.log('stripe error')
            $('#stripe-error').fadeIn('fast').text(response.error.message).show();
            return $('input[type=submit]').prop('disabled', false).val('Sign up');
          }
        }
      };
      return victory_purchase.setupForm();
  });
});