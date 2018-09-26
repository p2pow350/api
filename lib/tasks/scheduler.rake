
task :check_hour_traffic_quality, [:frequency, :recipients] => [:environment] do |t, args|	
  gmt=(args.frequency.to_i+args.frequency.to_i)
  
  date_from=(gmt+args.frequency.to_i).minutes.ago.strftime("%m/%d/%Y %H:%M")
  date_to=(gmt).minutes.ago.strftime("%m/%d/%Y %H:%M")
  
  body = Sonus.DestinationClient(date_from, date_to)
  AlertMailer.alert(date_from, date_to, args.recipients , "Quality Alert", body).deliver_now
end

task :check_negative_margins, [:frequency, :recipients] => [:environment] do |t, args|
  @past_date=2.hours.ago
  @date_from=(@past_date-args.frequency.to_i.minutes).strftime("%m/%d/%Y %H:%M")
  @date_to=@past_date.strftime("%m/%d/%Y %H:%M")
  
  @body = Sonus.FinancialReportNegative(@date_from, @date_to)
  unless @body.empty? 
  	  NegativeMarginsMailer.negative_margins(@date_from, @date_to, args.recipients, "Negative Margins", @body).deliver_now
  end
end

task :check_today_traffic_quality, [:recipients] => [:environment] do |t, args|
  @date_from=Time.now.strftime("%m/%d/%Y 00:00")
  @date_to=Time.now.strftime("%m/%d/%Y 23:59")
  
  @body = Sonus.DestinationClient(@date_from, @date_to)
  AlertMailer.alert(@date_from, @date_to, ['noc@areaattiva.it', 'dario.ceccaroni@areaattiva.it'] , "Traffic Report", @body).deliver_now
end


task :check_yesterday_client_usage, [:recipients] => [:environment] do |t, args|
  @date_from=1.day.ago.strftime("%m/%d/%Y 00:00")
  @date_to=1.day.ago.strftime("%m/%d/%Y 23:59")
  
  @body = Sonus.FinancialReport_ClientUsage(@date_from, @date_to)
  ClientUsageMailer.client_usage(@date_from, @date_to, args.recipients, "Client Usage", @body).deliver_now
end

task :check_past_month_client_usage, [:recipients] => [:environment] do |t, args|
  @date_from=Date.today.at_beginning_of_month.last_month.strftime("%m/%d/%Y 00:00")
  @date_to=(Time.now - 1.month).at_end_of_month.strftime("%m/%d/%Y 23:59")
  
  @body = Sonus.FinancialReport_ClientUsage(@date_from, @date_to)
  ClientUsageMailer.client_usage(@date_from, @date_to, args.recipients , "Past Month Client Usage", @body).deliver_now
end
