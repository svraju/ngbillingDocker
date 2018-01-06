<%@ page import="com.sapienter.jbilling.server.metafields.EntityType" %>
  %{--
   jBilling - The Enterprise Open Source Billing System
   Copyright (C) 2003-2011 Enterprise jBilling Software Ltd. and Emiliano Conde

   This file is part of jbilling.
   
   jbilling is free software: you can redistribute it and/or modify
   it under the terms of the GNU Affero General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   jbilling is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Affero General Public License for more details.
   
   You should have received a copy of the GNU Affero General Public License
   along with jbilling.  If not, see <http://www.gnu.org/licenses/>.

 This source was modified by Web Data Technologies LLP (www.webdatatechnologies.in) since 15 Nov 2015.
You may download the latest source from webdataconsulting.github.io.

 
  --}%

<%--
  Shows a review of the account information type metafields

  @author Panche Isajeski
  @since 05/24/2013
--%>

<div id="review-box">

    <div id="messages">
        <g:if test="${errorMessages}">
            <div class="msg-box error">
                <ul>
                    <g:each var="message" in="${errorMessages}">
                        <li>${message}</li>
                    </g:each>
                </ul>
            </div>

            <g:set var="errorMessages" value=""/>
            <ul></ul>
        </g:if>
    </div>

    <div class="box no-heading">
        <div class="sub-box">

            <div class="header">
                <div class="column">
                    <h1><g:message code="account.information.type.metafields.label" args="[ait.id ?: '']"/></h1>
                </div>

                <div style="clear: both;"></div>
            </div>

            <hr/>

            <ul id="metafield-ait">
                <g:each var="metaField" status="index" in="${ait?.metaFields}">
                    <g:set var="editable" value="${index == params.int('newLineIndex')}"/>
                    <g:set var="metaFieldTypeUsages" value="${acctInfoType}"/>
                    <g:if test="${metaField.fieldUsage}">
                        <g:set var="fieldType" value="${metaField.fieldUsage}"/>
                        <g:set var="metaFieldTypeUsages" value="${metaFieldTypeUsages + fieldType}"/>
                    </g:if>
                    <g:formRemote name="mf-${index}-update-form" url="[action: 'editAIT']"
                                  update="column2" method="GET">

                        <fieldset>

                            <g:hiddenField name="_eventId" value="updateMetaField"/>
                            <g:hiddenField name="execution" value="${flowExecutionKey}"/>

                            <li id="mf-${index}" class="mf ${editable ? 'active' : ''}">
                                <span class="description">${metaField.name? metaField.name : "-"}</span>
                                <span class="data-type">${metaField.dataType? metaField.dataType : "-"}</span>
                                <span class="mandatory">${metaField.mandatory?'Mandatory':'Not Mandatory'}</span>
                            </li>

                            <li id="mf-${index}-editor" class="editor ${editable ? 'open' : ''}">

                                <div class="box">
                                    <% params.entityType = com.sapienter.jbilling.server.metafields.EntityType.ACCOUNT_TYPE.name(); %>
                                    <g:render template="/metaFields/editMetafield"
                                              model="[metaField: metaField,
                                                      entityType: params.entityType,
                                                      metaFieldType:metaField.dataType,
                                                      parentId: 'mf-'+index+'-update-form',
                                                      metaFieldIdx:index, displayMetaFieldType: true 
                                              ]" />

                                    <g:hiddenField name="index" value="${index}"/>
                                </div>

                                <div class="btn-box">
                                    <a class="submit save" onclick="$('#mf-${index}-update-form').submit();"><span><g:message
                                            code="button.update"/></span></a>
                                    <g:remoteLink class="submit cancel" action="editAIT" params="[_eventId: 'removeMetaField', index: index]"
                                                  update="column2" method="GET">
                                        <span><g:message code="button.remove"/></span>
                                    </g:remoteLink>
                                </div>

                            </li>

                        </fieldset>

                    </g:formRemote>
                </g:each>

                <g:if test="${!ait?.metaFields}">
                    <li><em><g:message code="account.information.type.no.metafields"/></em></li>
                </g:if>
            </ul>
        </div>
    </div>

    <div class="btn-box ait-btn-box">
        <g:link class="submit save" action="editAIT" params="[_eventId: 'save']">
            <span><g:message code="button.save"/></span>
            <g:hiddenField name="saveInProgress" value="false"/>
        </g:link>

        <g:link class="submit cancel" action="editAIT" params="[_eventId: 'cancel']">
            <span><g:message code="button.cancel"/></span>
        </g:link>
    </div>

    <script type="text/javascript">
        $('#metafield-ait li.mf').click(function() {
            var id = $(this).attr('id');
            $('#' + id).toggleClass('active');
            $('#' + id + '-editor').toggle('blind');
        });
    </script>


</div>