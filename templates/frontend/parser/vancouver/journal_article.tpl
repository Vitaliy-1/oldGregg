{**
 * plugins/generic/jatsParser/templates/vancouver/journal_article.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * @brief template for writing journal article references
 *}

{** writing article title *}
<span class="ref-title">{$reference->getTitle()}</span>

{** writing authors names or collab*}
{include file="frontend/parser/vancouver/names.tpl"}

{** writing year, volume, issue, pages*}
{strip}
<span class="ref-source">
    {$reference->getSource()}.
    {if $reference->getVolume() == NULL && $reference->getIssue() == NULL && $reference->getFpage() == NULL && $reference->getLpage() == NULL}
        {$reference->getYear()}
    {else}
        {$reference->getYear()};
    {/if}
    {$reference->getVolume()}
    {if $reference->getIssue() != NULL}
        ({$reference->getIssue()})
    {/if}
    {if $reference->getFpage() != NULL || $reference->getLpage() != NULL}
        :
    {/if}
    {if $reference->getFpage() != NULL && $reference->getLpage() != NULL}
        {$reference->getFpage()}-{$reference->getLpage()}
    {elseif $reference->getFpage() != NULL && $reference->getLpage() == NULL}
        {$reference->getFpage()}
    {elseif $reference->getFpage() == NULL && $reference->getLpage() != NULL}
        {$reference->getLpage()}
    {/if}
    .
</span>
{/strip}

{** writing URL, DOI, PMID*}
{if $reference->getDoi() != NULL || $reference->getPmid() != NULL || $reference->getUrl() != NULL}
    {include file="frontend/parser/$cslStyle/links.tpl"}
{/if}

