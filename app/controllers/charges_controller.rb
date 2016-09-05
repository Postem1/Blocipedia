class ChargesController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @user = current_user
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create( # rubocop:disable Lint/UselessAssignment
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 15_00,
      description: "Blocipedia Membership - #{current_user.email}",
      currency: 'usd'
    )

    @user.update_attributes(role: 'premium')
    flash[:notice] = "Thanks, #{current_user.email}! You can now edit and create private wikis."
    redirect_to root_path
    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: "Blocipedia Membership - #{current_user.email}",
      amount: 15_00
    }
  end
end
