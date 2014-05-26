package de.tp

class UserSetting {

	Variant defaultVariant
	
    static constraints = {
		defaultVariant nullable:true
    }
	
	static mapping = {
		id generator:'assigned'
		defaultVariant fetch: 'join'
	}
}
