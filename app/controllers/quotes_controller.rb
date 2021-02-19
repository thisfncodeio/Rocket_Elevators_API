class QuotesController < ApplicationController
  skip_before_action :verify_authenticity_token
 
  # # GET /quotes or /quotes.json
  # def index
  #   @quotes = Quote.all
  # end

  # # GET /quotes/1 or /quotes/1.json
  # def show
  # end

  # # GET /quotes/new
  # def new
  #   @quote = Quote.new
  # end

  # # GET /quotes/1/edit
  # def edit
  # end

  # POST /quotes or /quotes.json
  def create
    puts "===========START================"
    puts "USERS ID IS: #{current_user.id}"
    puts "=============END=============="
    # SETUP VARIABLES
    # Building Type
    building_type = params["buildType"]
    
    # Residential
    residential_floors = params["floors_residential"]
    residential_apartments = params["apartments-residential"]
    residential_basements = params["basements-residential"]

    # Commercial
    commerical_commerce = params["commerce-commercial"]
    commerical_floors = params["floors-commercial"]
    commerical_basements = params["basements-commercial"]
    commerical_parking = params["parking-commercial"]
    commerical_elevators = params["elevators-commercial"]

    # Corporate
    corporate_commerce = params["commerce-corporate"]
    corporate_floors = params["floors-corporate"]
    corporate_basements = params["basements-corporate"]
    corporate_parking = params["parking-corporate"]
    corporate_occupants = params["occupants-corporate"]
    
    # Hybrid
    hybrid_businesses = params["businesses-hybrid"]
    hybrid_floors = params["floors-hybrid"]
    hybrid_basements = params["basements-hybrid"]
    hybrid_parking = params["parking-hybrid"]
    hybrid_occupants = params["occupants-hybrid"]
    hybrid_activity = params["activity-hybrid"]

    # Product Line - Value will either be 1, 2, or 3
    product_line = params["radio-btn"]

    # Recommendations
    # number_of_columns = params[]
    # number_of_elevator_shafts = params[]

    # Cost
    # cost = params[]
    # installation = params[]
    # total = params[]

    prefix = params["titles"]
    full_name = params["name"]
    email = params["email"]
    
    @quote = Quote.new(quote_params)

    @quote.prefix = prefix
    @quote.full_name = full_name
    @quote.email = email

    if product_line == "1"
      @quote.product_line = "7565"
    elsif product_line == "2"
      @quote.product_line = "12345"
    else
      @quote.product_line = "15400"
    end

    @quote.building_type =  building_type

    @quote.installation_fee = 
    @quote.sub_total = 
    @quote.total = 

    @quote.required_columns = 
    @quote.required_shafts = 

    if @building_type == "residential" 
      @quote.num_of_floors = residential_floors
      @quote.num_of_apartments = residential_apartments
      @quote.num_of_basements = residential_basements
    end

    if @building_type == "commercial" 
      @quote.num_of_distinct_businesses = commerical_commerce
      @quote.num_of_floors = commerical_floors
      @quote.num_of_basements = commerical_basements
      @quote.num_of_parking_spots = commerical_parking
      @quote.num_of_elevator_cages = commerical_elevators
    end

    if @building_type == "corporate"
      @quote.num_of_distinct_businesses = corporate_commerce
      @quote.num_of_floors = corporate_floors
      @quote.num_of_basements = corporate_basements
      @quote.num_of_parking_spots = corporate_parking
      @quote.num_of_occupants_per_Floor = corporate_occupants
    end

    if @building_type == "hybrid"
      @quote.num_of_distinct_businesses = hybrid_businesses
      @quote.num_of_floors = hybrid_floors
      @quote.num_of_basements = hybrid_basements
      @quote.num_of_parking_spots = hybrid_parking
      @quote.num_of_occupants_per_Floor = hybrid_occupants
      @quote.num_of_activity_hours_per_day = hybrid_activity
    end
    
    @quote.user = current_user
    @quote.save!

    # respond_to do |format|
    #   if @quote.save
    #     format.html { redirect_to @quote, notice: "Your Quote was successfully created and sent!" }
    #     format.json { render :show, status: :created, location: @quote }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @quote.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # # PATCH/PUT /quotes/1 or /quotes/1.json
  # def update
  #   respond_to do |format|
  #     if @quote.update(quote_params)
  #       format.html { redirect_to @quote, notice: "Quote was successfully updated." }
  #       format.json { render :show, status: :ok, location: @quote }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @quote.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /quotes/1 or /quotes/1.json
  # def destroy
  #   @quote.destroy
  #   respond_to do |format|
  #     format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_quote
  #     @quote = Quote.find(params[:id])
  #   end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.fetch(:quote, {})
    end
end
