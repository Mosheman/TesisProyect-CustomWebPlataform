class TuserSearchWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false
	
	def perform client, search_id, keywords, lvl_search
		
	end
end