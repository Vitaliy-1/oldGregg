{**
 * plugins/themes/oldGregg/templates/frontend/parser/section.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * for displaying content  of article sections
 *}

{strip}
{foreach from=$section->getContent() item=sectContent}
    {if get_class($sectContent) === "JATSParser\Body\Par"}
        <p>
            {foreach from=$sectContent->getContent() item=parContent}
                {if get_class($parContent) === "JATSParser\Body\Text"}
                    {include file="frontend/parser/text.tpl"}
                {/if}
            {/foreach}
        </p>
    {elseif get_class($sectContent) === "JATSParser\Body\Listing"}
        {include file="frontend/parser/list.tpl"}
    {elseif get_class($sectContent) === "JATSParser\Body\Table"}
        {include file="frontend/parser/table.tpl"}
    {elseif get_class($sectContent) === "JATSParser\Body\Figure"}
        {include file="frontend/parser/figure.tpl"}
    {/if}
{/foreach}
{/strip}


