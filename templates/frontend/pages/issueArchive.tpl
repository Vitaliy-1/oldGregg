{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2017-2020 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief Displays issues.
 *
 * @uses $issues Array Collection of issues to display
 * @uses $prevPage int The previous page number
 * @uses $nextPage int The next page number
 * @uses $showingStart int The number of the first item on this page
 * @uses $showingEnd int The number of the last item on this page
 * @uses $total int Count of all published monographs
 *}

{extends "frontend/layouts/general.tpl"}

{capture assign="pageTitle"}
	{if $prevPage}
		{translate key="archive.archivesPageNumber" pageNumber=$prevPage+1}
	{else}
		{translate key="archive.archives"}
	{/if}
{/capture}

{assign var="pageTitleTranslated" value=$pageTitle}

{block name="pageContent"}
	<div class="container issue_archive">
		<h1>
			{$pageTitle|escape}
		</h1>

		{* No issues have been published *}
		{if empty($issues)}
			<p>{translate key="current.noCurrentIssueDesc"}</p>

		{* List issues *}
		{else}
			<ul class="issues_archive">
				{foreach from=$issues item="issue"}
					<li>
						{include file="frontend/objects/issue_summary.tpl"}
					</li>
				{/foreach}
			</ul>

			{* Pagination *}
			{if $prevPage > 1}
				{capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$prevPage}{/capture}
			{elseif $prevPage === 1}
				{capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}{/capture}
			{/if}
			{if $nextPage}
				{capture assign=nextUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$nextPage}{/capture}
			{/if}
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
{/block}
