class ApplicationController < ActionController::Base
	before_filter :authorize
	
	before_filter :set_i18n_locale_from_params
	
	protect_from_forgery
  
	protected 
  
	def set_i18n_locale_from_params
		if params[:locale]
			if I18n.available_locales.include?(params[:locale].to_sym)
				I18n.locale = params[:locale]
			else
				flash.now[:notice] = 
					"#{params[:locale]} translation not available"
				logger.error flash.now[:notice]
			end
		end
	end
  
	def default_url_options
		{:locale => I18n.locale}
	end
  
  private
	def current_cart
		Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		if 	cart = Cart.first
		else 
			cart = Cart.create
		end
		session[:cart_id] = cart.id
		cart
	end
  protected
	def authorize
		unless User.find_by_id(session[:user_id])
			redirect_to login_url, :notice => "Please Log In"
		end
	end
end
