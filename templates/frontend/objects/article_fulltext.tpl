{**
 * templates/frontend/objects/article_fulltext.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

{* Download JATS XML if it is in the Galley *}
{if $sections}
    <div class="article-text-row row flex-row-reverse">
        {include file="frontend/parser/articleMainText.tpl"}
    </div>
{else}
    <div class="article-text-row row flex-row-reverse">
        {include file="frontend/objects/articleOnlyAbstract.tpl"}
    </div>
{/if}
