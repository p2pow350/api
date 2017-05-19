require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")

unless scheduler.down?
	# every hour
	scheduler.cron '0 */1 * * *' do
		# do stuff
		system("rake check_hour_traffic_quality")
	end
	
	# every morning
	scheduler.cron '00 09 * * *' do
		# do stuff
		system("rake check_today_traffic_quality")
	end

end


