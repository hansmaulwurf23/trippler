package de.tp

import grails.plugins.springsecurity.Secured;

@Secured(['ROLE_ADMIN'])
class HolidayController {

    static scaffold = true
	
}
