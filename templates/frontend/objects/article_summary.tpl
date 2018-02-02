{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}
{assign var=articlePath value=$article->getBestArticleId()}
{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
    {assign var="showAuthor" value=true}
{/if}

{capture name="articleCardBlock"}
    <div class="card-body">
        <h4 class="issue-article-title card-title">
            <a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
                {$article->getLocalizedTitle()|strip_unsafe_html}
            </a>
        </h4>
        {if $showAuthor}
            <p class="issue-auth card-text">
                {$article->getAuthorString()}
            </p>
        {/if}
        <p>
            <small class="issue-article-number text-muted">
                {$article->getPages()|escape}
            </small>
            <small class="issue-article-number text-muted">
                |
            </small>
            <small class="issue-article-date text-muted">
                {translate key="plugins.gregg.published"}: {$article->getDatePublished()|date_format:$dateFormatShort}
            </small>
        </p>
    </div>
{/capture}

{if $article->getLocalizedCoverImage()}
    <div class="row">
        <div class="col-md-4">
            <a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
                <img class="article-cover-image img-thumbnail" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText() != ''} alt="{$article->getLocalizedCoverImageAltText()|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}>
            </a>
        </div>
        <div class="col-md-8">
            {$smarty.capture.articleCardBlock}
        </div>
    </div>
{else}
    {$smarty.capture.articleCardBlock}
{/if}

{call_hook name="Templates::Issue::Issue::Article"}

