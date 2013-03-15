$(function() {

  $.externalScript('https://js.stripe.com/v1/').done(function(script, textStatus) {

      $('input.credit-card-number').payment('formatCardNumber');
      $('input.cvv').payment('formatCardCVC')

      Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

      var subscription = {
        setupForm: function() {
          return $('form.signup_form').submit(function(e) {
            $('input[type=submit]').prop('disabled', true).val('Processing...');
            if ($('#credit_card_number').length) {
              subscription.processCard();
              return false;
            } else {
              return true;
            }
          });
        },
        processCard: function() {
          var card;
          card = {
            name: $('.first-name').val() + ' ' + $('.last-name').val(),
            number: $('#credit_card_number').val(),
            cvc: $('#cvv').val(),
            expMonth: $('#_expiry_date_2i').val(),
            expYear: $('#_expiry_date_1i').val()
          };
          return Stripe.createToken(card, subscription.handleStripeResponse);
        },
        handleStripeResponse: function(status, response) {
          if (status === 200) {
            $('#subscription_user_attributes_stripe_token').val(response.id)
            $('form.signup_form')[0].submit()
          } else {
            $('#stripe-error').fadeIn('fast').text(response.error.message).show();
            return $('input[type=submit]').prop('disabled', false).val('Sign up');
          }
        }
      };
      return subscription.setupForm();
  });
});