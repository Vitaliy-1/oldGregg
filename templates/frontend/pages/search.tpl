{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}

<div class="page page_search">

    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="common.search"}
    <div class="container">
        <form class="cmp_form" method="post" action="{url op="search"}">
            {csrf}

            <div class="search_input">
                <label class="pkp_screen_reader" for="query">
                    {translate key="search.searchFor"}
                </label>
                <input type="text" id="query" name="query" value="{$query|escape}" class="query" placeholder="{translate|escape key="common.search"}">
            </div>

            <fieldset class="search_advanced">
                <legend>
                    {translate key="search.advancedFilters"}
                </legend>
                <div class="date_range">
                    <div class="from">
                        <label class="label">
                            {translate key="search.dateFrom"}
                        </label>
                        {html_select_date prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
                    </div>
                    <div class="to">
                        <label class="label">
                            {translate key="search.dateTo"}
                        </label>
                        {html_select_date prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
                    </div>
                </div>
                <div class="author">
                    <label class="label" for="authors">
                        {translate key="search.author"}
                    </label>
                    <input type="text" for="authors" name="authors" value="{$authors|escape}">
                </div>
            </fieldset>

            <div class="submit">
                <button class="submit" type="submit">{translate key="common.search"}</button>
            </div>
        </form>

        {* Search results, finally! *}
        <div class="search_results">
            {iterate from=results item=result}
                {include file="frontend/objects/article_summary.tpl" article=$result.publishedArticle journal=$result.journal showDatePublished=true hideGalleys=true}
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
    </div><!-- .container -->
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
