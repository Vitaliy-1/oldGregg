{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko, MD
 *
 * Distributed under the GNU GPL v3.
 *
 *}
<div class="obj_issue_toc">
    <div class="container">

        {* Indicate if this is only a preview *}
        {if !$issue->getPublished()}
            {include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
        {/if}

        {* Issue introduction area above articles *}
        <div class="heading">

            {* Description *}
            {if $issue->hasDescription()}
                <div class="injournal-description">
                    {$issue->getLocalizedDescription()|strip_unsafe_html}
                </div>
            {/if}

            {* PUb IDs (eg - DOI) *}
            {foreach from=$pubIdPlugins item=pubIdPlugin}
                {if $issue->getPublished()}
                    {assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
                {else}
                    {assign var=pubId value=$pubIdPlugin->getPubId($issue)}{* Preview pubId *}
                {/if}
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
        </div>

        {* Full-issue galleys *}

        {if $issueGalleys && $hasAccess}
            <div class="galleys">
                <h2>
                    {translate key="issue.fullIssue"}
                </h2>
                <ul class="galleys_links">
                    {foreach from=$issueGalleys item=galley}
                        <li>
                            {include file="frontend/objects/galley_link.tpl" parent=$issue}
                        </li>
                    {/foreach}
                </ul>
            </div>
        {/if}

        {* Articles *}

        {foreach name=sections from=$publishedArticles item=section}
            {if $section.articles}
                {if $section.title}
                    <h2 class="issue-section-title text-center">
                        {$section.title|escape}
                    </h2>
                {/if}
                {foreach from=$section.articles item=article}
                    <div class="card one-article-intoc">
                        {if $article->getLocalizedCoverImage()}
                        <div class="row">
                            <div class="col-md-4">
                                <a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if} class="file">
                                    <img class="article-cover-image img-thumbnail" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText() != ''} alt="{$article->getLocalizedCoverImageAltText()|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}>
                                </a>
                            </div>
                            <div class="col-md-8">
                            {include file="frontend/objects/article_summary.tpl"}
                            </div>
                        </div>
                        {else}
                            {include file="frontend/objects/article_summary.tpl"}
                        {/if}
                    </div>
                {/foreach}
            {/if}
        {/foreach}
    </div><!-- container -->
</div>
