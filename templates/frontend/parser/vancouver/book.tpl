{**
 * plugins/themes/oldGregg/templates/frontend/parser/vancouver/book.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @brief template for parsing book references
 *}

{** writing book title *}
<span class="ref-title">{$reference->getTitle()}</span>

{** writing authors names or collab*}
<span class="ref-auth">
    {include file="frontend/parser/$cslStyle/authors.tpl"}
</span>

{** writing year, publisher name and location *}
<span class="ref-source">{strip}
    {if $reference->getPublisherLoc() != '' && $reference->getPublisherName() != ''}
        {$reference->getPublisherLoc()}:
    {elseif $reference->getPublisherLoc() != '' && $reference->getPublisherName() == ''}
        {$reference->getPublisherLoc()}
    {/if}{/strip} {strip}
    {if $reference->getPublisherName() != '' && $reference->getYear() != ''}
        {$reference->getPublisherName()};
    {elseif $reference->getPublisherName() != '' && $reference->getYear() == ''}
        {$reference->getPublisherName()}
    {/if}{/strip} {strip}
    {if $reference->getYear() != ''}
        {$reference->getYear()}
    {/if}
    .
    {/strip}</span>

{** writing URL, DOI, PMID, PMCID *}

{if $reference->getPubIdType() !== ''|| $reference->getUrl() !== ''}
    {include file="frontend/parser/$cslStyle/links.tpl"}
{/if}