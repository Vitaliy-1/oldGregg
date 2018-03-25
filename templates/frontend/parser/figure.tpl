{**
 * plugins/themes/oldGregg/templates/frontend/parser/figure.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @brief for writing article figures
 *}

<div class="responsive-wrapper">
    <figure class="figure"{if $sectContent->getId()} id="{$sectContent->getId()}{/if}">
        <figcaption>
            {if $sectContent->getLabel()}
                <p class="figure-label">{$sectContent->getLabel()}. </p>
            {/if}
            {if $sectContent->getTitle()}
                <p class="figure-title">
                    {foreach from=$sectContent->getTitle() item=titleText}
                        {$titleText->getContent()}
                    {/foreach}
                </p>
            {/if}
        </figcaption>

        {** check if link is from galley attachments*}
        {if strpos($sectContent->getLink(), "/") == false}
            {foreach from=$imageUrlArray key=fileName item=urlLink}
                {if $fileName == $sectContent->getLink()}
                    <img src="{$urlLink}" class="figure-img img-fluid rounded">
                {/if}
            {/foreach}
        {else}
            <img src="{$sectContent->getLink()}" class="figure-img img-fluid rounded">
        {/if}

        {if $sectContent->getContent()}
            <figcaption class="notes">
                {foreach from=$sectContent->getContent() item=notes}
                    {foreach from=$notes->getContent() item=note}
                        <small>
                            {foreach from=$note->getContent() item=noteText}
                                {$noteText}
                            {/foreach}
                        </small>
                    {/foreach}
                {/foreach}
            </figcaption>
        {/if}
    </figure>
</div>