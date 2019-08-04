{**
 * templates/frontend/pages/editorialTeam.tpl
 *
 * Copyright (c) 2018-2019 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *}

{extends "frontend/layouts/informational.tpl"}

{* passing variable *}
{assign var="pageTitle" value="about.editorialTeam"}

{block name="informationalContent"}
    {include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="about.editorialTeam"}
    {$currentContext->getLocalizedSetting('editorialTeam')}
{/block}
