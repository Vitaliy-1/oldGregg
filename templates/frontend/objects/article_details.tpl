{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2016 Vitaliy Bezsheiko, MD
 * Distributed under the GNU GPL v3.
 *
*}
<article class="article_details">
    {if $section}
        {include file="frontend/components/breadcrumbs_article.tpl" currentTitle=$section->getLocalizedTitle()}
    {else}
        {include file="frontend/components/breadcrumbs_article.tpl" currentTitleKey="article.article"}
    {/if}
    {include file="frontend/parser/articleMainText.tpl" currentTitleKey="article.article"}


	<div class="container-fluid">
        <div class="container title-block">
            <div class="before_title">
                <div class="buttons-wrapper row">
                    <div class="col-sm">
                        <p class="open-access">{translate key="jatsParser.openAccess.label"}</p>
                        {if $article->getSectionId() == 3 || $article->getSectionId() == 4 || $article->getSectionId() == 9}
                         <p class="peer-reviewed">{translate key="plugins.themes.peer-reviewed"}</p>
                        {/if}
                    </div>
                    <!-- Load Facebook SDK for JavaScript -->
                    <div class="col-sm">
                        <div class="fb-share-button"
                             data-href="https://{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}"
                             data-layout="button_count" data-size="small" data-mobile-iframe="false">
                        </div>
                        <div class="tw-share-button">
                            <a href="https://twitter.com/share" class="twitter-share-button"
                               data-show-count="false"
                               data-text="{$article->getLocalizedTitle()|trim|strip|escape:"html"}"
                               data-via="emedjournal">
                            </a>
                            <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
                        </div>
                    </div>
                </div>

                {* Facebook share button for tablets and mobile *}
                {*
                <div class="fb-share-button"
                     data-href="https://{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}"
                     data-layout="button_count" data-size="small" data-mobile-iframe="false">
                </div>
                <div class="tw-share-button">
                    <a href="https://twitter.com/share" class="twitter-share-button"
                       data-text="{$article->getLocalizedTitle()|trim|strip|escape:"html"}"
                       data-via="emedjournal">
                    </a>
                    <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
                </div>
                *}

            </div>
            <h1 class="article_title">
                {$article->getLocalizedTitle()|escape}
            </h1>

            {if $article->getLocalizedSubtitle()}
                <h2 class="subtitle text-muted">
                    {$article->getLocalizedSubtitle()|escape}
                </h2>
            {/if}
            {if $article->getAuthors()}
                <ol class="item authors">
                    {foreach from=$article->getAuthors() item=author key=i}
                        <li class="author">
                                <span class="name">
                                    <a class="author-link" data-container="body" data-toggle="popover" data-placement="top" data-content="{if $author->getLocalizedAffiliation()}{$author->getLocalizedAffiliation()|escape}{/if}">
                                        {$author->getFullName()|escape}
                                    </a>
                                </span>
                                <span class="comma">
                                    {if $i < $article->getAuthors()|@count - 1},{/if}
                                </span>
                            {*
                            {if $author->getOrcid()}
                                <span class="orcid">
                                        <a href="{$author->getOrcid()|escape}" target="_blank">
                                            {$author->getOrcid()|escape}
                                        </a>
                                </span>
                            {/if}
                            *}

                        </li>
                    {/foreach}
                </ol>
            {/if}
        </div>
        <div class="article-type">
                    <span class="section-title">
                        {$article->getSectionTitle()}
                    </span>
        </div>
        <div class="container">
            <div class="meta-group row">
                <div class="meta-card meta-left col-lg-4 col-md-12 col-sm-12">
                    <p class="meta-item date-received">
                        {translate key="submissions.submitted"}: {$article->getDateSubmitted()|date_format}
                    </p>
                    <p class="meta-item date-published">
                        {translate key="submissions.published"}: {$article->getDatePublished()|date_format}
                    </p>
                </div>
                <div class="meta-card meta-center col-lg-4 col-md-6 col-sm-12">
                    <p class="meta-item views">{translate key="plugins.themes.PMGPTheme.views.html"}: {$article->getViews()}</p>
                </div>
                <div class="meta-card meta-right col-lg-4 col-md-6 col-sm-12">
                    {foreach from=$pubIdPlugins item=pubIdPlugin}
                        {if $pubIdPlugin->getPubIdType() != 'doi'}
                            {php}continue;{/php}
                        {/if}
                        {if $issue->getPublished()}
                            {assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
                        {else}
                            {assign var=pubId value=$pubIdPlugin->getPubId($article)}{* Preview pubId *}
                        {/if}
                        {if $pubId}
                            {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
                            <p class="meta-item doi">{translate key="plugins.pubIds.doi.readerDisplayName"} <a href="{$doiUrl}">{$doiUrl|regex_replace:"/https:\/\/.*org\//":" "}</a></p>
                        {/if}
                        <p class="meta-item issue">{$issue->getIssueIdentification()}</p>
                    {/foreach}
                </div>
            </div>
        </div>

        {* block with article text and details *}
        <div class="article-block">
            <ul class="nav nav-pills nav-fill" id="pills-tab" role="tablist">
                <li class="nav-item">
                    <a class="fulltext-link nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-article" role="tab" aria-controls="pills-home" aria-selected="true">{translate key="plugins.themes.PMGPTheme.article"}</a>
                </li>
                <li class="nav-item">
                    <a class="details-link nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-details" role="tab" aria-controls="pills-profile" aria-selected="false">{translate key="plugins.themes.PMGPTheme.details"}</a>
                </li>
            </ul>
        </div>

        <div class="tab-content" id="pills-tabContent">
            <div class="tab-pane fade show active" id="pills-article" role="tabpanel" aria-labelledby="pills-home-tab">

                {* article text and intra-article navigation *}
                <div class="text-nav-wrapper row">
                    {call_hook name="Templates::Article::Main"}
                    {* right block *}
                    <div class="col-lg-3 col-sm-0" id="article-right-block">
                        <div class="card mb-3">
                            {if $article->getLocalizedCoverImage()}
                                <img class="card-img-top" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText() != ''} alt="{$article->getLocalizedCoverImageAltText()|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}>
                            {/if}
                            {if $primaryGalleys}
                                <ul class="list-group list-group-flush">
                                    <ul class="value galleys_links list-group list-group-flush">
                                        {foreach from=$primaryGalleys item=galley}
                                            {if $galley->getFileType() != "text/html"}
                                            <li class="list-group-item">
                                                {include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
                                            </li>
                                            {/if}
                                        {/foreach}
                                    </ul>
                                </ul>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>


            <div class="tab-pane fade" id="pills-details" role="tabpanel" aria-labelledby="pills-profile-tab">
                <div class="details container">

                    <div class="card-group">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">{translate key="submission.license"}</h3>
                                </div>
                                <div class="card-body">
                                    {if $copyright || $licenseUrl}
                                        <div class="item copyright">
                                            {$ccLicenseBadge}
                                        </div>
                                    {/if}
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">{translate key="plugins.themes.PMGPTheme.copyright"}</h3>
                                </div>
                                <div class="card-body">
                                    <p class="card-text">&#169; {$article->getCopyrightHolder($article->getLocale())}, {$article->getCopyrightYear()}</p>
                                </div>
                            </div>
                    </div>

                    {* How to cite *}
                    {if $citation}
                        <div class="item citation card-group">
                            <div class="sub_item citation_display card">
                                <div class="label card-header">
                                    <h3 class="card-title">
                                    {translate key="submission.howToCite"}
                                    </h3>
                                </div>
                                <div class="value card-body">
                                    <div id="citationOutput" role="region" aria-live="polite">
                                        {$citation}
                                    </div>
                                    <div class="citation_formats dropdown">
                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            {translate key="submission.howToCite.citationFormats"}
                                        </button>
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
                                                        <a class="dropdown-item" href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
                                                            <span class="fa fa-download"></span>
                                                            {$citationDownload.title|escape}
                                                        </a>
                                                    {/foreach}
                                                </ul>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/if}

                    {* Article Statistics *}

                    <div id="for-statistics" class="item citation card-group">
                        <div class="card article_metrics" id="article_metrics">
                            <div class="card-header article-html-views">
                                <h3 class="card-title">{translate key="plugins.themes.PMGPTheme.affiliations"}</h3>
                            </div>
                            <div class="card-body">
                                {if $article->getAuthors()}
                                    {foreach from=$article->getAuthors() item=author key=y}
                                        <p class="card-text">
                                            <i>{$author->getFullName()|escape}</i><br/>
                                            {if $author->getLocalizedAffiliation()}{$author->getLocalizedAffiliation()|escape}{else}{translate key="plugins.themes.PMGPTheme.no-affiliation"}{/if}
                                         </p>
                                    {/foreach}
                                {/if}
                            </div>
                        </div>
                    </div>

                    {* Keywords *}
                    {* @todo keywords not yet implemented *}

                    {* Article Subject *}
                    {if $article->getLocalizedSubject()}
                        <div>
                            <h3>
                                {translate key="article.subject"}
                            </h3>
                            <div>
                                {$article->getLocalizedSubject()|escape}
                            </div>
                        </div>
                    {/if}


                    {call_hook name="Templates::Article::Details"}

                </div>
            </div>
        </div>
		</div>

</article>
