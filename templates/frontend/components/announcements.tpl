{**
 * templates/frontend/components/announcements.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 *
 * @brief Announcements' list
 *}
{if !$heading}
    {assign var="heading" value="h2"}
{/if}

{foreach from=$announcements item=announcement}
    <div class="card">
        <{$heading} class="announcement-title card-header">
            <a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
                {$announcement->getLocalizedTitle()|escape}
            </a>
        </{$heading}>
        <div class="card-body">
            <div class="summary">
                {$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
                <a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}" class="btn btn-secondary">
                    <span aria-hidden="true" role="presentation">
                        {translate key="common.readMore"}
                    </span>
                </a>
            </div>
        </div>
        <div class="card-footer text-muted">
            {$announcement->getDatePosted()|date_format:$dateFormatShort}
        </div>
    </div>
{/foreach}