{**
 * templates/frontend/pages/announcements.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the latest announcements
 *
 * @uses $announcements array List of announcements
 *}

{extends "frontend/layouts/informational.tpl"}

{* passing variable *}
{assign var="pageTitle" value="announcement.announcements"}

{block name="informationalContent"}
	<h1>
		{translate key="announcement.announcements"}
	</h1>
	{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="announcements" sectionTitleKey="announcement.announcements"}

	{$announcementsIntroduction|strip_unsafe_html}

	{include file="frontend/components/announcements.tpl"}
{/block}
