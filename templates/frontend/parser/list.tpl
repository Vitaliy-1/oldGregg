{**
 * plugins/themes/oldGregg/templates/frontend/parser/list.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * for displaying lists; uses recursion for handling nested lists
 *}

{if get_class($parContent) === "JATSParser\Body\Listing"}
    {assign var=listing value=$parContent}
{else}
    {assign var=listing value=$sectContent}
{/if}

{strip}
    {if $listing->getStyle() === "ordered"}
        <ol>
    {elseif $listing->getStyle() === "unordered"}
        <ul>
    {/if}
    {foreach from=$listing->getContent() item=listItem}
        <li>
            {foreach from=$listItem item=parContent}
                {if get_class($parContent) === "JATSParser\Body\Text"}
                    {include file="frontend/parser/text.tpl"}
                {elseif get_class($parContent) === "JATSParser\Body\Par"}
                    {foreach from=$parContent->getContent() item=parContent}
                        {if get_class($parContent) === "JATSParser\Body\Text"}
                            {include file="frontend/parser/text.tpl"}
                        {/if}
                    {/foreach}
                {elseif get_class($parContent) === "JATSParser\Body\Listing"}
                    {include file="frontend/parser/list.tpl"}
                {/if}
            {/foreach}
        </li>
    {/foreach}

    {if $listing->getStyle() === "ordered"}
        </ol>
    {elseif $listing->getStyle() === "unordered"}
        </ul>
    {/if}
{/strip}