{**
 * plugins/generic/usageStats/templates/outputFrontend.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko, MD
 * Distributed under the GNU GPL v3.
 *}

<div class="item downloads_chart">
    <h3 class="label">
        {translate key="plugins.generic.usageStats.downloads"}
    </h3>
    <div class="value">
        <canvas class="usageStatsGraph" data-object-type="{$pubObjectType}" data-object-id="{$pubObjectId|escape}"></canvas>
        <div class="usageStatsUnavailable" data-object-type="{$pubObjectType}" data-object-id="{$pubObjectId|escape}">
            {translate key="plugins.generic.usageStats.noStats"}
        </div>
    </div>
</div>