require 'faker'
require 'date'

namespace :warehouse do
    desc "Transfer data to warehouse"
    task :import => :environment do
        puts "Import started"

        WarehouseRecord.connection.execute("TRUNCATE fact_quotes")
        
        # FactQuote.delete_all
        Quote.all.each do |quote|
            FactQuote.create!(
                quote_id: quote.id,
                creation_date: quote.created_at,
                company_name: quote.company_name,
                email: quote.email,
                num_elevators: quote.required_shafts
            )
        end
        puts "Quotes Imported"
        
        WarehouseRecord.connection.execute("TRUNCATE fact_contacts")

        # FactContact.delete_all
        Lead.all.each do |lead|
            FactContact.create!(
                contact_id: lead.id,
                creation_date: lead.created_at,
                company_name: lead.company_name,
                email: lead.email,
                project_name: lead.project_name
            )
        end
        puts "Leads Imported"
        
        WarehouseRecord.connection.execute("TRUNCATE fact_elevators")

        # FactElevator.delete_all
        Elevator.all.each do |elevator|
            FactElevator.create!(
                serial_number: elevator.serial_number,
                commission_date: elevator.date_of_commissioning,
                building_id: elevator.column.battery.building_id,
                customer_id: elevator.column.battery.building.customer_id,
                building_city: elevator.column.battery.building.address.city
            )
        end
        puts "Elevators Imported"

        WarehouseRecord.connection.execute("TRUNCATE dim_customers")

        # DimCustomer.delete_all
        Customer.all.each do |customer|
            numElevators = 0
            
            customer.buildings.all.each do |building|
            # byebug #debugger
            building.batteries.all.each do |battery|
                battery.columns.all.each do |column|
                    numElevators += column.elevators.count
                    end # Column
                end #B attery
            end # Building
            
            DimCustomer.create!(
                creation_date: customer.customers_creation_date,
                company_name: customer.company_name,
                company_contact: customer.full_name_of_company_contact,
                company_email: customer.email_of_company_contact,
                nb_elevators: numElevators,
                customer_city: customer.address.city
            )
        end # Customer
        puts "Customers Imported"

        puts "Import Ended"
    end # task

    desc "Describes past interventions that have been done on either a battery, a column or an elevator. Each entry tells us what has been done during the intervention, in which building, by whom, when, etc."
    task :intervention => :environment do
        puts "Interventions Started"

        WarehouseRecord.connection.execute("TRUNCATE fact_interventions")

        Building.all.each do |building|
            building.batteries.all.each do |battery|
                # Grab All The Batteries
                if (battery.status === "Intervention")
                    status = ["Pending", "InProgress", "Interrupted", "Resumed", "Complete"].sample
                    start_date = nil
                    end_date = nil
                    result = nil

                    if status != "Pending"
                        start_date = Faker::Date.between(from: '2019-01-01', to: Date.today)
                        result = "Incomplete"

                        if (status == "Complete")
                            result = ["Success", "Failure"].sample
                            end_date = Faker::Date.between(from: start_date, to: Date.today)

                            if (result == "Failure")
                                battery.status = "Inactive"
                            else
                                battery.status = "Active"
                            end
                        end
                    end

                    FactIntervention.create!(
                        employee_id: battery.employee_id,
                        building_id: building.id,
                        battery_id: battery.id,
                        column_id: nil,
                        elevator_id: nil,
                        start_date: start_date,
                        end_date: end_date,
                        result: result,
                        report: Faker::Lorem.unique.paragraph,
                        status: status
                    )
                end

                #Grab All The Columns
                battery.columns.all.each do |column|
                    if (column.status === "Intervention")
                        status = ["Pending", "InProgress", "Interrupted", "Resumed", "Complete"].sample
                        start_date = nil
                        end_date = nil
                        result = nil

                        if status != "Pending"
                            start_date = Faker::Date.between(from: '2019-01-01', to: Date.today)
                            result = "Incomplete"

                            if (status == "Complete")
                                result = ["Success", "Failure"].sample
                                end_date = Faker::Date.between(from: start_date, to: Date.today)

                                if (result == "Failure")
                                    column.status = "Inactive"
                                else
                                    column.status = "Active"
                                end
                            end
                        end

                        FactIntervention.create!(
                            employee_id: battery.employee_id,
                            building_id: building.id,
                            battery_id: nil,
                            column_id: column.id,
                            elevator_id: nil,
                            start_date: start_date,
                            end_date: end_date,
                            result: result,
                            report: Faker::Lorem.unique.paragraph,
                            status: status
                        )
                    end

                    column.elevators.all.each do |elevator|
                        if (elevator.status === "Intervention")
                            status = ["Pending", "InProgress", "Interrupted", "Resumed", "Complete"].sample
                            start_date = nil
                            end_date = nil
                            result = nil

                            if status != "Pending"
                                start_date = Faker::Date.between(from: '2019-01-01', to: Date.today)
                                result = "Incomplete"

                                if (status == "Complete")
                                    result = ["Success", "Failure"].sample
                                    end_date = Faker::Date.between(from: start_date, to: Date.today)

                                    if (result == "Failure")
                                        elevator.status = "Inactive"
                                    else
                                        elevator.status = "Active"
                                    end
                                end
                            end

                            FactIntervention.create!(
                                employee_id: battery.employee_id,
                                building_id: building.id,
                                battery_id: nil,
                                column_id: nil,
                                elevator_id: elevator.id,
                                start_date: start_date,
                                end_date: end_date,
                                result: result,
                                report: Faker::Lorem.unique.paragraph,
                                status: status
                            )
                        end
                    end # column.elevators.all.each
                end # battery.columns.all.each
            end # building.batteries.all.each
        end # Buildings.all.each

        puts "Interventions Ended"
    end # task

end # namespace