{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2018-2020 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

{extends "frontend/layouts/general.tpl"}

{* passing variable *}
{assign var="pageTitle" value="about.submissions"}

{block name="pageContent"}
	<div class="box_primary">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-9">
					<div class="cmp_notification">
						{if $sections|@count == 0}
							{translate key="author.submit.notAccepting"}
						{else}
							{if $isUserLoggedIn}
								{capture assign="newSubmission"}<a href="{url page="submission" op="wizard"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
								{capture assign="viewSubmissions"}<a href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
								{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
							{else}
								{capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
								{capture assign="register"}<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
								{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
							{/if}
						{/if}
					</div>

					{if $submissionChecklist}
						<div class="submission_checklist">
							<h2 class="submissions__header">
								{translate key="about.submissionPreparationChecklist"}
							</h2>

							{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.submissionPreparationChecklist"}

							<div>
								{translate key="about.submissionPreparationChecklist.description"}
							</div>
							<ul>
								{foreach from=$submissionChecklist item=checklistItem}
									<li>
										{$checklistItem.content|nl2br}
									</li>
								{/foreach}
							</ul>
						</div>
					{/if}
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-9">

				{if $currentContext->getLocalizedSetting('authorGuidelines')}
					<div class="author_guidelines" id="authorGuidelines">
						<h2 class="submissions__header">
							{translate key="about.authorGuidelines"}
						</h2>
						{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.authorGuidelines"}
						{$currentContext->getLocalizedSetting('authorGuidelines')}
					</div>
				{/if}

				{foreach from=$sections item="section"}
					{if $section->getLocalizedPolicy()}
						<div class="section_policy">
							<h2 class="submissions__header">{$section->getLocalizedTitle()|escape}</h2>
							{$section->getLocalizedPolicy()}
							{if $isUserLoggedIn}
								{capture assign="sectionSubmissionUrl"}{url page="submission" op="wizard" sectionId=$section->getId()}{/capture}
								<p>
									{translate key="about.onlineSubmissions.submitToSection" name=$section->getLocalizedTitle() url=$sectionSubmissionUrl}
								</p>
							{/if}
						</div>
					{/if}
				{/foreach}

				{if $currentContext->getLocalizedSetting('copyrightNotice')}
					<div class="copyright_notice">
						<h2 class="submissions__header">
							{translate key="about.copyrightNotice"}
						</h2>
						{include file="frontend/components/editLink.tpl" page="management" op="settings" path="distribution" anchor="permissions" sectionTitleKey="about.copyrightNotice"}
						{$currentContext->getLocalizedSetting('copyrightNotice')}
					</div>
				{/if}

				{if $currentContext->getLocalizedSetting('privacyStatement')}
					<div class="privacy_statement" id ="privacyStatement">
						<h2 class="submissions__header">
							{translate key="about.privacyStatement"}
						</h2>
						{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.privacyStatement"}
						{$currentContext->getLocalizedSetting('privacyStatement')}
					</div>
				{/if}
			</div>
		</div>
	</div>
{/block}
