<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title><g:message code="localization.show" default="Show Localization" /></title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.id" default="Id" />:</td>

                            <td valign="top" class="value">${fieldValue(bean:localization, field:'id')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.code" default="Code" />:</td>

                            <td valign="top" class="value">${fieldValue(bean:localization, field:'code')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.locale" default="Locale" />:</td>

                            <td valign="top" class="value">${fieldValue(bean:localization, field:'locale')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.text" default="Text" />:</td>

                            <td valign="top" class="value">${fieldValue(bean:localization, field:'text')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.relevance" default="Relevance" />:</td>

                            <td valign="top" class="value">${fieldValue(bean:localization, field:'relevance')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.dateCreated" default="Date Created" />:</td>

                            <td valign="top" class="value">${fieldValue(bean:localization, field:'dateCreated')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.lastUpdated" default="Last Updated" />:</td>

                            <td valign="top" class="value">${fieldValue(bean:localization, field:'lastUpdated')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.version" default="Version" />:</td>

                            <td valign="top" class="value">${fieldValue(bean:localization, field:'version')}</td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${localization?.id}" />
                    <input type="hidden" name="code" value="${localization?.code}" />
                    <span class="button"><g:actionSubmit class="edit" action="Edit" value="${message(code:'edit', 'default':'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="edit" action="smartedit" value="${message(code:'smart.edit', 'default':'SmartEdit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('${message(code:'delete.confirm', 'default':'Are you sure?')}');" action="Delete" value="${message(code:'delete', 'default':'Delete')}" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
