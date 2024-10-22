class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    course = Course.find(params[:course_id])

    if course.stripe_price_id.blank?
      flash[:error] = "The course price is not set."
      redirect_to courses_path and return
    end

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: [{
        price: course.stripe_price_id,
        quantity: 1,
      }],
      success_url: course_url(course),
      cancel_url: course_url(course),
      automatic_tax: {enabled: true},
      customer_email: current_user.email,
      metadata: { course_id: course.id }
    )

    redirect_to session.url, allow_other_host: true
  end
end
