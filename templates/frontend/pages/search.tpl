{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $dateTo Value of the date to search filter (published before).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}

{extends "frontend/layouts/general.tpl"}

{* passing variable *}
{assign var="pageTitle" value="common.search"}

{block name="pageContent"}
	<div class="box_primary bb-lightgrey">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-9">
					<h1>
						{translate key="common.search"}
					</h1>
				</div>
			</div>
		</div>
	</div>

	<div class="box_primary">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-9">
					{capture name="searchFormUrl"}{url op="search" escape=false}{/capture}
					{$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|parse_str:$formUrlParameters}
					<form class="cmp_form" method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}">
						{foreach from=$formUrlParameters key=paramKey item=paramValue}
							<input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}"/>
						{/foreach}

						<div class="form-group form-group-query">
							<label for="query">
								{translate key="common.searchQuery"}
							</label>
							<input type="text" class="form-control search__control" id="query" name="query" value="{$query|escape}">
						</div>
						<div class="form-group form-group-authors">
							<label for="authors">
								{translate key="search.author"}
							</label>
							<input type="text" class="form-control search__control" id="authors" name="authors" value="{$authors|escape}">
						</div>
						<div class="form-group form-group-date-from">
							<label for="dateFromYear">
								{translate key="search.dateFrom"}
							</label>
							<div class="form-control-date form-row">
								{html_select_date class="col form-control search__select" prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
							</div>
						</div>
						<div class="form-group form-group-date-to">
							<label for="dateToYear">
								{translate key="search.dateTo"}
							</label>
							<div class="form-control-date form-row">
								{html_select_date class="col form-control search__select" prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
							</div>
						</div>
						<div class="buttons">
							<button class="btn btn-primary" type="submit">{translate key="common.search"}</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="box_secondary">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-12">
					{call_hook name="Templates::Search::SearchResults::PreResults"}

					{* Results pagination *}
					{if !$results->wasEmpty()}
						<div class="pkp_screen_reader">
							{page_info iterator=$results}
							{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
						</div>
					{/if}

					{* Search results, finally! *}
					<div class="search_results">
						{iterate from=results item=result}
							{include file="frontend/objects/article_summary.tpl" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideGalleys=true}
						{/iterate}
					</div>

					{* No results found *}
					{if $results->wasEmpty()}
						{if $error}
							{include file="frontend/components/notification.tpl" type="error" message=$error|escape}
						{else}
							{include file="frontend/components/notification.tpl" type="notice" messageKey="search.noResults"}
						{/if}

					{* Results pagination *}
					{else}
						<div class="cmp_pagination">
							{page_info iterator=$results}
							{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
						</div>
					{/if}

					{* Search Syntax Instructions *}
					{block name=searchSyntaxInstructions}{/block}
				</div>
			</div>
		</div>
	</div>

{/block}
