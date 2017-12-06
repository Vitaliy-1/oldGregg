{**
 * plugins/generic/jatsParser/templates/section.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * for displaying lists; uses recursion for handling nested lists
 *}
{strip}
{if get_class($parCont) == "JatsList"}
    {if $parCont->getType() == "list-ordered"}
        <ol class="ordered-1">
            {foreach from=$parCont->getContent() item=jatsList}
                <li class="in-ordered">
                    <p class=""inlist>
                        {foreach from=$jatsList->getContent() item=parCont}
                            {include file="`$path_template`/paragraph.tpl"}
                            {include file="`$path_template`/list.tpl"}
                        {/foreach}
                    </p>
                </li>
            {/foreach}
        </ol>
    {elseif $parCont->getType() == "list-unordered"}
        <ul class="unordered-1">
            {foreach from=$parCont->getContent() item=jatsList}
                <li class="in-ordered">
                    <p class=""inlist>
                        {foreach from=$jatsList->getContent() item=parCont}
                            {include file="`$path_template`/paragraph.tpl"}
                            {include file="`$path_template`/list.tpl"}
                        {/foreach}
                    </p>
                </li>
            {/foreach}
        </ul>
    {/if}
{/if}
{/strip}