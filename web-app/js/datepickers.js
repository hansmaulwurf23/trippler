if (typeof jQuery !== 'undefined') {
	(function($) {
		
		// instantiate with default options
		$('.datepicker').datepicker({
			firstDay: 1,
			showOn: "both",
			dateFormat: "dd.mm.yy",
			showWeek: true,			// show weeknumbers
			changeYear: true,		// show select for years FIXME change period (especially for birthdates)
			showButtonPanel: true,
			gotoCurrent: false		// go to current selected date instead of today on goto button
		});
		
		// register change event to set hidden fields
		$( ".datepicker" ).change( function() {
			setHiddenFields($(this));
		});
		
		// initialize the hidden fields
		$( ".datepicker" ).each( function() {
			setHiddenFields($(this));
		});
		
		function setHiddenFields(datePickerDOMElement) {
			var dateString = $(datePickerDOMElement).val();
			var myID = $(datePickerDOMElement).attr('id');
			if (dateString !== undefined && dateString.length > 0) {
				var dateArray = dateString.split(".");
				$('#'+myID+'_day').val(dateArray[0]).change();
				$('#'+myID+'_month').val(dateArray[1]).change();
				$('#'+myID+'_year').val(dateArray[2]).change();
			}
		}
		
		$('input[linkedto]').change( function() {
			var linkedtoID = $(this).attr('linkedto');
			$('#'+linkedtoID).val($(this).val());
		});
		
		// initialize linked fields
		$('input[linkedto]').each( function() {
			$(this).change();
		});
		
		// localization is defined in ApplicationResources.groovy and relies on existence within jquery-ui plugin
		$( ".datepicker" ).datepicker( "option", $.datepicker.regional['de'] );
	})(jQuery);
}