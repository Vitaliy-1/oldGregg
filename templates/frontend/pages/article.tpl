{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko, MD
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getLocalizedTitle()|escape}
<div class="page page_article">
    {if $requestedPage|escape != "article"}
		{if $section}
			{include file="frontend/components/breadcrumbs_article.tpl" currentTitle=$section->getLocalizedTitle()}
		{else}
			{include file="frontend/components/breadcrumbs_article.tpl" currentTitleKey="article.article"}
		{/if}
	{/if}

	{* Show article overview *}
    {if $sections}
		<div class="article-text-row row flex-row-reverse">
            {include file="frontend/parser/articleMainText.tpl"}
		</div>
    {else}
		<div class="article-text-row row flex-row-reverse">
            {include file="frontend/objects/articleOnlyAbstract.tpl"}
		</div>
    {/if}

</div><!-- .page -->

