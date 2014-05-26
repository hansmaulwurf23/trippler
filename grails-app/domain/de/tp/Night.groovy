package de.tp

class Night {

	Date midnight
	Accomodation accomodation
	Boolean booked
	Boolean paid
	String discount
	Long distanceFromLastStage
	Long durationFromLastStage
	Date arrivalTime
	
	Variant variant
	
    static constraints = {
		midnight()
		accomodation()
    }
	
	static searchable = true
	
	static mapping = {
		midnight column:'midnight', type:'date'
		id column:'night_id', generator:'sequence', params:[sequence:'night_seq', initialValue:1]
		distanceFromLastStage column:'distance'
		durationFromLastStage column:'duration'
		arrivalTime column:'time'
	}
	
	String toString() {
		midnight ? midnight.format("dd.MM.yyyy") : '?'
	}
	
	def clone() {
		Night n = new Night()
		['midnight'].each { attr ->
			n[attr] = this[attr]
		}
		return n
	}
}
