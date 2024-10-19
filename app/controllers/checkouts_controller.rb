class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

    course = Course.find(params[:course_id])

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: [{
        price: course.stripe_price_id,
        quantity: 1,
      }],
      success_url: request.base_url + "/courses/#{course.id}/success",  # Corrected spelling of 'success_url'
      cancel_url: request.base_url + "/courses/#{course.id}/cancel",    # Added '/cancel' to the URL for clarity
      automatic_tax: { enabled: true },
      customer_email: current_user.email,
      metadata: { course_id: course.id }
    )

    redirect_to session.url, allow_other_host: true  # Fixed typo here
  end
end
