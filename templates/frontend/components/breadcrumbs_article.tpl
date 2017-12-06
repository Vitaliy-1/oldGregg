{**
 * templates/frontend/components/breadcrumbs_article.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko, MD
 *}
<nav class="bread-nav" aria-label="breadcrumb" role="navigation">
	<ol class="breadcrumb">
		<li class="breadcrumb-item" aria-current="page">
			<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>
			<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}">
				{translate key="common.homepageNavigationLabel"}
			</a>
		</li>
		<li class="breadcrumb-item" aria-current="page">
			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
				{translate key="navigation.archives"}
			</a>
		</li>
		<li class="breadcrumb-item" aria-current="page">
			<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
				{$issue->getIssueIdentification()}
			</a>
		</li>
		<li class="breadcrumb-item active" aria-current="page">
				{if $currentTitleKey}
					{translate key=$currentTitleKey}
				{else}
					{$currentTitle|escape}
				{/if}
		</li>
	</ol>
</nav>
