{**
 * plugins/generic/jatsParser/templates/vancouver/conference.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * @brief template for parsing conference papers
 *}

{** writing conference paper title *}
<span class="ref-title">{$reference->getSource()}</span>

{** writing authors names or collab*}
{include file="frontend/parser/vancouver/names.tpl"}

{** writing year, publisher name and location *}
<span class="ref-source">Paper presented at: {strip}
    {if $reference->getConfName() != NULL && ($reference->getYear() != NULL || $reference->getConfDate() != NULL || $reference->getConfLoc() != NULL)}
        {$reference->getConfName()};
    {else}
        {$reference->getConfName()}
    {/if}
    {/strip} {strip}
    {if $reference->getConfDate() != NULL && $reference->getYear() != NULL}
        {$reference->getConfDate()},
    {elseif $reference->getConfDate() != NULL && $reference->getYear() == NULL && $reference->getConfLoc() != NULL}
        {$reference->getConfDate()},
    {elseif $reference->getConfDate() != NULL && $reference->getYear() == NULL && $reference->getConfLoc() == NULL}
        {$reference->getConfDate()}
    {/if}
    {/strip} {strip}
    {if $reference->getYear() != NULL && $reference->getConfLoc() != NULL}
        {$reference->getYear()}.
    {elseif $reference->getYear() != NULL && $reference->getConfLoc() == NULL}
        {$reference->getYear()}
    {/if}
    {if $reference->getConfLoc() != NULL}
        {$reference->getConfLoc()}
    {/if}
    .{/strip}
</span>

{** writing URL, DOI, PMID*}
{if $reference->getDoi() != NULL || $reference->getPmid != NULL || $reference->getUrl() != NULL}
    {include file="`$path_template`/vancouver/links.tpl"}
{/if}