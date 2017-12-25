{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *}
{if $issue->getShowTitle()}
{assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}

<div class="card obj_issue_summary">

	{if $issueCover}
		<a class="cover img-thumbnail" href="{url op="view" path=$issue->getBestIssueId()}">
			<img class="card-img-top" src="{$issueCover|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
		</a>
	{/if}

	<div class="card-body">
		<h3 class="card-title issue-archive-title">
			<a class="title" href="{url op="view" path=$issue->getBestIssueId()}">
				{if $issueTitle}
					{$issueTitle|escape}
				{else}
					{$displayPageHeaderTitle|escape}
				{/if}
			</a>
		</h3>
		<p class="card-text">
			{$issueSeries|escape}
		</p>

		<a href="#" class="btn btn-secondary">{translate key="plugins.gregg.issue-read"}</a>
	</div>
</div>
