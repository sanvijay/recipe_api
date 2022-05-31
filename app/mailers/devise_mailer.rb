class DeviseMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    mail = super
    mail.subject = "Confirmation instructions for Ku-ky app"
    mail
  end

  def reset_password_instructions(record, token, opts = {})
    mail = super
    mail.subject = "Reset password instructions for Ku-ky app"
    mail
  end
end
