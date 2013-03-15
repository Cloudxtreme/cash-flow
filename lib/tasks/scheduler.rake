desc "This task is called by the Heroku cron add-on"
task :call_page => :environment do
   uri = URI.parse('https://wapi.herokuapp.com/')
   Net::HTTP.get(uri)
 end