package de.tp

class Accomodation {

	Address address
	Double price
	Double priceusd
	String notes
	String description
	String name
	String link
	String cancellationContact
	Date latestCancellation
	String roominfo
	Boolean breakfast
	Boolean wifi
	Boolean parking
	
	Holiday holiday
	
    static constraints = {
		name()
		price()
		link()
		description()
		notes()
		roominfo()
    }
	
	static searchable = true
	
	static mapping = {
		id column:'accomodation_id'
		notes type:'text'
		link type:'text'
		cancellationContact column:'cancel_contact'
		latestCancellation column:'cancel_date'
	}
	
	String toString() {
		return "${name} (${address})"
	}
}
