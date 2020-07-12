{**
 * plugins/generic/htmlArticleGalley/display.tpl
 *
 * Copyright (c) 2017-2020 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * Embedded viewing of a HTML galley.
 *}

{extends "frontend/layouts/general.tpl"}

{assign var="pageTitleTranslated" value=$article->getLocalizedTitle()|escape}

{block name="pageContent"}
    {capture assign="articleUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}

	<div id="htmlContainer" class="galley_view{if !$isLatestPublication} galley_view_with_notice{/if}" style="overflow:visible;-webkit-overflow-scrolling:touch">
        {if !$isLatestPublication}
			<div class="galley_view_notice">
				<div class="galley_view_notice_message" role="alert">
                    {translate key="submission.outdatedVersion" datePublished=$galleyPublication->getData('datePublished')|date_format:$dateFormatLong urlRecentVersion=$articleUrl}
				</div>
			</div>
            {capture assign="htmlUrl"}
                {url page="article" op="download" path=$article->getBestId()|to_array:'version':$galleyPublication->getId():$galley->getBestGalleyId() inline=true}
            {/capture}
        {else}
            {capture assign="htmlUrl"}
                {url page="article" op="download" path=$article->getBestId()|to_array:$galley->getBestGalleyId() inline=true}
            {/capture}
        {/if}
		<iframe name="htmlFrame" id="htmlFrame" src="{$htmlUrl}" title="{translate key="submission.representationOfTitle" representation=$galley->getLabel() title=$galleyPublication->getLocalizedFullTitle()|escape}" allowfullscreen webkitallowfullscreen></iframe>
	</div>
    {call_hook name="Templates::Common::Footer::PageFooter"}
{/block}

{block name="pageFooter"}{/block}

