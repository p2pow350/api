class Sonus
	
	def self.colorize_asr(value)
		case value.to_i
		when 0..20
		  "red"
		when 21..50
		  "yellow"
		else
		  "green"
		end		
	end	
  	
	def self.colorize_acd(value)
		case value.to_f
		when 0..1
		  "orange"
		else
		  "lightgreen"
		end		
	end	
	
	
	def self.DestinationClient(date_from, date_to)
		date_from=html(date_from)
		date_to=html(date_to)
		
		response = HTTParty.get(
			"#{Rails.application.config.S_BASE_URL}DestinationClient;username=#{Rails.application.config.S_USERNAME};password=#{Rails.application.config.S_PASSWORD};dateFrom=#{date_from};dateTo=#{date_to}", 
			:headers => { 'Content-Type' => 'application/json' } 
		)
		
		r = response.parsed_response["destinationClients"]["destinationClient"]
		
		@out = []
		r.each_with_index do |d, i|
			@out << d unless r[i]["destination"].downcase.include? 'total'
		end
		return @out
	end
	

	def self.FinancialReport(date_from, date_to)
		date_from=html(date_from)
		date_to=html(date_to)
		
		response = HTTParty.get(
			"#{Rails.application.config.S_BASE_URL}FinancialReport;username=#{Rails.application.config.S_USERNAME};password=#{Rails.application.config.S_PASSWORD};dateFrom=#{date_from};dateTo=#{date_to}", 
			:headers => { 'Content-Type' => 'application/json' } 
		)
				
		r = response.parsed_response["financialReportRecords"]["financialReportRecord"]
		return r
	end
	
	
	
	
	
	
	
private
	def self.html(str)
		str=URI.encode(str)
		str.gsub!('/', '%2F')
	end
	
end