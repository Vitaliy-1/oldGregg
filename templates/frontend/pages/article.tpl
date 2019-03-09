{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko, MD
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getLocalizedTitle()|escape}
<div class="page page_article">

	{* Show article overview *}
	{include file="frontend/objects/article_details.tpl"}

    {call_hook name="Templates::Article::Footer::PageFooter"}

</div><!-- .page -->
{include file="frontend/components/footer.tpl"}

