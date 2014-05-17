if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

function createStageRow(item, id) {
	return '<li id="'+id+'" class="ui-state-default stage" stageid="'+item.id+'" address="'+item.address+'" addressid="'+item.addressid+'">'
		//+ '<span class="ui-icon ui-icon-arrowthick-2-n-s"></span>'
		+ '<input type="text" class="timepicker" size="4"></input>'
		+ '<input type="text" class="waitingtime hidden" size="3"></input>'
		+ item.label 
		+ '<span class="removestage"></span>'
		+ '</li>'
}

function createNightRow(item) {
	return '<li id="'+item.id+'" class="ui-state-default stage night ' + item.id + '" stageid="'+item.id+'" address="'+item.address+'" addressid="'+item.addressid+'">'
		//+ '<span class="ui-icon ui-icon-arrowthick-2-n-s"></span>'
		+ '<input type="text" class="timepicker" size="4" disabled="disabled"></input>'
		//+ (item.time ? '(' + item.time + ') ' : '')
		+ item.label 
		+ '</li>'
}

function transformDuration(seconds) {
	sec_numb    = seconds;
    var hours   = Math.floor(sec_numb / 3600);
    var minutes = Math.floor((sec_numb - (hours * 3600)) / 60);
    var seconds = sec_numb - (hours * 3600) - (minutes * 60);

    
    var time    = '';
    if (minutes < 10) {
    	minutes = '0' + minutes;
    }
    time = hours + ':' + minutes + 'h'
    return time;
}

function roundTime(milliseconds) {
	var v = new moment(milliseconds - (milliseconds % 1000));
	var extraMinutes = v.minutes() % 5;
	if (extraMinutes > 0) {
		var addSeconds = (5 - extraMinutes) * 60 - v.seconds();
		v.add('seconds', addSeconds);
	} else {
		v.seconds(0);
	}
	
	return v;
}

function transformDistance(meters) {
	if (meters < 1000) {
		return meters + 'm';
	} else {
		return (Math.round(meters / 100) / 10) + 'km';
	}
}
