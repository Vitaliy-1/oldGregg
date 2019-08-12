{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2018-2019 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief Journal landing page
 *
 *}

{extends "frontend/layouts/general.tpl"}

{* passing variable *}
{assign var="pageTitleTranslated" value=$currentJournal->getLocalizedName()}

{block name="pageContent"}
	{if !empty($latestIssues)}
		<div class="box_primary">
			<div class="container carousel-container">
				<div id="carouselIssues" class="carousel slide carousel-fade{if $issue->getLocalizedDescription()} carousel-with-caption{/if}" data-ride="carousel">
					<div class="carousel-inner">
						{foreach from=$latestIssues item=issue key=latestKey}
							<div class="carousel-item{if $latestKey==0} active{/if}">
								{if $issue->getLocalizedCoverImageUrl()}
									{assign var="coverUrl" value=$issue->getLocalizedCoverImageUrl()}
								{else}
									{assign var="coverUrl" value=$defaultCoverImageUrl}
								{/if}
								<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}" class="carousel-img">
									<img src="{$coverUrl}" class="d-block{if !$issue->getLocalizedDescription()} m-auto{/if}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
								</a>
								{if $issue->getLocalizedDescription()}
									<div class="carousel-caption">
										<a class="caption-header" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
											<h5>{$issue->getIssueIdentification()|escape}</h5>
										</a>
										<div class="carousel-text">
											{$issue->getLocalizedDescription()|strip_unsafe_html}
										</div>
									</div>
								{/if}
							</div>
						{/foreach}
					</div>

					{if $latestIssues|count > 1}
						<a class="carousel-control-prev" href="#carouselIssues" role="button" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">{translate key="help.previous"}</span>
						</a>
						<a class="carousel-control-next" href="#carouselIssues" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">{translate key="help.next"}</span>
						</a>
					{/if}
				</div>
			</div>
		</div>
	{/if}
{/block}

<div class="page_index_journal">

	{call_hook name="Templates::Index::journal"}

	{if $homepageImage}
		<div class="homepage_image">
			<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
		</div>
	{/if}

	{* Announcements *}
	{if $numAnnouncementsHomepage && $announcements|@count}
		<div class="cmp_announcements highlight_first">
			<h2>
				{translate key="announcement.announcements"}
			</h2>
			{foreach name=announcements from=$announcements item=announcement}
				{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
					{break}
				{/if}
				{if $smarty.foreach.announcements.iteration == 1}
					{include file="frontend/objects/announcement_summary.tpl" heading="h3"}
					<div class="more">
				{else}
					<article class="obj_announcement_summary">
						<h4>
							<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
								{$announcement->getLocalizedTitle()|escape}
							</a>
						</h4>
						<div class="date">
							{$announcement->getDatePosted()}
						</div>
					</article>
				{/if}
			{/foreach}
			</div><!-- .more -->
		</div>
	{/if}

	{* Latest issue *}
	{if $issue}
		<div class="current_issue">
			<h2>
				{translate key="journal.currentIssue"}
			</h2>
			<div class="current_issue_title">
				{$issue->getIssueIdentification()|strip_unsafe_html}
			</div>

			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}" class="read_more">
				{translate key="journal.viewAllIssues"}
			</a>
		</div>
	{/if}

	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<div class="additional_content">
			{$additionalHomeContent}
		</div>
	{/if}
</div><!-- .page -->

