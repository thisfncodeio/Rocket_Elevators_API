class InterventionsController < ApplicationController
  before_action :set_intervention, only: %i[ show edit update destroy ]

  # GET /interventions or /interventions.json
  def index
  end

  # GET /interventions/1 or /interventions/1.json
  def show
  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions or /interventions.json
  def create
    # @intervention = Intervention.new(intervention_params)
    @intervention = Intervention.new

    @intervention.author = current_user.employee.id
    @intervention.customer_id = params[:customers]
    @intervention.building_id = params[:buildings]
    @intervention.battery_id = params[:batteries] unless params[:columns] != ""
    @intervention.column_id = params[:columns] unless params[:elevators] != ""
    @intervention.elevator_id = params[:elevators]
    @intervention.employee_id = params[:employees]

    if @intervention.save!
      redirect_back fallback_location: root_path, notice: "Intervention Successful"
    end

    # respond_to do |format|
    #   if @intervention.save
    #     format.html { redirect_to @intervention, notice: "Intervention was successfully created." }
    #     format.json { render :show, status: :created, location: @intervention }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @intervention.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /interventions/1 or /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to @intervention, notice: "Intervention was successfully updated." }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1 or /interventions/1.json
  def destroy
    @intervention.destroy
    respond_to do |format|
      format.html { redirect_to interventions_url, notice: "Intervention was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_buildings
    puts params[:customer_id]
    @buildings = Building.where(customer_id: params[:customer_id])

    respond_to do |format|
      format.json {render :json => @buildings}
    end
  end

  def get_batteries
    puts params[:building_id]
    @batteries = Battery.where(building_id: params[:building_id])

    respond_to do |format|
      format.json {render :json => @batteries}
    end
  end

  def get_columns
    puts params[:battery_id]
    @columns = Column.where(battery_id: params[:battery_id])

    respond_to do |format|
      format.json {render :json => @columns}
    end
  end

  def get_elevators
    puts params[:column_id]
    @elevators = Elevator.where(column_id: params[:column_id])

    respond_to do |format|
      format.json {render :json => @elevators}
    end
  end

  def course_search
    puts "Whatever"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_intervention
    @intervention = Intervention.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def intervention_params
    params.require(:intervention).permit(:author, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :start_date, :end_date, :result, :report, :status)
  end
end













