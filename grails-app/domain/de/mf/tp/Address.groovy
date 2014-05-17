package de.mf.tp


class Address {
	
	String street
	String city
	String zip
	String county
	String state
	String country
	Double longitude
	Double latitude
	
	static mapping = {
		version false
		id column:'address_id', generator:'sequence', params:[sequence:'address_seq', initialValue:1]
	}
	
	static constraints = {
		street blank: false, nullable: false
		zip blank: false, nullable: false
		city blank: false, nullable: false
		county()
		state()
		country()
		longitude()
		latitude()
	}
	
	static searchable = true
	
	public String toString() {
		"${street}, ${zip} ${city}".trim()
	}
	
	public String toSearchableString() {
		//"${street}, ${zip} ${city}".trim()
		"new google.maps.LatLng(${latitude}, ${longitude})"
	}
	
	def additionalInfo = {
		return ""
	}

}
