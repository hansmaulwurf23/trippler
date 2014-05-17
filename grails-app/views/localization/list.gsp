<%@ page import="de.mf.tp.Localization" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title><g:message code="localization.list" default="Localization List" /></title>
<%--        <g:localizationHelpBalloons />--%>
        <filterpane:includes />
        <tooltip:resources/>
    </head>
    <body>
        <div class="body">
        <tooltip:tip value="some tooltip text">
<%--    	<div>element that shows the tooltip</div>--%>
		</tooltip:tip>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <filterpane:currentCriteria domainBean="de.mf.tp.Localization" dateFormat="${[title:'MM/dd/yyyy',releaseDate:'MMM dd, yyyy']}"
                removeImgDir="images/skin" removeImgFile="sweeper.png" />
            <div class="list">
                <table>
                    <thead>
                        <tr>
                   	        <g:sortableColumn property="code" title="Code" titleKey="localization.code" />
                   	        <g:sortableColumn property="locale" title="Locale" titleKey="localization.locale" />
                   	        <g:sortableColumn property="text" title="Text" titleKey="localization.text" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${localizationList}" status="i" var="localization">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${localization.id}">${fieldValue(bean:localization, field:'code')}</g:link></td>
                            <td>${fieldValue(bean:localization, field:'locale')}</td>
                            <td>${fieldValue(bean:localization, field:'text')}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
            	<filterpane:paginate total="${localizationCount == null ? Localization.count(): localizationCount}" domain="Localization" />
                <filterpane:filterButton textKey="fp.tag.filterButton.text" appliedTextKey="fp.tag.filterButton.appliedText" text="Filter Me" appliedText="Change Filter" />
                <filterpane:isNotFiltered>Pure and Unfiltered!</filterpane:isNotFiltered>
                <filterpane:isFiltered>Filter Applied!</filterpane:isFiltered>
            </div>
        <p>
        <filterpane:filterPane domain="de.mf.tp.Localization" />
        </p>
        </div>
    </body>
</html>

