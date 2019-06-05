{**
 * templates/frontend/pages/about.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

{extends "frontend/layouts/general.tpl"}

{* passing variable *}
{assign var="pageTitle" value="about.aboutContext"}

{block name="informationalTitle"}
	{translate key=$pageTitle|escape}
{/block}

{block name="informationalContent"}
	{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="about.aboutContext"}
	{$currentContext->getLocalizedSetting('about')}
{/block}

