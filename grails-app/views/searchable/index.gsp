<%@ page import="org.springframework.util.ClassUtils" %>
<%@ page import="grails.plugin.searchable.internal.lucene.LuceneUtils" %>
<%@ page import="grails.plugin.searchable.internal.util.StringQueryUtils" %>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main">
    <title><g:if test="${params.q && params.q?.trim() != ''}">${params.q} - </g:if>Suche</title>
    
    <r:require modules="jquery-ui" />
    
    <r:script>
    	$( document ).ready(function() {
            document.getElementById("q").focus();
    	});
    </r:script>
    
    
    <style>
    	ul {
			margin: 1em 2em;
		}
		
		li,p {
			margin-bottom: 1em;
		}
		
		#main {
			margin-left:25px;
		}
    </style>
    
  </head>
  <body>
    
  	<div id="header">
	  <div id="main">
	  
	  	<g:form url='[controller: "searchable", action: "index"]' id="searchableForm" name="searchableForm" method="get">
	        <g:textField name="q" value="${params.q}" size="50"/> <input type="submit" value="Suche" />
	    </g:form>
	  
	  
	    <g:set var="haveQuery" value="${params.q?.trim()}" />
	    <g:set var="haveResults" value="${searchResult?.results}" />
	    <div class="title">
	      <span>
	        <g:if test="${haveQuery && haveResults}">
	          Zeige <strong>${searchResult.offset + 1}</strong> - <strong>${searchResult.results.size() + searchResult.offset}</strong> von <strong>${searchResult.total}</strong>
	          Ergebnissen für <strong>${params.q}</strong>
	        </g:if>
	        <g:else>
	        &nbsp;
	        </g:else>
	      </span>
	    </div>
	
	    <g:if test="${haveQuery && !haveResults && !parseException}">
	      <p>Nichts gefunden für die Suche - <strong>${params.q}</strong></p>
	    </g:if>
	
	    <g:if test="${parseException}">
	      <p>Ihre Suche - <strong>${params.q}</strong> - ist kein gültiger Suchausdruck!</p>
	      <p>Vorschläge:</p>
	      <ul>
	        <li>Suchbegriff anpassen: in <a href="http://lucene.apache.org/java/docs/queryparsersyntax.html">Lucene query syntax</a> finden Sie (englische) Beispiele</li>
	        <g:if test="${LuceneUtils.queryHasSpecialCharacters(params.q)}">
	          <li>Entfernen Sie Sonderzeichen, wie <strong>" - [ ]</strong>, bevor Sie suchen, also <em><strong>${LuceneUtils.cleanQuery(params.q)}</strong></em><br />
	          </li>
	          <li>Escapen Sie Sonderzeichen wie <strong>" - [ ]</strong> mit <strong>\</strong>, also <em><strong>${LuceneUtils.escapeQuery(params.q)}</strong></em><br />
	          </li>
	        </g:if>
	      </ul>
	    </g:if>
	
	    <g:if test="${haveResults}">
	      <div class="results">
	        <g:each var="result" in="${searchResult.results}" status="index">
	          <div class="result">
	            
	            <g:set var="className" value="${ClassUtils.getShortName(result.getClass())}" />
	            <g:set var="link" value="${createLink(controller: className[0].toLowerCase() + className[1..-1], action: 'show', id: result.id)}" />
	            <div class="name"><a href="${link}"><g:message code="${className}"/> #${result.id}</a></div>
	            
	            <g:set var="desc" value="${result.toString()}" />
	            <g:if test="${desc.size() > 120}"><g:set var="desc" value="${desc[0..120] + '...'}" /></g:if>
	            <div class="desc">${desc.encodeAsHTML()}</div>
	          </div>
	        </g:each>
	      </div>
	
	      <div>
	        <div class="paging">
	          <g:if test="${haveResults}">
	              <g:set var="totalPages" value="${Math.ceil(searchResult.total / searchResult.max)}" />
	             	<div class="pagination">
	              		<g:paginate controller="searchable" action="index" params="[q: params.q]" total="${searchResult.total}"/>
	              	</div>
	          </g:if>
	        </div>
	      </div>
	    </g:if>
	  </div>
  </body>
</html>
