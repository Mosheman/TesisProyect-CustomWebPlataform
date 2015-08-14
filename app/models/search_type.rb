class SearchType

	def initialize(label, active, path_name, name)  
		# Instance variables  
		@label = label  
		@active = active
		@path_name = path_name
		@name = name
	end  

	def label
		@label
	end
	def active
		@active
	end
	def path_name
		@path_name
	end
	def name
		@name
	end
	def get_attributes
		{
			label: @label,  
			active: @active,
			path_name: @path_name,
			name: @name
		}
	end
end