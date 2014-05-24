package de.tp.sec

class Role {

	String authority

	static mapping = {
		table name:'sec_role'
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
