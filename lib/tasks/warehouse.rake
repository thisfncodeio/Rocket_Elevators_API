namespace :warehouse do
    desc "Transfer data to warehouse"
    task :import => :environment do
        Quote.all.each do |quote|
            FactQuote.create!(
                quote_id: quote.id,
                creation_date: quote.created_at,
                company_name: quote.full_name,
                email: quote.email,
                num_elevators: quote.required_shafts
            )
        end
    end
    task :import => :environment do
        Lead.all.each do |lead|
            FactContact.create!(
                contact_id: lead.id,
                creation_date: lead.created_at,
                company_name: lead.company_name,
                email: lead.email,
                project_name: lead.project_name
            )
        end
    end
    task :import => :environment do
        Elevator.all.each do |elevator|
            FactElevator.create!(
                serial_number: elevator.serial_number,
                commission_date: elevator.date_of_commissioning,
                building_id: elevator.column.battery.building_id,
                customer_id: elevator.column.battery.building.customer_id,
                building_city: elevator.column.battery.building.address.city
            )
        end
    end
    task :import => :environment do
        Customer.all.each do |customer|
            
            DimCustomer.create!(
                creation_date: customer.customers_creation_date,
                company_name: customer.company_name,
                company_contact: customer.full_name_of_company_contact,
                company_email: customer.email_of_company_contact,
                nb_elevators: 
                customer_city: customer.address.city
            )
end