{**
 * templates/frontend/objects/article_fulltext.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

{if $sections}
    <div class="article-text-row row flex-row-reverse">
    {include file="frontend/parser/articleMainText.tpl"}
    </div>
{/if}
