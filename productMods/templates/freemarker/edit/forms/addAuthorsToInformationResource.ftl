<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Custom form for adding authors to information resources -->

<#import "lib-vivo-form.ftl" as lf>

<#--Retrieve certain page specific information information-->
<#assign newRank = editConfiguration.pageData.newRank />
<#assign existingAuthorInfo = editConfiguration.pageData.existingAuthorInfo />
<#assign rankPredicate = editConfiguration.pageData.rankPredicate />

<#--Values from edit configuration to populate fields -->

<#--UL class based on size of existing authors-->
<#assign urlClass = ""/>
<#if (existingAuthorInfo?size > 0)>
	<#assign urlClass = "class='dd'"/>
</#if>

<#assign title="<em>${editConfiguration.subjectName}</em>" />
<#assign requiredHint="<span class='requiredHint'> *</span>" />
<#assign initialHint="<span class='hint'>(initial okay)</span>" />

<@lf.unsupportedBrowser>

<h2>${title}</h2>

<ul id="authorships" ${ulClass}>

<script type="text/javascript">
    var authorshipData = [];
</script>


<#assign authorHref="/individual?uri=" />
<#--This should be a list of java objects where URI and name can be retrieved-->
<#list existingAuthorInfo as authorship>
	<#local authorUri = authorship.authorUri/>
	<#local authorName = authorship.authorName/>

	<li class="authorship">
			<#-- span.author will be used in the next phase, when we display a message that the author has been
			removed. That text will replace the a.authorName, which will be removed. -->    
			<span class="author">
					<#-- This span is here to assign a width to. We can't assign directly to the a.authorName,
					for the case when it's followed by an em tag - we want the width to apply to the whole thing. -->
					<span class="authorNameWrapper">
							<#if (authorUri?length > 0)>
									<span class="authorName">${authorName}</span>
								<#else>      
									<span class="authorName">${authorship.authorshipName}</span><em> (no linked author)</em>
							</#if>
					</span>

					<a href="${urls.base}/edit/primitiveDelete" class="remove">Remove</a>
			</span>
	</li>

	<script type="text/javascript">
			authorshipData.push({
					"authorshipUri": "${authorship.authorshipUri}",
					"authorUri": "${authorUri}",
					"authorName": "${authorName}"                
			});
	</script>
</#list>

    <#--// A new author will be ranked last when added.
    // This value is now inserted by JavaScript, but leave it here as a safety net in case page
    // load reordering returns an error. 
    request.setAttribute("newRank", maxRank + 1);
    request.setAttribute("rankPredicate", rankPredicateUri);-->

</ul>

<section id="showAddForm" role="region">
    <input type="hidden" name = "editKey" value="${editKey}" />
    <input type="submit" id="showAddFormButton" value="replace submit label" role="button" />

    <span class="or"> or </span>
    <a class="cancel" href="${cancelUrl}" title="Cancel">Return to Publication</a>
</section> 

<form id="addAuthorForm" action ="${submitUrl}" class="customForm">
    <h3>Add an Author</h3>
        <label for="lastName">Last name <span class='requiredHint'> *</span></label>
        <input class="acSelector" size="35"  type="text" id="lastName" name="lastName" value="" role="input" />

        <label for="firstName">First name ${requiredHint} ${initialHint}</label>
        <input  size="20"  type="text" id="firstName" name="firstName" value=""  role="input" />

        <label for="middleName">Middle name <span class='hint'>(initial okay)</span></label>
        <input  size="20"  type="text" id="middleName" name="middleName" value=""  role="input" />
      
        <input type="hidden" id="label" name="label" value=""  role="input" />  <!-- Field value populated by JavaScript -->

        <div id="selectedAuthor" class="acSelection">
            <label>Selected author: </label><span class="acSelectionInfo" id="selectedAuthorName"></span></p>
            <input type="hidden" id="personUri" name="personUri" value=""  role="input" /> <!-- Field value populated by JavaScript -->
        </div>

        <input type="hidden" name="rank" id="rank" value="${newRank}" role="input" />
    
        <p class="submit">
            <input type="hidden" name = "editKey" value="${editKey}" role="input" />
            <input type="submit" id="submit" value="Add Author" role="button" role="input" />
            
            <span class="or"> or </span>
            
            <a class="cancel" href="${cancelUrl}" title="Cancel">Cancel</a>
        </p>

        <p id="requiredLegend" class="requiredHint">* required fields</p>
</form>

<script type="text/javascript">
var customFormData = {
    rankPredicate: '${rankPredicate}',
    acUrl: '${urls.base}/autocomplete?tokenize=true',
    reorderUrl: '{urls.base}/edit/reorder'
};
</script>

${stylesheets.add('<link rel="stylesheet" href="${urls.base}/js/jquery-ui/css/smoothness/jquery-ui-1.8.9.custom.css" />')}
${stylesheets.add('<link rel="stylesheet" href="${urls.base}/edit/forms/css/customForm.css" />',
									'<link rel="stylesheet" href="${urls.base}/edit/forms/css/autocomplete.css" />',
                  '<link rel="stylesheet" href="${urls.base}/edit/forms/css/addAuthorsToInformationResource.css" />')}


${scripts.add('<script type="text/javascript" src="${urls.base}/js/jquery-ui/js/jquery-ui-1.8.9.custom.min.js"></script>'),
							'<script type="text/javascript" src="${urls.base}/js/customFormUtils.js"></script>',
							'<script type="text/javascript" src="${urls.base}/js/browserUtils.js"></script>',
              '<script type="text/javascript" src="${urls.base}/edit/forms/js/addAuthorsToInformationResource.js"></script>')}