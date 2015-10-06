module SearchesHelper

	def is_tuser search_type
		search_type == "tusers"
	end

	def get_all_languages
		[
			["French", "fr"], ["English", "en"], ["Arabic", "ar"], ["Japanese", "ja"], ["Spanish", "es"], ["German", "de"], ["Italian", "it"], ["Indonesian", "id"], ["Portuguese", "pt"], ["Korean", "ko"], ["Turkish", "tr"], ["Russian", "ru"], ["Dutch", "nl"], ["Filipino", "fil"], ["Malay", "msa"], ["Traditional Chinese", "zh-tw"], ["Simplified Chinese", "zh-cn"], ["Hindi", "hi"], ["Norwegian", "no"], ["Swedish", "sv"], ["Finnish", "fi"], ["Danish", "da"], ["Polish", "pl"], ["Hungarian", "hu"], ["Farsi", "fa"], ["Hebrew", "he"], ["Urdu", "ur"], ["Thai", "th"], ["English UK", "en-gb"]
		]		
	end
end
