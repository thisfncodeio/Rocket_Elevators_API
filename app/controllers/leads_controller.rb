class LeadsController < ApplicationController
        
    # POST /quotes or /quotes.json
    def create
        
        @lead = Lead.new(lead_params)
        
     #===================================================================================================
     # DECLARING VARIABLES  
     #===================================================================================================
        attachment = params["attachment"]
        @lead.file_name = attachment
     
     #===================================================================================================
     # SAVER  
     #===================================================================================================
        @lead.save

     #===================================================================================================
     # PRINTS PARAMS INTO TERMINAL WINDOW
     #===================================================================================================
        puts "===========START================"
        puts params
        puts "=============END================"

     #===================================================================================================
     # FORM SUBMISSION & FILE ATTACHMENT LOGIC (converts into binary code, submission alert, redirecting, rendering, errors) 
     #===================================================================================================
        if attachment == nil
            #If var attachment held no value then it would print below into terminal:
            puts "this is nil, tough luck"
            
            #Otherwise if it does hold some sort of value then it will do below instead:
            if not nil 
                @lead.file = attachment.read
                @lead.file_name = attachment.original_filename
            end
        end  
        
        if @lead.save!
            redirect_back fallback_location: root_path, notice: "Your Request was successfully created and sent!"
        end    
    end    
     #===================================================================================================
     # DEFINING @lead = Lead.new(lead_params) BELOW:
     #===================================================================================================

     # Only allow a list of trusted parameters through.
    def lead_params
        params.required(:leads).permit(
            :full_name_of_contact, 
            :company_name, 
            :email, 
            :phone, 
            :project_name, 
            :project_description, 
            :department_in_charge_of_elevators, 
            :message, 
            :attachment
        )
    end
end