class NotificationMailer < ApplicationMailer
  default from: "no-reply@strainla.com"

  def comment_added
   mail(to: "strainla.inc@gmail.com",
       subject: "A comment has been added to your place")
  end
end
