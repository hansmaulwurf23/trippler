<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title><g:message code="localization.list" default="Localization List" /></title>
        <filterpane:includes />
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>

                   	        <g:sortableColumn property="code" title="Code" titleKey="localization.code" />
							<g:each in="${locales.sort()}" var="locale">
                   	        <th><g:message code="localization.text" /> ${locale}</th>
                   	        </g:each>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${codes.sort()}" status="i" var="code">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td><g:link action="smartedit" id="${code}">${code}</g:link></td>

                            <g:each in="${locales.sort()}" var="locale">
                   	        <td>${localizationsByCodeAndLocale?.get(code)?.get(locale)?.text}</td>
                   	        </g:each>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
