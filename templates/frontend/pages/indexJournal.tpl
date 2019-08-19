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

	<div class

	<div class="container">
		{call_hook name="Templates::Index::journal"}
	</div>
{/block}

