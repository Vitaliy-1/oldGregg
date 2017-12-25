{**
 * templates/frontend/pages/error.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *}
{include file="frontend/components/header.tpl"}

<div class="page page_error">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}
	<div class="container">
		<div class="description alert alert-danger" role="alert">
            {translate key=$errorMsg params=$errorParams}
		{if $backLink}
			<div class="cmp_back_link">
				<a href="{$backLink}">{translate key=$backLinkLabel}</a>
			</div>
		{/if}
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
