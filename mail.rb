# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

    params = Lead.new(lead_params)
    email = params[:email]
    from = Email.new(email: 'jay-t-dot-2k@gmail.com')
    to = Email.new(email: email)
    subject = 'Sending with SendGrid is Fun'
    content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    mail = Mail.new(from, subject, to, content)
    personalization = Personalization.new
    personalization.add_to(Email.new(email: 'jay-t-dot-2k@hotmail.com'))
    mail.add_personalization(personalization)
    mail.template_id = 'd-8f34084713894cdfa0ddfb0625bb19fb'
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
 