require 'rufus-scheduler'

#scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")
scheduler = Rufus::Scheduler.singleton

# every hour - Mon-Tue (10:00 to 19:00)
scheduler.cron '0 10-19/1 * * 1-5' do
	# do stuff
	system("rake check_hour_traffic_quality")
end

# every morning
scheduler.cron '50 08 * * *' do
	# do stuff
	system("rake check_today_traffic_quality")
end

# every morning
scheduler.cron '00 09 * * *' do
	# do stuff
	system("rake check_yesterday_client_usage")
end	


scheduler.interval '1s' do
  Rails.logger.debug "I assure you! It's #{Time.now}"
end

#scheduler.join
