CashFlow
========================

A simple interface for creating and managing Stripe subscriptions.  Stripe is awesome, but it's not possible to use out of the box to start charges clients (you need a domain and payment interface).  CashFlow is a simple solution, perfect for freelancers who need to sign up customers for a recurring plan.  Simply clone and setup your own payment app.

Getting Started
----------------

You'll need a domain with ssl (https) for the payment page.  The easiest way is to get started is to deploy to Heroku (where you can piggyback on their ssl - yourapp.herokuapp.com)

Where credit is due
----------------

This app is based off of the Rails Stripe Membership Saas app.  

Rails Stripe Membership Saas

https://github.com/railsapps/rails-stripe-membership-saas

Devise

http://github.com/plataformatec/devise

CanCan

https://github.com/ryanb/cancan

Stripe

https://stripe.com/
________________________

MIT License

http://www.opensource.org/licenses/mit-license