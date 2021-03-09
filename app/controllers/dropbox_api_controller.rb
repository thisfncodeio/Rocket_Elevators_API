class DropboxApiController < ApplicationController
   def callbackAuth
    client = DropboxApi::Client.new(ENV["DROPBOX_TOKEN"])
    client_key = ENV["DROPBOX_KEY"]
    client_secret = ENV["DROPBOX_SECRET"]

    path= "/" + $company_name.to_s + ""
    file_path = path + "/" + $attachment.to_s
    DropboxApi::Authenticator.new(client_key, client_secret)
    client.create_folder path
    client.upload file_path, IO.read File.join(Rails.root, 'public', $attachment.to_s)
    redirect_to '/#contact'

    

   end
end
