{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2018-2019 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *}

{extends "frontend/layouts/general.tpl"}

{assign var="pageTitleTranslated" value=$article->getLocalizedTitle()|escape}

{block name="pageContent"}
	<div class="container">
		{if $article->getLocalizedCoverImage() || $issue->getLocalizedCoverImage()}
			<div class="row">
				<div class="article__cover-img-wrapper">
					{if $article->getLocalizedCoverImage()}
						<img class="article-cover-img img-fluid img-thumbnail" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
					{else}
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							<img class="article-cover-img img-fluid img-thumbnail" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					{/if}
				</div>
			</div>
		{/if}

		<div class="article__meta">
			{* Submitted date *}
			{if $article->getDateSubmitted()}
				<div class="article__date-submitted">
					<span>{translate key="submissions.submitted"}:<span> <span>{$article->getDateSubmitted()|date_format:$dateFormatShort}</span>
				</div>
			{/if}

			{* DOI (requires plugin) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() != 'doi'}
					{continue}
				{/if}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
					<div class="article__doi">
						<span class="galley-doi-label">
							{capture assign=translatedDOI}{translate key="plugins.pubIds.doi.readerDisplayName"}{/capture}
							{translate key="semicolon" label=$translatedDOI}
						</span>
						<span class="article__doi-value">
							<a href="{$doiUrl}">
								{* maching DOI's (with new and old format) *}
								{$doiUrl|regex_replace:"/http.*org\//":" "}
							</a>
						</span>
					</div>
				{/if}
			{/foreach}

			{* Section title *}
			{if $article->getSectionTitle()}
				<div class="article__section-title">
					{$article->getSectionTitle()|escape}
				</div>
			{/if}

			{* Published date *}
			{if $article->getDatePublished()}
				<div class="article__date-published">
					<span>{translate key="submissions.published"}:<span> <span>{$article->getDatePublished()|date_format:$dateFormatShort}</span>
				</div>
			{/if}
		</div>

		{* Article title *}
		{if $article->getLocalizedFullTitle()}
			<h1 class="article__title">{$article->getLocalizedFullTitle()|escape}</h1>
		{/if}

	</div>
{/block}
