class TuserSearchWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false
	
	def perform user_id, search_id, keywords, lvl_search
		
	end
end