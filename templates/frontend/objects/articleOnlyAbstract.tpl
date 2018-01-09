{**
 * plugins/generic/jatsParser/templates/articleMainText.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A base template for displaying parsed article's JATS XML
 *}

{* intra-article navigation *}
<div class="col-lg-6" id="article-nav">
    <div id="nav-absolute-position">
        <nav class="article-menu nav nav-tabs" id="myTab" role="tablist">
            <a class="nav-item nav-link" id="nav-article-tab" data-toggle="tab" href="#nav-article" role="tab" aria-controls="nav-article" aria-selected="false">
                <i class="fas fa-sticky-note fa-lg"></i>
                <span class="tab-title">
                    {translate key="plugins.gregg.article"}
                </span>
            </a>
            <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-references" role="tab" aria-controls="nav-references" aria-selected="false">
                <i class="fas fa-quote-left fa-lg"></i>
                <span class="tab-title">
                    {translate key="plugins.gregg.references"}
                </span>
            </a>
            <a class="nav-item nav-link active" id="nav-download-tab" data-toggle="tab" href="#nav-download" role="tab" aria-controls="nav-download" aria-selected="false">
                <i class="fas fa-download fa-lg"></i>
                <span class="tab-title">
                    {translate key="plugins.gregg.download"}
                </span>
            </a>
            <a class="nav-item nav-link" id="nav-details-tab" data-toggle="tab" href="#nav-details" role="tab" aria-controls="nav-details" aria-selected="false">
                <i class="fas fa-info-circle fa-lg"></i>
                <span class="tab-title">
                    {translate key="plugins.gregg.details"}
                </span>
            </a>
        </nav>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade" id="nav-references" role="tabpanel" aria-labelledby="nav-references-tab">
                {* References *}
                {if $article->getCitations()}
                    <div class="references">
                        <div class="value">
                            {if $article->getCitations()}
                                {$article->getCitations()|nl2br}
                            {/if}
                        </div>
                    </div>
                {/if}
            </div>
            <div class="tab-pane fade show active" id="nav-download" role="tabpanel" aria-labelledby="nav-download-tab">
                {if $primaryGalleys}
                    <div class="galleys">
                        <ul class="galley-links">
                            {foreach from=$primaryGalleys item=galley}
                                <li class="galley-links-items">
                                    {include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                {/if}
            </div>
            <div class="tab-pane fade" id="nav-details" role="tabpanel" aria-labelledby="nav-details-tab">
                {if $copyright || $licenseUrl}
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">{translate key="submission.license"}</h3>
                        </div>
                        <div class="card-body">
                            <div class="item copyright">
                                {$ccLicenseBadge}
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">{translate key="plugins.gregg.copyright"}</h3>
                        </div>
                        <div class="card-body">
                            <p class="card-text">&#169; {$article->getCopyrightHolder($article->getLocale())}, {$article->getCopyrightYear()}</p>
                        </div>
                    </div>
                {/if}

                <div class="card article_metrics" id="article_metrics">
                    <div class="card-header article-html-views">
                        <h3 class="card-title">{translate key="plugins.gregg.affiliations"}</h3>
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
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                {call_hook name="Templates::Article::Details"}
            </div>
            <div class="tab-pane fade" id="nav-article" role="tabpanel" aria-labelledby="nav-article-tab">
                <div id="floating-mobile-content">
                    <a id="goto-content">Content</a>
                    <a id="goto-top">Top</a>
                </div>
            </div>

        </div>

    </div>
</div>

{* Article text *}

<div class="col-lg-6" id="full-article-block">
    <div id="article-absolute-position" data-spy="scroll" data-target="#navbar-article-links" data-offset="0">
        <div class="article-title-block">
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
                        </li>
                    {/foreach}
                </ol>
            {/if}
            <div class="article-meta">
                <div class="article-issue">
                    <p class="meta-item issue">
                        <span>{$issue->getIssueIdentification()}</span>
                    </p>
                </div>
                <div class="article-doi">
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
                    {/foreach}
                </div>
                <div class="article-dates">
                    <p class="meta-item date-received">
                        <span>{translate key="submissions.submitted"}:</span> {$article->getDateSubmitted()|date_format}
                    </p>
                    <p class="meta-item date-published">
                        <span>{translate key="submissions.published"}:</span> {$article->getDatePublished()|date_format}
                    </p>
                </div>
            </div>
        </div>
        <div class="article-text">
            {** get abstract *}
            {if $article->getLocalizedAbstract()}
                {include file="frontend/parser/abstract.tpl"}
            {/if}
        </div>
    </div>

