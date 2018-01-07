{**
 * templates/frontend/pages/about.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="about.aboutContext"}

<div class="page page_about">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.aboutContext"}
	<div class="about-journal container">
		{$currentContext->getLocalizedSetting('about')}
	</div>
</div>

{include file="frontend/components/footer.tpl"}
