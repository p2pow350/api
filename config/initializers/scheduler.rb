require 'rubygems'
require 'rake'
require 'rufus-scheduler'

load File.join(Rails.root, 'Rakefile')

scheduler = Rufus::Scheduler.singleton


# every hour - Mon-Fri (10:00 to 19:00)
# NOC
# disabled
#scheduler.cron '0 10-19/1 * * 1-5' do
#    Rake::Task['check_hour_traffic_quality'].reenable
#    Rake::Task['check_hour_traffic_quality'].invoke(60, ['noc@areaattiva.it'])
#end

# every two hours - Mon-Fri (10:00 to 19:00)
# SALES
# disabled
#scheduler.cron '0 10-19/2 * * 1-5' do
#    Rake::Task['check_hour_traffic_quality'].reenable
#    Rake::Task['check_hour_traffic_quality'].invoke(120, ['dario.ceccaroni@areaattiva.it'])
#end


# every 15 minutes - Every Day (09:00 to 19:00)
scheduler.cron '*/15 09-19/1 * * *' do
# scheduler.cron '0 09-19/1 * * *' do
    Rake::Task['check_negative_margins'].reenable
    Rake::Task['check_negative_margins'].invoke(15, ['noc@areaattiva.it', 'dario.ceccaroni@areaattiva.it'])
end

# every morning Mon-Fri (8:59)
scheduler.cron '59 08 * * 1-5' do
    Rake::Task['check_today_traffic_quality'].reenable
    Rake::Task['check_today_traffic_quality'].invoke(['noc@areaattiva.it', 'dario.ceccaroni@areaattiva.it'])
end

# Saturday-Sunday (12:00, 19:00)
scheduler.cron '59 11,18 * * 6-7' do
    Rake::Task['check_today_traffic_quality'].reenable
    Rake::Task['check_today_traffic_quality'].invoke
end


# every morning Mon-Fri (08:00)
scheduler.cron '0 08 * * 1-5' do
    Rake::Task['check_yesterday_client_usage'].reenable
    Rake::Task['check_yesterday_client_usage'].invoke(['noc@areaattiva.it', 'andrea.cavaliere@areaattiva.it', 'dario.ceccaroni@areaattiva.it'])
end	

# Saturday-Sunday (10:00)
scheduler.cron '00 10 * * 6-7' do
    Rake::Task['check_yesterday_client_usage'].reenable
    Rake::Task['check_yesterday_client_usage'].invoke(['noc@areaattiva.it', 'andrea.cavaliere@areaattiva.it', 'dario.ceccaroni@areaattiva.it'])
end	


# First Day of the Month (09:30)
scheduler.cron '30 9 1 * *' do
    Rake::Task['check_past_month_client_usage'].reenable
    Rake::Task['check_past_month_client_usage'].invoke(['noc@areaattiva.it', 'andrea.cavaliere@areaattiva.it', 'dario.ceccaroni@areaattiva.it'])
end	


#scheduler.join
