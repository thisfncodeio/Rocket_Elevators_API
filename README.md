<p align='center'><img src="https://raw.githubusercontent.com/thisfncodeio/Rocket_Elevators_API/readmeTemplate/public/apiteam1logo.jpg"></p>

---

# Project Description
To collaborate and take advantage of 7 different API's which will include:
   <ul>
      <li>Google Maps</li>
      <li>Twilio</li>
      <li>Slack</li>
      <li>DropBox</li>
      <li>SendGrid</li>
      <li>IBM Watsom</li>
      <li>ZenDesk</li>
   </ul>
   
---

Gems used:

```
gem 'figaro'
gem 'geocoder'
gem 'gmaps4rails'
gem 'sendgrid-ruby'
gem 'twilio-ruby'
gem 'slack-notifier'
gem 'dropbox_api'
gem 'zendesk_api'

```

---

# Google Maps

<p>
The Google Maps API is known for its great maturity, performance and geospatial rendering capabilities. It can therefore be used as an extension within our secure back office (reserved for Rocket Elevators employees) in order to geolocate our customers on a map and display statistics on a location:
</p>
<ol>
   <li>Location of the Building</li>
   <li>Number of floors in the Building</li>
   <li>Client Name</li>
   <li>Number of Batteries</li>
   <li>Number of Columns</li>
   <li>Number of Elevators</li>
   <li>Full name of technical contacy</li>
</ol>

<p>
The geolocation page must be a page in the Admin section of the website, available only to authenticated members.
The addresses table of the database, if it is not already the case, must now include real addresses, geolocalizable by Google Maps.
</p>

---

# Twilio

<p>
Twilio’s API supports virtually all forms of communication within an application and allows integration of communications between diverse experiences regardless of the platforms on which they were built.
For Rocket Elevators, Twilio can be used to allow the platform to get in touch with the technicians in case of problems.
If the status of an Elevator in the database changes to "Intervention" status, the building's technical contact must be identified and an SMS must be sent to the telephone number associated with this contact.
In this case, the designated contact must be the coach assigned to each team, and he must receive the alerts on his mobile phone.
</p>

---

# Slack

<p>
The Slack API is very open and flexible, thus Rocket Elevators could greatly benefit from synergy between all of the company's collaborators. The Backoffice in particular may  be able to publish messages on Slack to leave written records and inform about certain events that occur through its infrastructure.
In the current use case, when a controller changes the status of an elevator, this status is reflected in the information system and persists in the operational database . When these status changes occur, a message is sent to the slack “elevator_operations” channel to leave a written record.
The written message must have the following format:
The Elevator [Elevator’s ID] with Serial Number [Serial Number] changed status from [Old Status] to [New Status]
</p>

---

# DropBox

<p>
Rocket Elevators must be able to archive their documents in the cloud and the Dropbox API and its online storage allows this to be done in a simple and flexible way while allowing access to the file from anywhere thanks to the multiple interfaces provided by Dropbox.
When a contact becomes a customer, that is to say when the “Customers” table in the information system can be linked to a record in the “Leads” table, which itself offers the possibility of uploading files in a binary field of the table, it is necessary to trigger an archiving procedure which:
<ol>
   <li>Connect to the Rocket Elevators Dropbox account</li>
   <li>Create a directory in DropBox on behalf of the current client if one does not already exist</li>
   <li>Extract the file stored in the binary field of the MySQL database</li>
   <li>Copy this file to the client DropBox directory</li>
   <li>If the document is successfully downloaded to Dropbox, the controller deletes the content of the binary field from the database to avoid duplication</li>
</ol>
</p>

---

# Sendgrid

<p>
Sendgrid is a historic and essential service provider in the field of email communication. It allows emails to be sent to a base of users who have authorized transactional communications at the time of their registration (Opt-in). Sendgrid builds on a solid reputation as an email processor that guarantees delivery and favorable classification of emails to major suppliers like Google, Microsoft and Yahoo.
The Rocket Elevators Table Customers database contains many emails, and Sendgrid is a service that can be used to send communications based on key events that occur during system operations. information.
For Rocket Elevators, one use case to implement is sending a thank you email automatically when a contact completes the "Contact Us" form on the Rocket Elevators website. The form is saved with the email field to use. When saving to the database, a transactional thank-you email must be sent with the text below:
Greetings [Full Name]
We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project [Project Name].
A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.
We’ll Talk soon
The Rocket Team
The email must also contain the logo and overall design of Rocket Elevators.
</p>

---

# IBM Watsom

<p>
IBM through its Artificial Intelligence Watson provides application developers with many services. Among the most used, there is a Text-to-Speech functionality which can be used on a multitude of platforms.
Rocket Elevators wants to add text-to-speech functionality to their Home Dashboard (/ admin). We must have the option to start the briefing every time the Admin Dashboard page appears.
The type of information that speech synthesis allows are the following:
<ol>
   <li>Greetings to the logged users</li>
   <li>There are currently XXX elevators deployed in the XXX buildings of your XXX customers</li>
   <li>Currently, XXX elevators are not in Running Status and are being serviced</li>
   <li>You currently have XXX quotes awaiting processing</li>
   <li>You currently have XXX leads in your contact requests</li>
   <li>XXX Batteries are deployed across XXX cities</li>
</ol>
</p>

---

# ZenDesk

<p>
When the time comes to deliver quality customer service, managing customer requests should never leave a contact unanswered and ensure reasonable processing times. This is often the first of future customers.
Rocket Elevators is no exception to this reality and must follow up on each contact regardless of its origin and to do this, it is possible to rely on a massively adopted market tool: ZenDesk. ZenDesk is a SaaS platform to which you can subscribe and which allows you to manage the workflow that takes place when a customer comes into contact via the Website either via the “Contact Us” form or also via the “Get a Quote” form. ”In both cases, a ticket must be created in ZenDesk in the same way as a recording is added in the information system.
The ZenDesk platform can be powered by a call to the API and the software can then process requests depending on the type.
<ol>
   <li>The website's “Contact Us” form creates a new “Question” type ticket in ZenDesk</li>
   <li>The website's “Get a Quote” form creates a new “Task” type ticket in ZenDesk</li>
   <li>The tickets created are visible in the ZenDesk Console and it is possible to respond to them or even manage a workflow for these contacts.</li>
</ol>

The content of each ticket created must include the contact information which has been stored in the database:
Subject: [Full Name] from [Company Name]
Comment: The contact [Full Name] from company [Company Name] can be reached at email  [E-Mail Address] and at phone number [Phone]. [Department] has a project named [Project Name] which would require contribution from Rocket Elevators. 
[Project Description]
Attached Message: [Message]
The Contact uploaded an attachment
</p>

<h2>Explanation:</h2>
<p>
   The ZenDesk API is what we'll be communicating with when a user fills out a contact or quote form.  Not only will that information be sent to our Admin/Backoffice page, but it'll also be sent to the admin page of zendesk.com, where you can view, edit and respond to users who filled out the form on the Rocket Elevators page.  After making an account with zendesk, it was just a matter of finding the 'zendesk_api' gem and implementing that in our code:
   
   ```ruby
   client = ZendeskAPI::Client.new do |config|
      config.url = ENV['ZENDESK_URL']
      config.username = ENV['ZENDESK_USERNAME']
      config.token = ENV['ZENDESK_TOKEN']
   end
   ```
   
All we're doing above is 'speaking' between Zendesk and our own code with some enviornment variables we set up in our application.yml file with the help of the 'figaro' gem.  Then, we simply create a ticket when our forms are filled out.  A Question ticket for Leads, and a Task ticket for Quotes:

```ruby
ZendeskAPI::Ticket.create!(client,
   :subject => " Our header or #{subject} line here."
   :comment => { :value => "And the body or #{message} here."}
```

In order to see the tickets on zendesk.com, you'll use the url of rocketelevatorscs.zendesk.com when signing in and type in the user name and password provided.

</p>

---

Rocket_Elevators_Information_System
🚀	Working with MVC (Model-View-Controller)	📈

Members of this week's team
Abdul Akeeb -
Ahsan Syed -
Cristiane Santiago -
Lionel Niyongabire -
Eric Moran
 
🎯 About
Week 4 - The main goal of this week is to transform the static site previously developed during the Genesis program and turn it into a web application on MVC (Model - View - Controller) foundations. The site must be in a state that allows you to create a new section that saves the Javascript form that calculates an estimate in the form of a purchase order.
Expanding the relational database model
Seeding data base with data NB: real address are used

Week 5 - During this week, participants are exposed to a more elaborate data model and must perform basic query exercises. They will be asked to create tables, alter them and extend the concepts managed by their information system.
Two types of databases will be requested for this exercise
a- A relational database
b- A data warehouse for decision-making
 
 
📌 Instructions to acces to the admin panel:

To login as Admin:
1. Navigation bar : My Account
2. Login
3. Username: admin@admin.com
4. Password: password

To login as Employee:
1. Username: Email of any employee
2. Password: codeboxx1
 
 
📌 Gems used:
1. gem 'bootstrap', '~> 5.0.0.beta1'
2. gem 'jquery-rails'
3. gem "font-awesome-rails"
4. gem 'devise'
5. gem 'rails_admin', '~> 2.0'
6. gem 'toastr-rails'
7. gem 'cancancan'
8. gem 'rails_admin_rollincode', '~> 1.0'
9. gem 'chartkick'
10. gem 'faker'
11. gem 'multiverse'
12. gem 'blazer'


📌 The queries in mysql:
1. Employee
2. Users
3. Quote
4. Address
5. Battery
6. Building
7. Building Details (Extention Building)
8. Column
9. Customer
10. Elevator
11. Lead

📌 The queries in postgres:
1. Fact Quote
2. Fact Contact
3. Fact Elevator
4. Dim Customer


📚 The three queries:

--How many contact requests are made per month?

SELECT to_char(creation_date, 'YYYY-MM') as "Month"
      ,count(contact_id) as ContactPerMonth
  FROM public.fact_contacts
 group by "Month"
 order by "Month" desc;

--How many bid solicitations are made per month?

SELECT to_char(creation_date, 'YYYY-MM') as "Month"
      ,count(quote_id) as QuotePerMonth
  FROM public.fact_quotes
 group by "Month"
 order by "Month" desc;

--How many elevators per customer do we have?

 SELECT customer_id as "Customer", count(id) as ElevPerCustomers
  FROM public.fact_elevators
 group by "Customer";


