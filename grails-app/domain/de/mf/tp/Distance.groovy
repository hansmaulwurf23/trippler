package de.mf.tp

class Distance {
	
	Address source
	Address destination
	long distance
	Long duration

    static constraints = {
		source nullable: false
		destination nullable: false
		distance nullable: false
    }
	
	static mapping = {
		version false
		id column:'distance_id', generator:'sequence', params:[sequence:'distance_seq', initialValue:1]
	}
}
