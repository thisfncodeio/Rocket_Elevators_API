class LeadsController < ApplicationController
        
    # POST /quotes or /quotes.json
    def create
        
        @lead = Lead.new(lead_params)
        
        # encoded_files = Base64.encode64(params[:lead][:files].read)
        # @lead.files = encoded_files

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
     # AFTER FORM SUBMISSION LOGIC (submission alert, redirecting, rendering, errors) 
     #===================================================================================================
        if attachment == nil
            puts "this is nil, tough luck"
        
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
        params.required(:leads).permit(:full_name_of_contact, :company_name, :email, :phone, :project_name, :project_description, :department_in_charge_of_elevators, :message, :attachment)
    end

end