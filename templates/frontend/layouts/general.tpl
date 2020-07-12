{**
 * templates/frontend/layouts/general.tpl
 *
 * Copyright (c) 2017-2019 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief Layout for a general page, includes header and footer
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{strip}
	{* Determine whether a logo or title string is being displayed *}
	{assign var="showingLogo" value=true}
	{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

<div class="cmp_skip_to_content">
	<a class="sr-only" href="#header">{translate key="navigation.skip.main"}</a>
	<a class="sr-only" href="#content">{translate key="navigation.skip.nav"}</a>
	<a class="sr-only" href="#footer">{translate key="navigation.skip.footer"}</a>
</div>

{capture assign="homeUrl"}
	{if $currentContext && $multipleContexts}
		{url page="index" router=$smarty.const.ROUTE_PAGE}
	{else}
		{url context="index" router=$smarty.const.ROUTE_PAGE}
	{/if}
{/capture}

{capture name="branding"}
	{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
		<a href="{$homeUrl|trim}" class="is_img">
			<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
		</a>
	{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
		<a href="{$homeUrl|trim}" class="is_text">{$displayPageHeaderTitle}</a>
	{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
		<a href="{$homeUrl|trim}" class="is_img">
			<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" alt="{$displayPageHeaderTitle.altText|escape}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" />
		</a>
	{else}
		<a href="{$homeUrl|trim}" class="is_img">
			<img src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}" title="{$applicationName|escape}" width="180" height="90" />
		</a>
	{/if}
{/capture}

<header class="container-fluid">
	<div class="row">
		{if $requestedOp == 'index'}
			<h1 class="journal_branding col-md-4">
				{$smarty.capture.branding}
			</h1>
		{else}
			<div class="journal_branding col-md-4">
				{$smarty.capture.branding}
			</div>
		{/if}

		<div class="navigation_wrapper col-md-8">
			{* User navigation *}
			<nav class="usernav navbar navbar-expand navbar-light" aria-label="{translate|escape key="common.navigation.user"}">
				{load_menu name="user" id="navigationUser" liClass="profile"}
			</nav>

			{* Primary site navigation *}
			{capture assign="primaryMenu"}
				{load_menu name="primary" id="navigationPrimary"}
			{/capture}

			{if !empty(trim($primaryMenu))}
				<nav class="primaryNav navbar navbar-expand-lg navbar-light" aria-label="{translate|escape key="common.navigation.site"}">
					{* Primary navigation menu for current application *}
					{$primaryMenu}
				</nav>
			{/if}
		</div>
	</div>
</header>

<main>
	{block name="pageContent"}{/block}
</main>

{block name="pageFooter"}
	<footer>
		<div class="container">
			{if $hasSidebar || $pageFooter}
				<div class="sidebar row{if $pageFooter} hasUserFooter{else} noUserFooter{/if}">

					{if $pageFooter}
						<div class="user_footer col-lg-6 col-md-12">
							{$pageFooter}
						</div>
					{/if}

					{call_hook name="Templates::Common::Sidebar"}
				</div>
			{/if}
			<div class="row">

			</div>
		</div>
	</footer>
{/block}

{load_script context="frontend" scripts=$scripts}
{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
