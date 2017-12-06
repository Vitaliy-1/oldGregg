{**
 * plugins/generic/jatsParser/templates/vancouver/names.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * @brief for writing names of authors or collab group
 *}

<span class="ref-auth">{foreach from=$reference->getName() key=i item=name}{$name->getSurname()} {strip}
    {foreach from=$name->getInitials() key=j item=initial}
        {if $initial != NULL && $j+1 < $name->getInitials()|@count}
            {$initial}
        {elseif $initial != NULL && $i+1 < $reference->getName()|count}
            {$initial},
        {elseif $initial != NULL && $i+1 == $reference->getName()|count}
            {$initial}.
        {/if}
    {/foreach}
    {if $name->getGivenname() != NULL && $i+1 < $reference->getName()|count}
        {$name->getGivenname()},
    {elseif $name->getGivenname() != NULL && $i+1 == $reference->getName()|count}
        {$name->getGivenname()}.
    {/if}
{/strip} {/foreach}{strip}
    {if $reference->getCollab() != NULL}
        {$reference->getCollab()}.
    {/if}
{/strip}
</span>