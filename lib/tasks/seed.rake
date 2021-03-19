require 'faker'

namespace :seed do
    desc "Add Customers to Leads table"
    task :leads => :environment do
        puts "Seed started"
        puts "Seeding Leads"
        Lead.delete_all

        id = 0;

        300.times do
          # if id <= 50
            randomNum = rand(1..10)
            isCustomer = false;
            
            if randomNum <= 1
              isCustomer = true
              id += 1
            end
          # end

          ext = ['zip', 'pdf', 'jpg', 'png', 'txt']
          
          Lead.create!({
            full_name_of_contact: Faker::Name.name,
            company_name: Faker::Company.name,
            email: Faker::Internet.email,
            phone: Faker::PhoneNumber.unique.cell_phone,
            project_name: Faker::Lorem.sentence(word_count: 2),
            project_description: Faker::Lorem.unique.sentence,
            department_in_charge_of_elevators: [:Sales, :Support, :Administration].sample,
            message: Faker::Lorem.unique.paragraph,
            file_name: Faker::File.file_name(dir: 'foo/bar', name: 'contact', ext: ext.sample),
            created_at: Faker::Date.between(from: '2018-02-23', to: Date.today),
            customer_id: isCustomer ? id : nil
          })
            
          isCustomer = false
        end



        puts "Seed Ended"
    end # task
end # namespace