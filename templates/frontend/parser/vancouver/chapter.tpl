{**
 * plugins/themes/oldGregg/templates/frontend/parser/vancouver/chapter.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @brief template for parsing book chapter references
 *}

{** writing book title *}
<span class="ref-title">{$reference->getTitle()}</span>

{** writing authors names or collab*}
<span class="ref-auth">
    {include file="frontend/parser/$cslStyle/authors.tpl"}
</span>

{** writing book editors, title, publisher name, year etc. *}
<span class="ref-source">
        In:
        {include file="frontend/parser/$cslStyle/editors.tpl"}

        {if $reference->getBook() != ''}
            {$reference->getBook()}.
        {/if}
        {if $reference->getPublisherLoc() != '' && $reference->getPublisherName() != ''}
            {$reference->getPublisherLoc()}:
        {elseif $reference->getPublisherLoc() != '' && $reference->getPublisherName() == ''}
            {$reference->getPublisherLoc()}
        {/if}
        {if $reference->getPublisherName() != '' && $reference->getYear() != ''}
            {$reference->getPublisherName()};
        {elseif $reference->getPublisherName() != '' && $reference->getYear() == ''}
            {$reference->getPublisherName()}
        {/if}
        {if $reference->getYear() != ''}
            {$reference->getYear()}
        {/if}
        .
</span>

{** writing URL, DOI, PMID, PMCID *}

{if $reference->getPubIdType() || $reference->getUrl() !== ''}
    {include file="frontend/parser/$cslStyle/links.tpl"}
{/if}

