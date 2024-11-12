class WebhooksController < ApplicationController
    skip_forgery_protection

    def stripe
        stripe_secret_key = Rails.application.credentials.dig(:stripe, :secret_key)
        Stripe.api_key = stripe_secret_key
        payload = request.body.read 
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    event = nil

    begin 
        event = Stripe::webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParseError => e
        puts "Webhook signature verification failed."
        status 400
        return
    end

    case event.type
    when "checkout.session.completed"
     session = event.data.object

     full_session = Stripe::Checkout::Session.retrieve({
        id: session.id,
        expand: ['line_items'],
     })

     line_items = full_seesion.line_items
     puts "session: #{session}"
     puts "line_items: #{line_items}"
     course_id = session.metadata.course_id
     course = Course.find(course_id)
     user = User.find_by!(email: session_customer_email)

     CourseUser.create!(course: course, user: user)
    else
      puts "Unhandle event type: #{event.type}"
    end

    render json: { message: 'success' }
  end 
end
