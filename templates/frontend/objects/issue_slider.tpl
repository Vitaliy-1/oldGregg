{**
 * templates/frontend/objects/issue_slider.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *}

<div class="recent-issues-slider col-md-12">
    <h3>{translate key="plugins.gregg.issues.slider.title"}</h3>
</div>
<div id="carouselIndicators" class="carousel slide" data-ride="carousel">
    {capture name="forCarouselIndicators"}
        {foreach from=$latestIssues item=issue key=k}
            <li data-target="#carouselIndicators" data-slide-to="{$k}" {if $k == 0}class="active"{/if}></li>
        {/foreach}
    {/capture}
    {capture name="forCarouselImages"}
        {foreach from=$latestIssues item=issue key=k}
            <div class="carousel-item {if $k == 0}active{/if}">
                {if $issue->getLocalizedCoverImageUrl()}
                    <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
                        <img src="{$issue->getLocalizedCoverImageUrl()}" class="img-fluid">
                    </a>
                {else}
                    <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
                        <img src="{$defaultCoverImageUrl}" class="img-fluid">
                    </a>
                {/if}
                <div class="carousel-caption">
                    {if $issue->getLocalizedTitle()}
                        <h5>{$issue->getLocalizedTitle()}</h5>
                    {else}
                        <h5>{$displayPageHeaderTitle}</h5>
                    {/if}
                    <p>{$issue->getVolume()}
                        |
                        {$issue->getNumber()}</p>
                </div>
            </div>
        {/foreach}
    {/capture}
    <ol class="carousel-indicators">
        {$smarty.capture.forCarouselIndicators}
    </ol>
    <div class="carousel-inner">
        {$smarty.capture.forCarouselImages}
    </div>
    <a class="carousel-control-prev" href="#carouselIndicators" role="button"
       data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselIndicators" role="button"
       data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
{* end of carousel div*}