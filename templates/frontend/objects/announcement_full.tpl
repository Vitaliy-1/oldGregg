{**
 * templates/frontend/objects/announcement_full.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the full view of an announcement, when the announcement is
 *  the primary element on the page.
 *
 * @uses $announcement Announcement The announcement to display
 *}

<article class="obj_announcement_full container">
    <h1 class="announcement_title">
        {$announcement->getLocalizedTitle()}
    </h1>
    <div class="description card-text">
        {if $announcement->getLocalizedDescription()}
            {$announcement->getLocalizedDescription()|strip_unsafe_html}
        {else}
            {$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
        {/if}
    </div>
    <p class="card-text"><small class="text-muted">{$announcement->getDatePosted()|date_format:$dateFormatShort}</small></p>
</article>