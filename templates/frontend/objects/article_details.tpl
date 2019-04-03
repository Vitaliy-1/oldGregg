{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *  Expected to be primary object on the page.
 *
 * Many journals will want to add custom data to this object, either through
 * plugins which attach to hooks on the page or by editing the template
 * themselves. In order to facilitate this, a flexible layout markup pattern has
 * been implemented. If followed, plugins and other content can provide markup
 * in a way that will render consistently with other items on the page. This
 * pattern is used in the .main_entry column and the .entry_details column. It
 * consists of the following:
 *
 * <!-- Wrapper class which provides proper spacing between components -->
 * <div class="item">
 *     <!-- Title/value combination -->
 *     <div class="label">Abstract</div>
 *     <div class="value">Value</div>
 * </div>
 *
 * All styling should be applied by class name, so that titles may use heading
 * elements (eg, <h3>) or any element required.
 *
 * <!-- Example: component with multiple title/value combinations -->
 * <div class="item">
 *     <div class="sub_item">
 *         <div class="label">DOI</div>
 *         <div class="value">12345678</div>
 *     </div>
 *     <div class="sub_item">
 *         <div class="label">Published Date</div>
 *         <div class="value">2015-01-01</div>
 *     </div>
 * </div>
 *
 * <!-- Example: component with no title -->
 * <div class="item">
 *     <div class="value">Whatever you'd like</div>
 * </div>
 *
 * Core components are produced manually below, but can also be added via
 * plugins using the hooks provided:
 *
 * Templates::Article::Main
 * Templates::Article::Details
 *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $citationPlugins Array of citation format plugins
 * @uses $copyright string Copyright notice. Only assigned if statement should
 *   be included with published articles.
 * @uses $copyrightHolder string Name of copyright holder
 * @uses $copyrightYear string Year of copyright
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published articles.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *}
{**
{foreach from=$article->getAuthors() key=k item=author}
    {if $k +1 < $article->getAuthors()|@count }
		<span>
			{$author->getLastName()|strip_unsafe_html} {$author->getFirstName()|strip_unsafe_html|regex_replace:"/(?<=^\w).*/":""}.,
		</span>
    {else}
		<span>
			{$author->getLastName()|strip_unsafe_html} {$author->getFirstName()|strip_unsafe_html|regex_replace:"/(?<=^\w).*/":""}.
		</span>
    {/if}
{/foreach}
*}
<article class="article_details">
    {if $section}
        {include file="frontend/components/breadcrumbs_article.tpl" currentTitle=$section->getLocalizedTitle()}
    {else}
        {include file="frontend/components/breadcrumbs_article.tpl" currentTitleKey="article.article"}
    {/if}

	<div class="article-container container">
		<div class="buttons-wrapper row">
			<div class="col-sm">
				<p class="open-access">{translate key="plugins.gregg.open.access"}</p>
			</div>
			<!-- Load Facebook SDK for JavaScript -->
			<div class="col-sm">
				<div class="fb-share-button"
				     data-href="{$currentUrl}"
				     data-layout="button_count" data-size="small" data-mobile-iframe="false">
				</div>
				<div class="tw-share-button">
					<a href="https://twitter.com/share" class="twitter-share-button"
					   data-show-count="false"
					   data-text="{$article->getLocalizedTitle()|escape}">
					</a>
					<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
				</div>
			</div>
		</div>
		<div class="galley-article-meta row">
			{* Cover image *}
			{if $article->getLocalizedCoverImage() || $issue->getLocalizedCoverImage()}
				<div class="article_cover_wrapper">
					{if $article->getLocalizedCoverImage()}
						<img class="galley-cover-image img-fluid img-thumbnail" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
					{else}
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							<img class="galley-cover-image img-fluid img-thumbnail" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					{/if}
				</div>
			{/if}
			<div class="galley-meta-row">

				{* Submitted date *}
				{if $article->getDateSubmitted()}
					<div class="galley-article-date-submitted">
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
						<div class="galley-article-doi">
						<span class="galley-doi-label">
							{capture assign=translatedDOI}{translate key="plugins.pubIds.doi.readerDisplayName"}{/capture}
							{translate key="semicolon" label=$translatedDOI}
						</span>
							<span class="galley-doi-value">
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
					<div class="galley-article-section-title">
						{$article->getSectionTitle()|escape}
					</div>
				{/if}

				{* Published date *}
				{if $article->getDatePublished()}
					<div class="galley-article-date-published">
					<span>{translate key="submissions.published"}:<span> <span>{$article->getDatePublished()|date_format:$dateFormatShort}</span>
					</div>
				{/if}
			</div>

			{* Article title *}
			{if $article->getLocalizedFullTitle()}
				<h1>{$article->getLocalizedFullTitle()|escape}</h1>
			{/if}

			{* Authors' list *}
			{if $article->getAuthors()}
				<ul class="authors-string">
					{foreach from=$article->getAuthors() item=authorString key=authorStringKey}
						{strip}
							<li>
								<a class="jatsparser-author-string-href" href="#author-{$authorStringKey+1}">
									<span>{$authorString->getFullName()|escape}</span>
									<sup class="author-symbol author-plus">+</sup>
									<sup class="author-symbol author-minus hide">&minus;</sup>
								</a>
								{if $authorString->getOrcid()}
									<a class="orcidImage" href="{$authorString->getOrcid()|escape}"><img src="{$baseUrl}/{$jatsParserOrcidImage}"></a>
								{/if}
							</li>
						{/strip}
					{/foreach}
				</ul>

				{* Authors *}
				{assign var="authorCount" value=$article->getAuthors()|@count}
				{assign var="authorBioIndex" value=0}
				<div class="article-details-authors">
					{foreach from=$article->getAuthors() item=author key=authorKey}
						<div class="article-details-author hideAuthor" id="author-{$authorKey+1}">
							{if $author->getLocalizedAffiliation()}
								<div class="article-details-author-affiliation">{$author->getLocalizedAffiliation()|escape}</div>
							{/if}
							{if $author->getOrcid()}
								<div class="article-details-author-orcid">
									<a href="{$author->getOrcid()|escape}" target="_blank">
										{$orcidIcon}
										{$author->getOrcid()|escape}
									</a>
								</div>
							{/if}
							{if $author->getLocalizedBiography()}
								<a class="article-details-bio-toggle" data-toggle="modal" data-target="#authorBiographyModal{$authorKey+1}">
									{translate key="plugins.themes.healthSciences.article.authorBio"}
								</a>
								{* Store author biographies to print as modals in the footer *}
								<div
										class="modal fade"
										id="authorBiographyModal{$authorKey+1}"
										tabindex="-1"
										role="dialog"
										aria-labelledby="authorBiographyModalTitle{$authorKey+1}"
										aria-hidden="true"
								>
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<div class="modal-title" id="authorBiographyModalTitle{$authorKey+1}">
													{$author->getFullName()|escape}
												</div>
												<button type="button" class="close" data-dismiss="modal" aria-label="{translate|escape key="common.close"}">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												{$author->getLocalizedBiography()|strip_unsafe_html}
											</div>
										</div>
									</div>
								</div>
							{/if}
						</div>
					{/foreach}
				</div>

			{/if}

			{* Keywords *}
			{if !empty($keywords[$currentLocale])}
				<div class="galley-keywords-wrapper">
					<div class="galley-keywords-row">
						{foreach from=$keywords item=keywordArray}
							{foreach from=$keywordArray item=keyword key=k}
								<span class="galley-span-keyword">{$keyword|escape}</span>
							{/foreach}
						{/foreach}
					</div>
				</div>
			{/if}
		</div>
		<div class="articleView-data row">
			<div class="left-article-block col-xl-3">
				{if $generatePdfUrl || $primaryGalleys}
					<div class="galley-link-wrapper">
						{if $generatePdfUrl}
							<a class="galley-link" href="{$generatePdfUrl}">
								<i class="fas fa-file-pdf fa-2x"></i>
							</a>
						{/if}

						{if $primaryGalleys}
							{foreach from=$primaryGalleys item=galley}
									{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
							{/foreach}
						{/if}
					</div>
				{/if}
			</div>
			<div class="col-xl-6 col-lg-8">
				<div class="article-fulltext">
					{if $article->getLocalizedAbstract()}
						<h2 class="article-section-title article-abstract">{translate key="article.abstract"}</h2>
						{$article->getLocalizedAbstract()|strip_unsafe_html}
					{/if}

					{$htmlDocument}

				</div>
			</div>
			<div class="details-wrapper col-xl-3 col-lg-4">
				<div class="intraarticle-menu">
					<nav id="article-navbar" class="navbar navbar-light">
						<nav class="nav nav-pills flex-column" id="article-navigation-menu-items">
							{* adding menu by javascript here *}
						</nav>
					</nav>
				</div>
			</div>
		</div>
	</div>

</article>
