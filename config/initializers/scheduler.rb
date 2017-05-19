require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")

unless scheduler.down?
	# every hour - Mon-Tue (10:00 to 19:00)
	scheduler.cron '0 10-19/1 * * 1-5' do
		# do stuff
		system("rake check_hour_traffic_quality")
	end
	
	# every morning
	scheduler.cron '00 09 * * *' do
		# do stuff
		system("rake check_today_traffic_quality")
	end

end


