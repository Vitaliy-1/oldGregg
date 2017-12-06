{**
 * plugins/generic/jatsParser/templates/vancouver/chapter.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * @brief template for parsing book chapter references
 *}

{** writing book title *}
<span class="ref-title">{$reference->getChapterTitle()}</span>

{** writing authors names or collab*}
{include file="frontend/parser/vancouver/names.tpl"}

{** writing book editors, title, publisher name, year etc. *}
<span class="ref-source">
    {if $reference->getEditor() != NULL}
        In: {foreach from=$reference->getEditor() key=i item=name}
                {$name->getSurname()}
                {foreach from=$name->getInitials() key=j item=initial}
                    {if $initial != NULL && $j+1 < $name->getInitials()|@count}
                        {$initial}
                    {elseif $initial != NULL && $i+1 < $reference->getEditor()|count}
                        {$initial},
                    {elseif $initial != NULL && $i+1 == $reference->getEditor()|count}
                        {$initial},
                    {/if}
                {/foreach}
            {if $name->getGivenname() != NULL && $i+1 < $reference->getEditor()|count}
                {$name->getGivenname()},
            {elseif $name->getGivenname() != NULL && $i+1 == $reference->getEditor()|count}
                {$name->getGivenname()},
            {/if}
        {/foreach}
        {if $reference->getEditor()|@count == 1}
            ed.
        {else}
            eds.
        {/if}
        {if $reference->getCollabEditor() != NULL}
            {$reference->getCollabEditor()}.
        {/if}
    {/if}
        {if $reference->getSource() != NULL}
            {$reference->getSource()}.
        {/if}
        {if $reference->getPublisherLoc() != NULL && $reference->getPublisherName() != NULL}
            {$reference->getPublisherLoc()}:
        {elseif $reference->getPublisherLoc() != NULL && $reference->getPublisherName() == NULL}
            {$reference->getPublisherLoc()}
        {/if}
        {if $reference->getPublisherName() != NULL && $reference->getYear() != NULL}
            {$reference->getPublisherName()};
        {elseif $reference->getPublisherName() != NULL && $reference->getYear() == NULL}
            {$reference->getPublisherName()}
        {/if}
        {if $reference->getYear() != NULL}
            {$reference->getYear()}
        {/if}
        .
</span>