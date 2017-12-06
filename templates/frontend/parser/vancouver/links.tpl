{**
 * plugins/generic/jatsParser/templates/vancouver/links.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * @brief for writing links in references (DOI, PMID and URL are supported)
 *}

<span class="ref-full">
    {if $reference->getDoi() != NULL}
        <a class="doi" href="{$reference->getDoi()}">CrossRef</a>
    {/if}
    {if $reference->getPmid() != NULL}
        <a class="pmid" href="{$reference->getPmid()}">PubMed</a>
    {/if}
    {if $reference->getUrl() != NULL}
        <a class="url" href="{$reference->getUrl()}">Publisher Full Text</a>
    {/if}
</span>