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


#####################################################
puts "Seed Ended"