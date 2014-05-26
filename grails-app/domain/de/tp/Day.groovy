package de.tp

class Day {

	Date date
	String description
	Date sunrise
	Date sunset
	
	Variant variant
		
	static mapping = {
		date column:'day', type:'timestamp'
		id column:'day_id', generator:'sequence', params:[sequence:'day_seq', initialValue:1]
	}
	
	static constraints = {
		date nullable: false, attributes:['precision':'minute']
	}
	
	static hasMany = [
		stages: Stage
	]
	
	static searchable = true
	
	String toString() {
		date.format("dd.MM. (E)") + " " + description
	}
	
	def getDuskNight() {
		def n = (date.clone().clearTime() + 1)
		return Night.findByMidnight(n)
	}
	
	def getDawnNight() {
		def n = (date.clone().clearTime())
		return Night.findByMidnight(n)
	}
	
	def getName() {
		return description
	}

	def clone() {
		Day d = new Day()
		['date', 'description', 'sunrise', 'sunset'].each { attr ->
			d[attr] = this[attr]
		}
		return d
	}
}

