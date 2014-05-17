<%@ page import="de.tp.Night"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<title><g:message code="stats.distances.label" /></title>

<script type="text/javascript" src='https://www.google.com/jsapi'></script>
<script type="text/javascript">
	        google.load("visualization", "1", {packages:["corechart"]});
	    	google.setOnLoadCallback(drawChart);
	    	function drawChart() {
	    		var data;
	    		var avgDistance = ${distances*.distance.sum() / distances.count{ it }};
	    		data = new google.visualization.DataTable();
		        data.addColumn('date', 'Day');
		        data.addColumn('number', 'Distance');
		        data.addColumn({type: 'string', role: 'tooltip'});
		        data.addColumn('number', 'Avg');
		        data.addRows([
		        <g:each in="${distances}" status="i" var="c">
		        	[new Date(${c.day.time}), ${c.distance ?: 0}, '${c.label}', avgDistance],
		        </g:each>
		        ]);

			     // Create a formatter.
			     // This example uses object literal notation to define the options.
			     var formatter = new google.visualization.DateFormat({pattern: 'dd.MM.'});
	
			     // Reformat our data.
			     formatter.format(data, 0);
		     		        

		        var costchart = new google.visualization.LineChart(document.getElementById('distances'));
		        var options = {
				        width: '100%', 
				        height: 200, 
				        chartArea : { left : 40, top : 10, width : "87%", height : "75%"},
				        hAxis : {
					        gridlines : { count: ${distances[-1].day.format('w').toLong() - distances[0].day.format('w').toLong()} },
					        minorGridlines : { count : 6 }
				        }
		        };
		        costchart.draw(data, options);
	    	}

        </script>
</head>
<body>
	<div class="nav" role="navigation">
		<ul>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label" /></a></li>
			<li><g:link action="acco"><g:message code="stats.accoCost.label" /></g:link></li>
			<li><g:link action="distances"><g:message code="stats.distances.label" /></g:link></li>
		</ul>
	</div>
	<div id="statsbody" class="content" role="main">
		<h1>
			<g:message code="stats.distances.header" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>

		<div id="distances"></div>

		<g:set var="minNight" value="${distances.min { it.distance }}" />
		<g:set var="maxNight" value="${distances.max { it.distance }}" />

		<table>
			<tbody>
				<tr>
					<td>Min: ${minNight.distance} km</td>
					<td>Avg: ${(distances*.distance.sum() / distances.count{ it }).toDouble().round(2)} km</td>
					<td>Max: ${maxNight.distance} km</td>
					<td>Sum: ${distances.sum { it.distance }.toDouble().round(2)} km</td>
				</tr>
			</tbody>
		</table>


	</div>
</body>
</html>
