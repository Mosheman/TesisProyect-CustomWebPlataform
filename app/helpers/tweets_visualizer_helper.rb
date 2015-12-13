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
end
