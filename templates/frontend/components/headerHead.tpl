{**
 * templates/frontend/components/headerHead.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2000-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site header <head> tag and contents.
 *}
<head>
	<meta charset="{$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>
		{$pageTitleTranslated|strip_tags}
		{* Add the journal name to the end of page titles *}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}

    {* Open Graph metatags *}
    {if !$homepageImage && $currentContext->getLocalizedData('homepageImage')}
        {assign var='homepageImage' value=$currentContext->getLocalizedData('homepageImage')}
    {/if}

    {if $requestedPage === 'article' && $publication->getLocalizedData('coverImage')}
		<meta property="og:image" content="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}" />
    {elseif $currentContext && $homepageImage}
		<meta property="og:image" content="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" />
    {/if}
</head>
