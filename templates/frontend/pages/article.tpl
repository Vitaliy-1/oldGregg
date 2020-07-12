{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2018-2019 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *}

{extends "frontend/layouts/general.tpl"}

{assign var="pageTitleTranslated" value=$article->getLocalizedTitle()|escape}

{block name="pageContent"}
	<div class="jatsParser__container">

		<div class="jatsParser__meta">
            {* Cover image *}
            {if $article->getLocalizedCoverImage() || $issue->getLocalizedCoverImage()}
				<div class="jatsParser__cover-wrapper">
                    {if $article->getLocalizedCoverImage()}
						<img class="jatsParser__cover" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
                    {else}
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							<img class="jatsParser__cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
                    {/if}
				</div>
            {/if}
			<div class="jatsParser__meta-row">

                {* Section title *}
                {if $article->getSectionTitle()}
					<div class="jatsParser__meta-section-title">
                        {$article->getSectionTitle()|escape}
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
						<div class="jatsParser__meta-doi">
						<span class="jatsParser__doi-label">
							{capture assign=translatedDOI}{translate key="plugins.pubIds.doi.readerDisplayName"}{/capture}
                            {translate key="semicolon" label=$translatedDOI}
						</span>
							<span class="jatsParser__meta-doi-value">
							<a href="{$doiUrl}">
								{* maching DOI's (with new and old format) *}
                                {$doiUrl|regex_replace:"/http.*org\//":" "}
							</a>
						</span>
						</div>
                    {/if}
                {/foreach}

                {* Submitted date *}
                {if $article->getDateSubmitted()}
					<div class="jatsParser__meta-date-submitted">
					<span>{translate key="submissions.submitted"}:<span> <span>{$article->getDateSubmitted()|date_format:$dateFormatShort}</span>
					</div>
                {/if}

                {* Published date *}
                {if $article->getDatePublished()}
					<div class="jatsParser__meta-date-published">
					<span>{translate key="submissions.published"}:<span> <span>{$article->getDatePublished()|date_format:$dateFormatShort}</span>
					</div>
                {/if}
			</div>

            {* Article title *}
            {if $article->getLocalizedFullTitle()}
				<h1 class="jatsParser__meta-title">{$article->getLocalizedFullTitle()|escape}</h1>
            {/if}

            {* Authors' list *}
            {if $article->getAuthors()}
				<ul class="jatsParser__meta-authors">
                    {foreach from=$article->getAuthors() item=authorString key=authorStringKey}
                        {strip}
							<li>
								<a class="jatsParser__meta-author-string-href" href="#author-{$authorStringKey+1}">
									<span class="jatsParser__meta-author">{$authorString->getFullName()|escape}</span>
									<sup class="jatsParser__meta-symbol jatsParser__symbol-plus">+</sup>
									<sup class="jatsParser__meta-symbol jatsParser__symbol-minus jatsParser__hide">&minus;</sup>
								</a>
                                {if $authorString->getOrcid()}
									<a class="jatsParser__meta-orcidImage" href="{$authorString->getOrcid()|escape}"><img src="{$orcidImagePath}"></a>
                                {/if}
							</li>
                        {/strip}
                    {/foreach}
				</ul>

                {* Authors *}
                {assign var="authorCount" value=$article->getAuthors()|@count}
                {assign var="authorBioIndex" value=0}
				<div class="jatsParser__details-authors">
                    {foreach from=$article->getAuthors() item=author key=authorKey}
						<div class="jatsParser__details-author jatsParser__hideAuthor" id="jatsParser__author-{$authorKey+1}">
                            {if $author->getLocalizedAffiliation()}
								<div class="jatsParser__details-author-affiliation">{$author->getLocalizedAffiliation()|escape}</div>
                            {/if}
                            {if $author->getLocalizedBiography()}
								<a href="#jatsParser__modal-bio-{$authorKey+1}" class="jatsParser__details-bio-toggle" id="jatsParser__modal-bio-link-{$authorKey+1}">
                                    {translate key="plugins.generic.jatsParser.article.authorBio"}
								</a>
								<div class="jatsParser__modal-bio" id="jatsParser__modal-bio-{$authorKey+1}">
									<div class="jatsParser__modal-bio-content">
										<span class="jatsParser__close">&times;</span>
										<h4 class="jatsParser__modal-bio-name">
                                            {$author->getFullName()|escape}
										</h4>
                                        {$author->getLocalizedBiography()|strip_unsafe_html}
									</div>
								</div>
                            {/if}
						</div>
                    {/foreach}
				</div>

            {/if}

            {* Keywords *}
            {if !empty($keywords[$currentLocale])}
				<div class="jatsParser__keywords-wrapper">
					<div class="jatsParser__keywords-row">
                        {foreach name="keywords" from=$publication->getLocalizedData('keywords') item="keyword"}
							<span class="jatsParser__keyword">{$keyword|escape}</span>
                        {/foreach}
					</div>
				</div>
            {/if}
		</div>
		<div class="jatsParser__articleView">
			<div class="jatsParser__left-article-block">
				{* Article Galleys *}
				{if $primaryGalleys || $supplementaryGalleys}
					<div class="article-page__galleys">
						{if $primaryGalleys}
							<ul class="list-galleys primary-galleys">
								{foreach from=$primaryGalleys item=galley}
									<li>
										{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
									</li>
								{/foreach}
							</ul>
						{/if}
						{if $supplementaryGalleys}
							<ul class="list-galleys supplementary-galleys">
								{foreach from=$supplementaryGalleys item=galley}
									<li>
										{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley isSupplementary="1"}
									</li>
								{/foreach}
							</ul>
						{/if}
					</div>
				{/if}
			</div>
			<div class="jatsParser__center-article-block">
				<div class="jatsParser__article-fulltext" id="jatsParserFullText">
                    {if $article->getLocalizedAbstract()}
						<h2 class="article-section-title jatsParser__abstract">{translate key="article.abstract"}</h2>
                        {$article->getLocalizedAbstract()|strip_unsafe_html}
                    {/if}

                    {call_hook name="Templates::Article::Main"}

                    {* References *}
                    {if $parsedCitations || $publication->getData('citationsRaw')}
						<h2 class="article-section-title jatsParser__references">{translate key="submission.citations"}</h2>
						{if $parsedCitations}
							<ol class="jatsParser__references-list">
								{foreach from=$parsedCitations item="parsedCitation"}
									<li>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</li>
								{/foreach}
							</ol>
						{else}
							<div class="jatsParser__references-list">
								{$publication->getData('citationsRaw')|escape|nl2br}
							</div>
						{/if}
                    {/if}

				</div>
			</div>
			<div class="jatsParser__right-article-block">
				{* How to cite *}
				{if $citation}
					<h3 class="article__header">
						{translate key="submission.howToCite"}
					</h3>
					<div class="citation_format_value">
						<div id="citationOutput" role="region" aria-live="polite">
							{$citation}
						</div>
						<div class="citation_formats dropdown">
							<a class="btn btn-primary btn-light" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
							   aria-expanded="false">
								{translate key="submission.howToCite.citationFormats"}
							</a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="dropdown-cit">
								{foreach from=$citationStyles item="citationStyle"}
									<a
											class="dropdown-cite-link dropdown-item"
											aria-controls="citationOutput"
											href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
											data-load-citation
											data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
									>
										{$citationStyle.title|escape}
									</a>
								{/foreach}
								{if count($citationDownloads)}
									<div class="dropdown-divider"></div>
									<h4 class="download-cite">
										{translate key="submission.howToCite.downloadCitation"}
									</h4>
									{foreach from=$citationDownloads item="citationDownload"}
										<a class="dropdown-cite-link dropdown-item"
										   href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
											{$citationDownload.title|escape}
										</a>
									{/foreach}
								{/if}
							</div>
						</div>
					</div>
				{/if}

				<div class="jatsParser__intraarticle-menu">
					<div id="jatsParser__navbar-article" class="jatsParser__navbar">
						<nav class="jatsParser__navbar-items" id="jatsParser__navbarItems">
                            {* adding menu by javascript here *}
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>

{/block}
