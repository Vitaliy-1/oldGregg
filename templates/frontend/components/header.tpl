{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 *}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{include file="frontend/components/headerHead.tpl"}
{if $requestedPage|escape == "article"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}" data-spy="scroll" data-target="#navbar-article" data-offset="0">
{else}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}">
{/if}

{* Primary site navigation *}
{if $currentContext && $multipleContexts}
    {url|assign:"homeUrl" journal="index" router=$smarty.const.ROUTE_PAGE}
{else}
    {url|assign:"homeUrl" page="index" router=$smarty.const.ROUTE_PAGE}
{/if}
<header class="site-header">
    {* site brand *}
    {capture name="logotext"}
        {if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
            <a href="{$homeUrl}" class="is_img">
                <img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
            </a>
        {elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
            <a href="{$homeUrl}" class="is_text">{$displayPageHeaderTitle}</a>
        {elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
            <a href="{$homeUrl}" class="is_img">
                <img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" alt="{$displayPageHeaderTitle.altText|escape}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" />
            </a>
        {/if}
    {/capture}
    <div class="site-title-wraper">
        {if $requestedOp == 'index'}
            <h1 class="site-name">
                {$smarty.capture.logotext}
            </h1>
        {else}
            <div class="site-name">
                {$smarty.capture.logotext}
            </div>
        {/if}
    </div>

    {* user menu *}
    <nav class="site-navbar-wraper navbar navbar-expand-lg navbar-light bg-white">

        {* primary menu *}
        {if $currentContext}
                    {* Primary navigation menu for current application *}
            <div class="navbar-nav-scroll">
                    {load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
            </div>

        {/if}
        {load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
    </nav>
</header>
