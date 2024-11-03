class AdminMailer < ApplicationMailer
  def new_booking(booking)
    @booking = booking
    mail(to: Rails.application.credentials.admin_email, subject: "New booking - $#{@booking.total_amount} for #{@booking.nights} nights")
  end

  def error(subject, context = nil)
    @context = context
    mail(to: Rails.application.credentials.admin_email, subject: subject)
  end
end
