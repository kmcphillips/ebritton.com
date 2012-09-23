# Used to reset your password in ActiveAdmin/Devise
if Rails.env.production?
  ActionMailer::Base.smtp_settings = {address: 'localhost', :openssl_verify_mode  => 'none'}
end
