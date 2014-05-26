package de.tp

class Variant {

	String name
	Holiday holiday
	
    static constraints = {
		name nullable: false
		holiday nullable: false
    }
	
	static mapping = {
		holiday fetch: 'join'
	}
	
	public String toString() {
		return name
	}
}
