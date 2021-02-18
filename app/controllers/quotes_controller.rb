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
    building_type = params["building_id"]

    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: "Your Quote was successfully created and sent!" }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end

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
