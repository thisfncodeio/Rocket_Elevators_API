class LeadsController < ApplicationController
        
    # POST /quotes or /quotes.json
    def create
     #===================================================================================================
     # PRINTS PARAMS INTO TERMINAL WINDOW
     #===================================================================================================
   
        puts "===========START================"
        puts params
        puts "=============END================"

     #===================================================================================================
     # SETUP VARIABLES BELOW
     #===================================================================================================
        
      # Full Name:
    #   full_name = params["lead[full_name]"]

    #   # Email Address:
    #   email_address = params["contact[email][required]"]

      # Phone:
      phone = params["contact[phone]"]

    #   # Company Name:
    #   company_name = params["contact[enterprise_name][required]"]

    #   # Project Name:
    #   project_name = params["contact[project_name][required]"]

    #   # Project Description:
    #   project_description = params["contact[description][required]"]

    #   # Department In Charge Of Elevators:
    #   department_in_charge_of_elevators = params["contact[department]"]

    #   # Message:
    #   message = params["contact[message]"]

      # Attached Binary File:


      # Date Of Contact Request:
      # This information is stored automatically once a user submits their contact us form..
        
     #===================================================================================================
     # SETUP OF LOGIC 
     #===================================================================================================

      @lead = Lead.new(lead_params)

    #   @lead.full_name_of_contact = full_name

    #   @lead.email = email_address

    #   @lead.company_name = company_name

      @lead.phone = phone 
      #Dont uncomment otherwise the form will bug you since it's html input tag has a required attribute

    #   @lead.project_name = project_name

    #   @lead.project_description = project_description

    #   @lead.department_in_charge_of_elevators = department_in_charge_of_elevators

    #   @lead.message = message

      @lead.save!

     #===================================================================================================
     # AFTER FORM SUBMISSION LOGIC (submission alert, redirecting, rendering, errors) 
     #===================================================================================================

        if @lead.save!
            redirect_back fallback_location: root_path, notice: "Your Request was successfully created and sent!"
        end    
    end    

     #===================================================================================================
     # DEFINING @lead = Lead.new(lead_params) BELOW:
     #===================================================================================================

     # Only allow a list of trusted parameters through.
    def lead_params
        params.permit(:full_name_of_contact, :email, :phone, :company_name, :project_name, :project_description, :department_in_charge_of_elevators, :message)
    end
end