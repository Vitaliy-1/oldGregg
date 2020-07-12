{**
 * templates/frontend/pages/about.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

{extends "frontend/layouts/informational.tpl"}

{* passing variable *}
{assign var="pageTitle" value="about.aboutContext"}

{block name="informationalContent"}
	{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="{$pageTitle|escape}"}
	{$currentContext->getLocalizedSetting('about')}
{/block}
