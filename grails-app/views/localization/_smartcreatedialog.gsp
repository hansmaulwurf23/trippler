         <div class="dialog">
             <table>
                 <tbody>

                     <tr class="prop">
                         <td valign="top" class="name">
                             <label for="code"><g:message code="localization.code" default="Code" />:</label>
                         </td>
                         <td valign="top" class="value ${hasErrors(bean:localization,field:'code','errors')}">
                             <input type="text" maxlength="250" id="code" name="code" value="${code}"/>
                         </td>
                     </tr>

<g:each in="${locales.sort()}" var="locale">
<g:set var="locloc" value="${localizationsByLocale[locale]}" />
                     <tr class="prop">
                         <td valign="top" class="name">
                             <label for="locale"><g:message code="localization.locale" default="Locale" />:</label>
                         </td>
                         <td valign="top" class="value ${hasErrors(bean:localization,field:'locale','errors')}">
                             <input type="text" id="locale" name="locale" disabled="disabled" value="${locale}"/>
                         </td>
                     </tr>

                     <tr class="prop">
                         <td valign="top" class="name">
                             <label for="text"><g:message code="localization.text" default="Text" />:</label>
                         </td>
                         <td valign="top" class="value ${hasErrors(bean:localization,field:'text','errors')}">
                             <textarea rows="5" cols="40" name="text_${locale}_${locloc?.id}">${fieldValue(bean:locloc, field:'text')}</textarea>
                         </td>
                     </tr>
                     </g:each>

                 </tbody>
             </table>
         </div>
