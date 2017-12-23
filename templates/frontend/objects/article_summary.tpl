{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 *}
{assign var=articlePath value=$article->getBestArticleId()}
{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
    {assign var="showAuthor" value=true}
{/if}

{if $article->getLocalizedCoverImage()}
	<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if} class="file">
		<img class="card-img-top" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText() != ''} alt="{$article->getLocalizedCoverImageAltText()|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}>
	</a>
{/if}

<div class="card-body">
    <h3 class="issue-article-title card-title">
        <a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>

            {$article->getLocalizedTitle()|strip_unsafe_html}

        </a>
    </h3>
    {if $showAuthor}
		<p class="issue-auth card-text">
            {$article->getAuthorString()}
		</p>
    {/if}
    {*
    {if $article->getLocalizedAbstract()}
        <p class="summary card-text">
            {if preg_match("/<p>(.*)<\/p>/U", $article->getLocalizedAbstract()|strip_unsafe_html, $match)}
                {foreach from=$match[1] item=summary}{strip}
                    <a class="for-summary" href="{url page="article" op="view" path=$articlePath}">
                        {$summary|regex_replace:"/^\s*(<strong>.*<\/strong>)(?:[ ]*[:\.][ ]*)?/u":""}
                    </a>
                {/strip}{/foreach}
            {/if}
        </p>
    {/if}
     *}
</div>
<div class="card-footer">
        <small class="issue-article-date text-muted">
            {translate key="plugins.browse.published"}: {$article->getDatePublished()|date_format:$dateFormatShort}
        </small>
        <small class="issue-article-number text-muted">
            {$article->getPages()|escape}
        </small>
</div>

{call_hook name="Templates::Issue::Issue::Article"}

