<%@ page import="de.tp.Night"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<title><g:message code="stats.accoCost.label" /></title>

<script type="text/javascript" src='https://www.google.com/jsapi'></script>
<script type="text/javascript">
	        google.load("visualization", "1", {packages:["corechart"]});
	    	google.setOnLoadCallback(drawChart);
	    	function drawChart() {
	    		var data;
	    		var avgPrice = ${accoCost?(accoCost*.price.sum() / accoCost.count{ it }):0};
	    		data = new google.visualization.DataTable();
		        data.addColumn('date', 'Night');
		        data.addColumn('number', 'Price');
		        data.addColumn({type: 'string', role: 'tooltip'});
		        data.addColumn('number', 'Avg');
		        data.addRows([
		        <g:each in="${accoCost}" status="i" var="c">
		        	[new Date(${c.night.time}), ${c.price ?: 0}, '${c.label}', avgPrice],
		        </g:each>
		        ]);

			     // Create a formatter.
			     // This example uses object literal notation to define the options.
			     var formatter = new google.visualization.DateFormat({pattern: 'dd.MM.'});
	
			     // Reformat our data.
			     formatter.format(data, 0);
		     		        

		        var costchart = new google.visualization.LineChart(document.getElementById('accoCost'));
		        var options = {
				        width: '100%', 
				        height: 200, 
				        chartArea : { left : 40, top : 10, width : "87%", height : "75%"},
				        hAxis : {
					        gridlines : { count: ${(accoCost?.size() >=2)?(accoCost[-1].night.format('w').toLong() - accoCost[0].night.format('w').toLong()):0} },
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
			<g:message code="stats.acco.header" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>

		<div id="accoCost"></div>

		<g:set var="minNight" value="${accoCost.min { it.price }}" />
		<g:set var="maxNight" value="${accoCost.max { it.price }}" />

		<table>
			<tbody>
				<tr>
					<td>Min: ${minNight?.price?:0} €</td>
					<td>Avg: ${accoCost?((accoCost*.price.sum() / accoCost.count{ it }).toDouble().round(2)):0} €</td>
					<td>Max: ${maxNight?.price?:0} €</td>
				</tr>
			</tbody>
		</table>


	</div>
</body>
</html>
