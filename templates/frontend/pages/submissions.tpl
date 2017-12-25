{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v2.
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div class="page page_submissions">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"}
	<div class="container">
		{* Login/register prompt *}
		<div class="alert alert-dark" role="alert">
		{if $isUserLoggedIn}
			{capture assign="newSubmission"}<a href="{url page="submission" op="wizard"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
			{capture assign="viewSubmissions"}<a href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
			<div class="cmp_notification">
				{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
			</div>
		{else}
			{capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
			{capture assign="register"}<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
			<div class="cmp_notification">
				{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
			</div>
		{/if}
	</div>

	{if $submissionChecklist}
		<div class="submission_checklist card">
			<div class="card-body">
				<h2 class="card-title">
                    {translate key="about.submissionPreparationChecklist"}
                    {include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.submissionPreparationChecklist"}
				</h2>
				<p class="card-text text-muted">{translate key="about.submissionPreparationChecklist.description"}</p>
			</div>
			<ul class="list-group list-group-flush">
                {foreach from=$submissionChecklist item=checklistItem}
					<li class="list-group-item">
						<i class="fas fa-hand-point-right"></i>
                        {$checklistItem.content|nl2br}
					</li>
                {/foreach}
			</ul>
		</div>
	{/if}

	{if $currentContext->getLocalizedSetting('authorGuidelines')}
	<div class="author_guidelines">
		<h2>
			{translate key="about.authorGuidelines"}
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="journal" anchor="guidelines" sectionTitleKey="about.authorGuidelines"}
		</h2>
		{$currentContext->getLocalizedSetting('authorGuidelines')|nl2br}
	</div>
	{/if}

	{if $currentContext->getLocalizedSetting('copyrightNotice')}
		<div class="copyright_notice">
			<h2>
				{translate key="about.copyrightNotice"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="journal" anchor="guidelines" sectionTitleKey="about.copyrightNotice"}
			</h2>
			{$currentContext->getLocalizedSetting('copyrightNotice')|nl2br}
		</div>
	{/if}
	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
