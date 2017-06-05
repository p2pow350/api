task check_hour_traffic_quality: :environment do
  @date_from=3.hours.ago.strftime("%m/%d/%Y %H:%M")
  @date_to=2.hours.ago.strftime("%m/%d/%Y %H:%M")
  
  @body = Sonus.DestinationClient(@date_from, @date_to)
  AlertMailer.alert(@date_from, @date_to, ['noc@areaattiva.it', 'dario.ceccaroni@areaattiva.it'] , "Quality Alert", @body).deliver_now
end

task check_negative_margins: :environment do
  @date_from=3.hours.ago.strftime("%m/%d/%Y %H:%M")
  @date_to=2.hours.ago.strftime("%m/%d/%Y %H:%M")
  
  @body = Sonus.FinancialReportNegative(@date_from, @date_to)
  unless @body.empty? 
  	  NegativeMarginsMailer.negative_margins(@date_from, @date_to, ['noc@areaattiva.it', 'dario.ceccaroni@areaattiva.it'] , "Negative Margins", @body).deliver_now
  end
  
end


task check_today_traffic_quality: :environment do
  @date_from=Time.now.strftime("%m/%d/%Y 00:00")
  @date_to=Time.now.strftime("%m/%d/%Y 23:59")
  
  @body = Sonus.DestinationClient(@date_from, @date_to)
  AlertMailer.alert(@date_from, @date_to, ['noc@areaattiva.it', 'dario.ceccaroni@areaattiva.it'] , "Traffic Report", @body).deliver_now
end

task check_yesterday_client_usage: :environment do
  @date_from=1.day.ago.strftime("%m/%d/%Y 00:00")
  @date_to=1.day.ago.strftime("%m/%d/%Y 23:59")
  
  @body = Sonus.FinancialReport_ClientUsage(@date_from, @date_to)
  ClientUsageMailer.client_usage(@date_from, @date_to, ['noc@areaattiva.it', 'andrea.cavaliere@areaattiva.it', 'dario.ceccaroni@areaattiva.it'] , "Client Usage", @body).deliver_now
end


# NOT YET USED
task check_yesterday_traffic_quality: :environment do
  p Time.now.to_s + " - Task: Check Daily Traffic Quality.."
  
  @date_from=1.day.ago.strftime("%m/%d/%Y 00:00")
  @date_to=1.day.ago.strftime("%m/%d/%Y 23:59")
  
  @body = Sonus.DestinationClient(@date_from, @date_to)
  AlertMailer.alert(@date_from, @date_to, ['noc@areaattiva.it', 'dario.ceccaroni@areaattiva.it'] , "Traffic Report", @body).deliver_now
end


