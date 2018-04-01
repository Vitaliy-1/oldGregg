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
<span class="ref-auth">
    {include file="frontend/parser/$cslStyle/authors.tpl"}
</span>

{** writing year, volume, issue, pages*}

{strip}
<span class="ref-source">
    {if $reference->getJournal() !== ''}
        {$reference->getJournal()}.
    {/if}
    {if $reference->getVolume() == '' && $reference->getIssue() == '' && $reference->getFpage() == '' && $reference->getLpage() == ''}
        {$reference->getYear()}
    {else}
        {$reference->getYear()};
    {/if}
    {$reference->getVolume()}
    {if $reference->getIssue() != ''}
        ({$reference->getIssue()})
    {/if}
    {if $reference->getFpage() != '' || $reference->getLpage() != ''}
        :
    {/if}
    {if $reference->getFpage() != '' && $reference->getLpage() != ''}
        {$reference->getFpage()}-{$reference->getLpage()}
    {elseif $reference->getFpage() != '' && $reference->getLpage() == ''}
        {$reference->getFpage()}
    {elseif $reference->getFpage() == '' && $reference->getLpage() != ''}
        {$reference->getLpage()}
    {/if}
    .
</span>
{/strip}

{** writing URL, DOI, PMID, PMCID *}

{if $reference->getPubIdType() || $reference->getUrl() !== ''}
    {include file="frontend/parser/$cslStyle/links.tpl"}
{/if}


