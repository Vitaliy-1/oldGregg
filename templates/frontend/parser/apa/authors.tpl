{**
 * plugins/themes/oldGregg/templates/frontend/parser/apa/names.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @brief for writing names of authors or collab group
 *}


{foreach from=$reference->getAuthors() key=i item=name}
    {if get_class($name) == "JATSParser\Back\Collaboration"}
        {assign var=collabName value=$name->getName()}
        {if $collabName != NULL && $i+1 < $reference->getAuthors()|@count}
            {$collabName},
        {elseif $collabName != NULL && $i+1 == $reference->getAuthors()|@count}
            {$collabName}.
        {/if}
    {elseif get_class($name) == "JATSParser\Back\Individual"}
        {assign var=surName value=$name->getSurname()}
        {if $surName != NULL}
            {$surName},
        {/if}

        {assign var=givenNames value=$name->getGivenNames()}
        {if $givenNames != NULL && $i+2 < $reference->getAuthors()|@count}
            {$givenNames},
        {elseif $givenNames != NULL && $i+2 == $reference->getAuthors()|@count}
            {$givenNames} &
        {elseif $givenNames != NULL && $i+1 == $reference->getAuthors()|@count}
            {$givenNames}
        {/if}
    {/if}
{/foreach}
