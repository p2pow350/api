require 'rubygems'
require 'rake'
require 'rufus-scheduler'

load File.join(Rails.root, 'Rakefile')


scheduler = Rufus::Scheduler.singleton

# every hour - Mon-Tue (10:00 to 19:00)
scheduler.cron '0 10-19/1 * * 1-5' do
	# do stuff
    Rake::Task['check_hour_traffic_quality'].reenable
    Rake::Task['check_hour_traffic_quality'].invoke
end

# every morning
scheduler.cron '50 08 * * *' do
	# do stuff
    Rake::Task['check_today_traffic_quality'].reenable
    Rake::Task['check_today_traffic_quality'].invoke
end

# every morning
scheduler.cron '00 09 * * *' do
	# do stuff
    Rake::Task['check_yesterday_client_usage'].reenable
    Rake::Task['check_yesterday_client_usage'].invoke
end	

#scheduler.join
