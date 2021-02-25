# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee_list = [
  {
    first_name: "Nicolas",
    last_name: "Genest",
    title: "CEO",
    email: "nicolas.genest@codeboxx.biz"
  },
  {
    first_name: "Nadya",
    last_name: "Fortier",
    title: "Director",
    email: "nadya.fortier@codeboxx.biz"
  },
  {
    first_name: "Martin",
    last_name: "Chantal",
    title: "Director Assistant",
    email: "martin.chantal@codeboxx.biz"
  },
  {
    first_name: "Mathieu",
    last_name: "Houde",
    title: "Captain",
    email: "mathieu.houde@codeboxx.biz"
  },
  {
    first_name: "David",
    last_name: "Boutin",
    title: "Engineer",
    email: "david.boutin@codeboxx.biz"
  },
  {
    first_name: "Mathieu",
    last_name: "Lortie",
    title: "Engineer",
    email: "mathieu.lortie@codeboxx.biz"
  },
  {
    first_name: "Thomas",
    last_name: "Carrier",
    title: "Engineer",
    email: "thomas.carrier@codeboxx.biz"
  },
]

puts "Seed Started"
######################################################


employee_list.each do |employee|
  user = User.create!(
    email: employee[:email],
    password: "codeboxx1",
    employee_role: true,
    user_role: false
  )
  employee = Employee.create!(
    first_name: employee[:first_name],
    last_name: employee[:last_name],
    title: employee[:title],
    email: employee[:email],
    user: user
  )
end

puts "#{Employee.count} employees created"

### Seeding Users for presentation ###
User.create!(email: 'admin@admin.com', password: 'password', superadmin_role: 1, employee_role: 0, user_role: 0)
User.create!(email: 'employee@employee.com', password: 'password', superadmin_role: 0, employee_role: 1, user_role: 0)
User.create!(email: 'user@user.com', password: 'password', superadmin_role: 0, employee_role: 0, user_role: 1)



#-----------------------------------------------### Seeding Address ###-------------------------------------------------
# puts "Seeding Addresses"

# #Auxiliary address variables
# type_of_address = ["Billing", "Shipping", "Home", "Business"]
# status_type = ["Active", "Inactive"]
# entity_type = ["Building", "Customer"]


# CSV.foreach(Rails.root.join('db', 'Address.csv'), headers: true) do |row|
#     Address.create!(
#       type_of_address: type_of_address.sample, 
#       status: status_type.sample, 
#       entity: entity_type.sample, 
#       number_and_street: row['number_and_street'], 
#       suite_and_apartment: nil, 
#       city: row['city'],
#       postal_code: row['postal_code'], 
#       country: row['country'], 
#       notes: nil)
# end


#-----------------------------------------------### Seeding Quote ###-------------------------------------------------
puts "Seeding Quote"



#-----------------------------------------------### Quote Residential ###-------------------------------------------------

#  20.times do 
  
#    prefix: Faker::Name.prefix,
#    full_name: Faker::Name.name,
#    email: Faker::Internet.email,
#    type_service = product_line: [:Standard, :Premium, :Excelium].sample,
#    installation_fee: Faker::Commerce.price(range: 5000..50000.0),
#    sub_total: Faker::Commerce.price(range: 100000..1000000.0),
#    total: Faker::Commerce.price(range: 100000..1500000.0),
#    building_type: 'Residential',
#    numFloorRes = num_of_floors: Faker::Number.between(from: 5, to: 100),
#    numApartRes = num_of_apartments: Faker::Number.between(from: 10, to: 150),
#    numBasRes = num_of_basements: 0,

#    num_of_parking_spots: 0,
#    num_of_distinct_businesses: 0,
#    num_of_elevator_cages: 0,
#    num_of_occupants_per_Floor: 0,
#    num_of_activity_hours_per_day: 0,
#    required_columns: Faker::Number.between(from: 1, to: 5),
#    required_shafts: Faker::Number.between(from: 1, to: 10)

#  end


### Seeding Quotes ###
15.times do 
  Quote.create!({
    prefix: Faker::Name.prefix,
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    product_line: [:Standard, :Premium, :Excelium].sample,
    installation_fee: Faker::Commerce.price(range: 5000..50000),
    sub_total: Faker::Commerce.price(range: 100000..1000000.0),
    total: Faker::Commerce.price(range: 100000..1500000.0),
    building_type: [:Residential, :Commercial, :Corporate, :Hybrid].sample,
    num_of_floors: Faker::Number.between(from: 5, to: 100),
    num_of_apartments: Faker::Number.between(from: 10, to: 150),
    num_of_basements: Faker::Number.between(from: 3, to: 6),
    num_of_parking_spots: Faker::Number.between(from: 50, to: 250),
    num_of_distinct_businesses: Faker::Number.between(from: 1, to: 10),
    num_of_elevator_cages: Faker::Number.between(from: 4, to: 20),
    num_of_occupants_per_Floor: Faker::Number.between(from: 20, to: 150),
    num_of_activity_hours_per_day: Faker::Number.between(from: 8, to: 24),
    required_columns: Faker::Number.between(from: 1, to: 5),
    required_shafts: Faker::Number.between(from: 1, to: 10)
  })
end



#-----------------------------------------------### Seeding Quote ###-------------------------------------------------


10.times do 
  ### Seeding Users ###
  User.create!({
      email: Faker::Internet.unique.email, 
      password: 'password'
  })

  ### Seeding Leads ###
  Lead.create!({
        full_name_of_contact: Faker::Name.name,
        company_name: Faker::Company.name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number,
        project_name: Faker::Lorem.sentence(word_count: 2),
        project_description: Faker::Lorem.unique.sentence,
        department_in_charge_of_elevators: [:Sales, :Support, :Administration].sample,
        message: Faker::Lorem.unique.paragraph
    })
end



#------------------------------------------## Seeding Buildings ###---------------------------
puts "Seeding Building"

  currentBuilding = Building.create!({
    full_name_of_the_building_administrator: Faker::Name.name,
    email_of_the_administrator_of_the_building: Faker::Internet.email,
    phone_number_of_the_building_administrator: Faker::PhoneNumber.phone_number,
    full_name_of_the_technical_contact_for_the_building: Faker::Name.name,
    technical_contact_email_for_the_building: Faker::Internet.email,
    technical_contact_phone_for_the_building: Faker::PhoneNumber.phone_number
  
    })

#------------------------------------------## Seeding batteries ###---------------------------
puts "Seeding current Battery"
currentBattery = Battery.create!({
 building_type: currentBuildingDetails.building_type #thre is no building type in here
 status: [:Offline, :Online].sample,
 date_of_commissioning: Faker::Date.between(from: '2018-02-23', to: '2021-02-23'), #how are they counting the last three years
 date_of_last_inspection: Faker::Date.between(from: '2018-02-23', to: '2021-02-23'),
 certificate_of_operations: Faker::Lorem.sentence(word_count: 1), #don't know what to do here
 information: Faker::Lorem.unique.sentence,
 notes: Faker::Lorem.unique.paragraph

  })


  
#------------------------------------------## Seeding Column ###---------------------------
puts "Seeding current Column"
currentColumn= Column.create!({
  building_type: currentBuildingDetails.building_type #thre is no building type in here
  number_of_floors_served: Faker::Number.between(from: 5, to: 100),
  status: [:Offline, :Online].sample,
  information: Faker::Lorem.unique.sentence,
  notes: Faker::Lorem.unique.paragraph


  })






#####################################################
puts "Seed Ended"