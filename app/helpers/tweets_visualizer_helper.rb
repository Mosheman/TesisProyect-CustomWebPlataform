module TweetsVisualizerHelper
	def self.get_infowindow_from_tweet tweet
		('<div id="content">'+
			'<div id="siteNotice">'+
			'</div>'+
			'<h3 id="firstHeading" class="firstHeading">'+tweet.twitters_tweet[:user][:name]+' ('+tweet.twitters_tweet[:user][:screen_name]+'):</h3>'+
			'<div id="bodyContent">'+
				'<p>'+
					tweet.twitters_tweet[:text]+
				'</p>'+
			'</div>'+
		'</div>')
	end

	def get_group_item_select tweets
		groups = []
		years = []
		tweets.each do |tweet|
			year = tweet.twitters_tweet[:created_at].split(" ").last
			years << year
			if group[year: year]

			end
			# group << {
			# 			year:
			# 		}
		end
	end
end
