{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 *}
{capture assign="pageTitle"}
	{if $issues->getPageCount() > 0 && $issues->getPage() > 1}
		{translate key="archive.archivesPageNumber" pageNumber=$issues->getPage()}
	{else}
		{translate key="archive.archives"}
	{/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}

<div class="page page_issue_archive">
	{include file="frontend/components/breadcrumbs.tpl" currentTitle=$pageTitle}

	{* No issues have been published *}
	{if !$issues}
		{translate key="current.noCurrentIssueDesc"}

	{* List issues *}
	{else}
		<div class="row">
			{iterate from=issues item=issue}
				<div class="issue-block news-block col-sm-6 col-md-6 col-lg-4">
					{include file="frontend/objects/issue_summary.tpl"}
				</div>
			{/iterate}
		</div>

		{if $issues->getPageCount() > 0}
			<div class="cmp_pagination">
				{page_info iterator=$issues}
				{page_links anchor="issues" name="issues" iterator=$issues}
			</div>
		{/if}
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
