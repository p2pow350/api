task check_hour_traffic_quality: :environment do
  p Time.now.to_s + " - Task: Check Traffic Quality.."
  
  @date_from=1.hours.ago.strftime("%m/%d/%Y %H:%M")
  @date_to=Time.now.strftime("%m/%d/%Y %H:%M")
  
  @body = Sonus.DestinationClient(@date_from, @date_to)
  ['mvar78@gmail.com', 'dario.ceccaroni@areaattiva.it']
  AlertMailer.alert(@date_from, @date_to, ['mvar78@gmail.com', 'dario.ceccaroni@areaattiva.it'] , "Quality Alert", @body).deliver_now
end


task check_today_traffic_quality: :environment do
  p Time.now.to_s + " - Task: Check Daily Traffic Quality.."
  
  @date_from=Time.now.strftime("%m/%d/%Y 00:00")
  @date_to=Time.now.strftime("%m/%d/%Y 23:59")
  
  @body = Sonus.DestinationClient(@date_from, @date_to)
  AlertMailer.alert(@date_from, @date_to, ['mvar78@gmail.com', 'dario.ceccaroni@areaattiva.it'] , "Traffic Report", @body).deliver_now
end


task check_yesterday_traffic_quality: :environment do
  p Time.now.to_s + " - Task: Check Daily Traffic Quality.."
  
  @date_from=1.day.ago.strftime("%m/%d/%Y 00:00")
  @date_to=1.day.ago.strftime("%m/%d/%Y 23:59")
  
  @body = Sonus.DestinationClient(@date_from, @date_to)
  AlertMailer.alert(@date_from, @date_to, ['mvar78@gmail.com', 'dario.ceccaroni@areaattiva.it'] , "Traffic Report", @body).deliver_now
end