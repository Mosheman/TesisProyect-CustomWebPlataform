module TweetsVisualizerHelper
	def self.get_infowindow_from_tweet tweet
		('<div id="content">'+
			'<div id="siteNotice">'+
			'</div>'+
			'<h3 id="firstHeading" class="firstHeading">'+tweet.twitters_tweet[:user][:name]+' ('+tweet.twitters_tweet[:user][:screen_name]+') :</h3>'+
			'<div id="bodyContent">'+
				'<p>'+
					tweet.twitters_tweet[:text]+
				'</p>'+
			'</div>'+
		'</div>')
	end

	def days_in_month(month, year)
		common_year_days_in_month = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}
		return 29 if month == 2 && Date.gregorian_leap?(year)
		common_year_days_in_month[month]
	end


end
