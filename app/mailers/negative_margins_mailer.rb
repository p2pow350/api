class NegativeMarginsMailer < ApplicationMailer
  default from: Option.where(o_key: 'user_name').pluck(:value)[0]
	  
  def negative_margins(date_from, date_to, mail_to, subject, body)
  	@date_from = date_from  
  	@date_to = date_to
  	@body = body
    mail(to: mail_to, subject: subject)
  end	  
	
end