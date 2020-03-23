{**
 * templates/frontend/pages/announcements.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page which represents a single announcement
 *
 * @uses $announcement Announcement The announcement to display
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$announcement->getLocalizedTitle()|escape}

{extends "frontend/layouts/informational.tpl"}

{* passing variable *}
{assign var="pageTitleTranslated" value=$announcement->getLocalizedTitle()|escape}

{block name="informationalContent"}

	{* Display book details *}
	{include file="frontend/objects/announcement_full.tpl"}

{/block}
