{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal">
    <div class="index-page-content">
        <div class="row">
            <div class="col-md-8">
                <div class="row">
                    {if $showSummary && $journalDescription}
                        <div class="journal-summary-title col-md-12">
                            <h3>{translate key="plugins.gregg.journal.summary"}</h3>
                        </div>
                        <div class="summary-content">
                            {$journalDescription}
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
                                            {$article->getLocalizedTitle()|strip|escape:"html"}
                                        </a>
                                    </h4>
                                    <p class="card-text">
                                        {foreach from=$article->getAuthors() key=k item=author}
                                            <span>{$author->getLastName()|strip|escape:"html"}
                                                {if $k<($article->getAuthors()|@count - 1)}
                                                    {$author->getFirstName()|regex_replace:"/(?<=\w)\w+/":".,"}
                                                {else}
                                                    {$author->getFirstName()|regex_replace:"/(?<=\w)\w+/":"."}
                                                {/if}</span>
                                        {/foreach}
                                    </p>
                                </div>
                                <div class="card-footer">
                                    <small class="text-muted">
                                        {$article->getSectionTitle()}
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
                    {call_hook|assign:"sidebarCode" name="Templates::Common::Sidebar"}
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
