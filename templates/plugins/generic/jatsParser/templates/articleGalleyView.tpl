{**
 * plugins/generic/jatsParser/templates/articleView.tpl
 *
 * Copyright (c) 2017-2018 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief Page for displaying JATS XML galley as HTML
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
						<img class="jatsParser__cover"
							 src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
                    {else}
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							<img class="jatsParser__cover"
								 src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
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
									<a class="jatsParser__meta-orcidImage"
									   href="{$authorString->getOrcid()|escape}"><img
												src="{$baseUrl}/{$jatsParserOrcidImage}"></a>
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
						<div class="jatsParser__details-author jatsParser__hideAuthor"
							 id="jatsParser__author-{$authorKey+1}">
                            {if $author->getLocalizedAffiliation()}
								<div class="jatsParser__details-author-affiliation">{$author->getLocalizedAffiliation()|escape}</div>
                            {/if}
                            {if $author->getLocalizedBiography()}
								<a href="#jatsParser__modal-bio-{$authorKey+1}" class="jatsParser__details-bio-toggle"
								   id="jatsParser__modal-bio-link-{$authorKey+1}">
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
                        {foreach from=$keywords item=keywordArray}
                            {foreach from=$keywordArray item=keyword key=k}
								<span class="jatsParser__keyword">{$keyword|escape}</span>
                            {/foreach}
                        {/foreach}
					</div>
				</div>
            {/if}
		</div>
		<div class="jatsParser__articleView">
			<div class="jatsParser__left-article-block">
                {if $generatePdfUrl}
					<div class="jatsParser__pdf-link-wrapper">
						<a class="jatsParser__link-pdf" href="{$generatePdfUrl}"
						   title="{translate key="plugins.generic.jatsParser.pdf.read.label"}">
							<span class="jatsParser__link-pdf-text">{translate key="plugins.generic.jatsParser.pdf.read.symbol-text"}</span>
						</a>
					</div>
                {/if}
			</div>
			<div class="jatsParser__center-article-block">
				<div class="jatsParser__article-fulltext" id="jatsParserFullText">
                    {if $article->getLocalizedAbstract()}
						<h2 class="article-section-title jatsParser__abstract">{translate key="article.abstract"}</h2>
                        {$article->getLocalizedAbstract()|strip_unsafe_html}
                    {/if}

                    {$htmlDocument}

				</div>
			</div>
			<div class="jatsParser__right-article-block">
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
