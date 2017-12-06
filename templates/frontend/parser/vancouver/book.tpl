{**
 * plugins/generic/jatsParser/templates/vancouver/journal_article.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * @brief template for parsing book references
 *}

{** writing book title *}
<span class="ref-title">{$reference->getSource()}</span>

{** writing authors names or collab*}
{include file="frontend/parser/vancouver/names.tpl"}

{** writing year, publisher name and location *}
<span class="ref-source">{strip}
    {if $reference->getPublisherLoc() != NULL && $reference->getPublisherName() != NULL}
        {$reference->getPublisherLoc()}:
    {elseif $reference->getPublisherLoc() != NULL && $reference->getPublisherName() == NULL}
        {$reference->getPublisherLoc()}
    {/if}{/strip} {strip}
    {if $reference->getPublisherName() != NULL && $reference->getYear() != NULL}
        {$reference->getPublisherName()};
    {elseif $reference->getPublisherName() != NULL && $reference->getYear() == NULL}
        {$reference->getPublisherName()}
    {/if}{/strip} {strip}
    {if $reference->getYear() != NULL}
        {$reference->getYear()}
    {/if}
    .
    {/strip}</span>

{** writing URL, DOI, PMID*}
{if $reference->getDoi() != NULL || $reference->getPmid != NULL || $reference->getUrl() != NULL}
    {include file="frontend/parser/vancouver/links.tpl"}
{/if}