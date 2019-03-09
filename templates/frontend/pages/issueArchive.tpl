{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 *}
{capture assign="pageTitle"}
	{if $prevPage}
		{translate key="archive.archivesPageNumber" pageNumber=$prevPage+1}
	{else}
		{translate key="archive.archives"}
	{/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}

<div class="page page_issue_archive">
	{include file="frontend/components/breadcrumbs.tpl" currentTitle=$pageTitle}

	{* No issues have been published *}
	{if empty($issues)}
		<p>{translate key="current.noCurrentIssueDesc"}</p>

	{* List issues *}
	{else}
		<div class="row">
			{foreach from=$issues item="issue"}
				<div class="issue-block news-block col-sm-6 col-md-6 col-lg-4">
					{include file="frontend/objects/issue_summary.tpl"}
				</div>
			{/foreach}
		</div>

		{* Pagination *}
		{capture assign="prevUrl"}
			{if $prevPage > 1}
				{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$prevPage}
			{elseif $prevPage === 1}
				{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}
			{/if}
		{/capture}
		{capture assign="nextUrl"}
			{if $nextPage}
				{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$nextPage}
			{/if}
		{/capture}
		{include
			file="frontend/components/pagination.tpl"
			prevUrl=$prevUrl
			nextUrl=$nextUrl
			showingStart=$showingStart
			showingEnd=$showingEnd
			total=$total
		}
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
