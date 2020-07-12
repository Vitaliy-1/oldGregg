{**
 * templates/frontend/pages/issue.tpl
 *
 * Copyright (c) 2018-2019 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *}

{extends "frontend/layouts/general.tpl"}

{assign var="pageTitleTranslated" value=$issueIdentification}

{block name="pageContent"}

	{capture name="issueGalleys"}
		{* Full-issue galleys *}
		{if $issueGalleys}
			<div class="galleys">
				<h2>
					{translate key="issue.fullIssue"}
				</h2>
				<ul class="galleys_links">
					{foreach from=$issueGalleys item=galley}
						<li>
							{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
						</li>
					{/foreach}
				</ul>
			</div>
		{/if}
	{/capture}

	{capture name="issuePubId"}
		{foreach from=$pubIdPlugins item=pubIdPlugin}
			{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
			{if $pubId}
				{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
				<div class="pub_id {$pubIdPlugin->getPubIdType()|escape}">
					<span class="type">
						{$pubIdPlugin->getPubIdDisplayType()|escape}:
					</span>
					<span class="id">
						{if $doiUrl}
							<a href="{$doiUrl|escape}">
								{$doiUrl}
							</a>
						{else}
							{$pubId}
						{/if}
					</span>
				</div>
			{/if}
		{/foreach}
	{/capture}
	<section class="box_primary issue__issue-title">
		<div class="container">
			<div class="row">
				{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
				{if $issueCover}
					<div class="col-md-2">
						<a class="cover" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
							<img class="img-fluid" src="{$issueCover|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					</div>
				{/if}
				<div class="col-md-10">
					<h2>
						{$issueIdentification}
					</h2>
					{* Published date *}
					{if $issue->getDatePublished()}
						<div class="published">
					<span class="label small">
						{translate key="submissions.published"}:
					</span>
							<span class="value small">
						{$issue->getDatePublished()|date_format:$dateFormatShort}
					</span>
						</div>
					{/if}
				</div>
			</div>

		</div>
	</section>
	{if $issue->hasDescription() || !$issue->getPublished()}
		<section class="issue__issue-desc">
			<div class="container">
				<div class="row justify-content-center">
					{if !$issue->getPublished()}
						<div class="col-12">
							{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
						</div>
					{/if}
					{* Description *}
					{if $issue->hasDescription()}
						<div class="col-md-4">
							<h3>Description</h3>
						</div>
						<div class="col-md-8">
							<div class="description">
								{$issue->getLocalizedDescription()|strip_unsafe_html}
							</div>
						</div>
					{/if}
				</div>
			</div>
		</section>
	{/if}

	{if $smarty.capture.issueGalleys|trim != "" || $smarty.capture.issuePubId|trim != ""}
		<section class="container issue__issue-data">
			<div>
				<div class="row">
					<div class="col-12">
						{if $smarty.capture.issueGalleys|trim != ""}
							{$smarty.capture.issueGalleys}
						{/if}
						{* PUb IDs (eg - DOI) *}
						{if $smarty.capture.issuePubId|trim != ""}
							{$smarty.capture.issuePubId}
						{/if}
					</div>
				</div>
			</div>
		</section>
	{/if}

	{foreach name=sections from=$publishedSubmissions item=section}
		<section class="no-border issue__section-content">
			{if $section.articles}
				{if $section.title}
					<div class="box_primary issue__section-title">
						<div class="container">
							<h2>
								{$section.title|escape}
							</h2>
						</div>
					</div>
				{/if}
				<div class="container">
					<ul class="row">
						{foreach from=$section.articles item=article}
							<li class="col-md-6 issue__article">
								{include file="frontend/objects/article_summary.tpl"}
							</li>
						{/foreach}
					</ul>
				</div>
			{/if}
		</section>
	{/foreach}

{/block}
