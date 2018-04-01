{**
 * templates/frontend/pages/announcements.tpl
 *
 * Copyright (c) 2014-2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief announcements wrapper
 *}
{include file="frontend/components/header.tpl" pageTitle="announcement.announcements"}

<div class="page page_announcements">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="announcement.announcements"}
    <div class="container">
        <div class="announcements-wrapper">
            {include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="announcements" sectionTitleKey="announcement.announcements"}

            {$announcementsIntroduction}
        </div>

        {include file="frontend/components/announcements.tpl"}
    </div>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}