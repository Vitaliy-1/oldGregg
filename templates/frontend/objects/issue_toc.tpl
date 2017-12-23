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

            {* Issue cover image *}
            {assign var=issueCover value=$issue->getLocalizedCoverImage()}
            {if $issueCover}
                <a class="cover" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
                    <img src="{$coverImagePath|escape}{$issueCover|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
                </a>
            {/if}

            {* Description *}
            {if $issue->hasDescription()}
                <div class="description">
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

            {* Published date *}
            {*
            {if $issue->getDatePublished()}
                <div class="published">
                    <span class="label label-default">
                        {translate key="submissions.published"}:
                    </span>
                    <span class="value">
                        &nbsp;{$issue->getDatePublished()|date_format:$dateFormatShort}
                    </span>
                </div>
            {/if}
            *}
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
        <div class="sections">
            <div class="section-name-wrapper">
                {foreach name=sections from=$publishedArticles item=section}
                    {if $section.articles}
                        {if $section.title}
                            <div class="alert alert-secondary" role="alert">
                                <h2 class="section-name text-center">
                                {$section.title|escape}
                                </h2>
                            </div>
                        {/if}
                        <div class="articles row">
                            {foreach from=$section.articles item=article}
                                <div class="article-issue-wrapper  col-md-6 col-lg-4">
                                    <div class="card">
                                         {include file="frontend/objects/article_summary.tpl"}
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div><!-- .sections -->
    </div><!-- container -->
</div>
