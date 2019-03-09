{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()|escape}

<div class="page_index_journal">
    <div class="index-page-content">
        <div class="row">
            {if $homepageImage}
                <div class="homepage-image-wrapper col-md-12">
                    <img class="img-fluid homepage_image" src="{$publicFilesDir}/{$homepageImage.uploadName|escape}" alt="{$homepageImageAltText|escape}">
                </div>
            {/if}
            <div class="col-md-8">
                <div class="row">
                    {if $showSummary && $journalDescription}
                        <div class="journal-summary-title col-md-12">
                            <h3>{translate key="plugins.gregg.journal.summary"}</h3>
                        </div>
                        <div class="summary-content">
                            {$journalDescription|strip_unsafe_html}
                        </div>
                    {/if}
                    <div class="recent-articles-section-title col-md-12">
                        <h3>{translate key="plugins.gregg.latest"}</h3>
                    </div>
                    {foreach from=$publishedArticles item=article key=k}
                        <div class="recent-wrapper col-md-6">
                            <div class="card">
                                <a href="{url page="article" op="view" path=$article->getBestArticleId()}">
                                    <img class="card-img-top" src="{$article->getLocalizedCoverImageUrl()|escape}">
                                </a>
                                <div class="card-body">
                                    <h4 class="card-title">
                                        <a class="recent-article-title"
                                           href="{url page="article" op="view" path=$article->getBestArticleId()}">
                                            {$article->getLocalizedTitle()|escape}
                                        </a>
                                    </h4>
                                    <p class="card-text">
                                        {foreach from=$article->getAuthors() key=k item=author}
                                            <span>{$author->getLocalizedFamilyName()|escape}
                                                {if $k<($article->getAuthors()|@count - 1)}
                                                    {$author->getLocalizedGivenName()|regex_replace:"/(?<=\w)\w+/":".,"|escape}
                                                {else}
                                                    {$author->getLocalizedGivenName()|regex_replace:"/(?<=\w)\w+/":"."|escape}
                                                {/if}</span>
                                        {/foreach}
                                    </p>
                                </div>
                                <div class="card-footer">
                                    <small class="text-muted">
                                        {$article->getSectionTitle()|escape}
                                        |
                                        {$article->getDatePublished()|date_format:"%Y-%m-%d"}
                                    </small>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
                {call_hook name="Templates::Index::journal"}
            </div>
            <div class="col-md-4">
                {if empty($isFullWidth)}
                    {capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
                    {if $sidebarCode}
                        {if $latestIssues}
                            {include file="frontend/objects/issue_slider.tpl"}
                        {/if}
                        <div class="pkp_structure_sidebar" role="complementary"
                             aria-label="{translate|escape key="common.navigation.sidebar"}">
                            {$sidebarCode}
                        </div>
                    {/if}
                {/if}
            </div>
        </div>
    </div>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
