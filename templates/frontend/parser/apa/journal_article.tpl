{**
 * plugins/themes/oldGregg/templates/frontend/parser/apa/journal_article.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @brief template for writing journal article references
 *}

{** writing authors names or collab*}
<span class="ref-auth apa">
    {include file="frontend/parser/$cslStyle/authors.tpl"}
    {if $reference->getYear()}
        ({$reference->getYear()}).
    {/if}
</span>

{** writing article title *}
<span class="ref-title apa" style="display:inline; font-weight: normal;"> {$reference->getTitle()}.</span>

{** writing year, volume, issue, pages*}

{strip}
<span class="ref-source apa">
    {if $reference->getJournal() !== ''}
        <i>
        {$reference->getJournal()},&nbsp;
        </i>
    {/if}

    {if $reference->getVolume() !== ''}
        {$reference->getVolume()}
    {/if}

    {if $reference->getIssue() !== ''}
        ({$reference->getIssue()})
    {/if}

    {if $reference->getFpage() != ''}
        ,&nbsp;
    {else}
        .&nbsp;
    {/if}

    {if $reference->getFpage() != '' && $reference->getLpage() != ''}
        {$reference->getFpage()}-{$reference->getLpage()}.
    {elseif $reference->getFpage() != ''}
        {$reference->getFpage()}.
    {/if}
</span>
{/strip}

{** writing URL, DOI, PMID, PMCID *}

{if $reference->getPubIdType() !== ''|| $reference->getUrl() !== ''}
    {include file="frontend/parser/$cslStyle/links.tpl"}
{/if}


