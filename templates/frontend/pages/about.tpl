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

{block name="pageContent"}
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col-md-9">
				{$currentContext->getLocalizedSetting('about')}
			</div>
		</div>
	</div>
{/block}

