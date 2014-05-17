package de.mf.tp

import groovy.time.TimeCategory;

class DateHelper {
	
	static mergeDateAndTime(Date date, Date time) {
		Date datePart = date.clone()
		Date timePart = time.clone()
		use(TimeCategory) {
			return new Date(datePart.clearTime().time + timePart.time - timePart.clearTime().time)
		}
	}

}
