{**
 * frontend/pages/navigationMenuItemViewContent.tpl
 *
 * Copyright (c) 2017-2020 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * Display NavigationMenuItem content
 *}

{extends "frontend/layouts/informational.tpl"}

{* passing variable *}
{assign var="pageTitleTranslated" value=$title}
{block name="informationalContent"}
    <h1 class="mb-4">{$title|escape}</h1>
    {$content}
{/block}

{include file="frontend/components/footer.tpl"}
