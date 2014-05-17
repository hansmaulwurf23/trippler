<%@ page import="de.mf.tp.Localization" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title><g:message code="localization.smart.edit" default="Smart Edit Localization" /></title>
    </head>
    <body>
    	<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
        <div class="body">
        	<g:if test="${Localization.getMissings()}">
	        	<g:link action="smartcreate" params="[reset:true]"><g:message code="localization.smart.reset" /></g:link>
        		<ul>
		       	<g:each in="${Localization.getMissings()?.sort()}" var="missing">
		       		<li><g:link action="smartcreate" id="${missing}">${missing}</g:link></li>
		       	</g:each>
        		</ul>
        	</g:if>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${localization}">
            <div class="errors">
                <g:renderErrors bean="${localization}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
            	<input type="hidden" name="id" value="${code}" />
                <g:render template="smartcreatedialog" model="[code:code, locales:locales, localizationsByLocale: localizationsByLocale]" contextPath="${pluginContextPath}" />
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="smartsave" value="${message(code:'create', 'default':'Create')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('${message(code:'delete.confirm', 'default':'Are you sure?')}');" action="Delete" value="${message(code:'delete', 'default':'Delete')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
