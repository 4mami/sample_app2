class ApplicationController < ActionController::Base
    include SessionsHelper

    private
        def logged_in_user
            # application_controllerでsessions_helperをインクルードしてるので、「logged_in?」が使える
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
end
