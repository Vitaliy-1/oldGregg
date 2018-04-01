{**
 * plugins/themes/oldGregg/templates/frontend/parser/vancouver/links.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @brief for writing links in references (DOI, PMID and URL are supported)
 *}

<span class="ref-full">
    {if $reference->getUrl() !== ''}
        <a class="url" href="{$reference->getUrl()}">Publisher Full Text</a>
    {/if}
    {assign var=pubId value=$reference->getPubIdType()}
    {if $pubId}
        {foreach from=$pubId key=pubType item=pubIdValue}
            {if $pubType === 'doi'}
                <a class="{$pubType}" href="{$pubIdValue}">CrossRef</a>
            {elseif $pubType === 'pmid'}
                <a class="{$pubType}" href="{$pubIdValue}">PubMed</a>
            {elseif $pubType === 'pmcid'}
                <a class="{$pubType}" href="{$pubIdValue}">PMC</a>
            {/if}
        {/foreach}
    {/if}
</span>