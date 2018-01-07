{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{include file="frontend/components/headerHead.tpl"}
{if $requestedPage|escape == "article"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}">
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
    <nav class="user-nav">
        {load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
    </nav>

    {* user menu *}
    <nav class="site-navbar-wraper navbar navbar-expand-lg navbar-dark bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
        {* primary menu *}
        {if $currentContext}
            {* Primary navigation menu for current application *}
            <div class="navbar-nav-scroll ">
                    {load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
            </div>
        {/if}

        </div>
        <a class="journal-name navbar-brand" href="{$homeUrl}">{$displayPageHeaderTitle}</a>
    </nav>
    {if $requestedPage|escape != "article"}
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <form class="input-group" action="{url page="search" op="search"}" method="post" role="search">
                        <input type="text" value="{$searchQuery|escape}" class="search-input-tag form-control" placeholder="{translate key="plugins.gregg.search-text"}" aria-label="Search">
                        <span class="input-group-btn">
                            <button class="btn btn-secondary" type="submit">{translate key="plugins.gregg.search"}</button>
                        </span>
                    </form>
                </div>
            </div>
        </div>
    {/if}
</header>

{* wraper for the page content; end in the footer; we want full-width container on the article's full-text page *}
<div class="site-content container{if $requestedPage|escape == "article"}-fluid{/if}">