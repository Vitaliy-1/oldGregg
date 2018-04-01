{**
 * plugins/themes/oldGregg/templates/frontend/parser/table.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @brief for writing article tables
 *}

<div class="responsive-wrapper">
    <table class="table"{if $sectContent->getId()} id="{$sectContent->getId()}{/if}">
        <caption>
            {if $sectContent->getLabel()}
                <p class="table-label">{$sectContent->getLabel()}. </p>
            {/if}
            {if $sectContent->getTitle()}
                <p class="table-title">
                    {foreach from=$sectContent->getTitle() item=titleText}
                        {$titleText->getContent()}
                    {/foreach}
                </p>
            {/if}
        </caption>

        {* Dealing with table head *}
        {capture name="insideTableHead"}
            {foreach from=$sectContent->getContent() item=row}
                {if $row->getType() === 1}
                    <tr>
                        {foreach from=$row->getContent() item=cell}
                            <th colspan="{$cell->getColspan()}" rowspan="{$cell->getRowspan()}">
                                {foreach from=$cell->getContent() item=parContent}
                                    {if get_class($parContent) === "JATSParser\Body\Par"}
                                        {foreach from=$parContent->getContent() item=parContent}
                                            {if get_class($parContent) === "JATSParser\Body\Text"}
                                                {include file="frontend/parser/text.tpl"}
                                            {/if}
                                        {/foreach}
                                    {elseif get_class($parContent) === "JATSParser\Body\Text"}
                                        {include file="frontend/parser/text.tpl"}
                                    {/if}
                                {/foreach}
                            </th>
                        {/foreach}
                    </tr>
                {/if}
            {/foreach}
        {/capture}


        <thead class="thead-light">
        {$smarty.capture.insideTableHead}
        </thead>

        {* Dealing with table body *}
        {capture name="insideTableBody"}
            {foreach from=$sectContent->getContent() item=row}
                {if ($row->getType() === 2)}
                    <tr>
                        {foreach from=$row->getContent() item=cell}
                            <td colspan="{$cell->getColspan()}" rowspan="{$cell->getRowspan()}">
                                {foreach from=$cell->getContent() item=parContent}
                                    {if get_class($parContent) === "JATSParser\Body\Par"}
                                        {foreach from=$parContent->getContent() item=parContent}
                                            {if get_class($parContent) === "JATSParser\Body\Text"}
                                                {include file="frontend/parser/text.tpl"}
                                            {/if}
                                        {/foreach}
                                    {elseif get_class($parContent) === "JATSParser\Body\Text"}
                                        {include file="frontend/parser/text.tpl"}
                                    {/if}
                                {/foreach}
                            </td>
                        {/foreach}
                    </tr>
                {/if}
            {/foreach}
        {/capture}

        <tbody class="thead-light">
        {$smarty.capture.insideTableBody}
        </tbody>

        {* Dealing with table body *}
        {capture name="simpleTable"}
            {foreach from=$sectContent->getContent() item=row}
                {if ($row->getType() === 3)}
                    <tr>
                        {foreach from=$row->getContent() item=cell}
                            <td colspan="{$cell->getColspan()}" rowspan="{$cell->getRowspan()}">
                                {foreach from=$cell->getContent() item=parContent}
                                    {if get_class($parContent) === "JATSParser\Body\Par"}
                                        {foreach from=$parContent->getContent() item=parContent}
                                            {if get_class($parContent) === "JATSParser\Body\Text"}
                                                {include file="frontend/parser/text.tpl"}
                                            {/if}
                                        {/foreach}
                                    {elseif get_class($parContent) === "JATSParser\Body\Text"}
                                        {include file="frontend/parser/text.tpl"}
                                    {/if}
                                {/foreach}
                            </td>
                        {/foreach}
                    </tr>
                {/if}
            {/foreach}
        {/capture}

        {$smarty.capture.simpleTable}

        {* Table notes *}
        {if $sectContent->getNotes()}
            <caption class="notes">
                {foreach from=$sectContent->getNotes() item=notes}
                    {foreach from=$notes->getContent() item=note}
                        <small>
                            {foreach from=$note->getContent() item=noteText}
                                {$noteText}
                            {/foreach}
                        </small>
                    {/foreach}
                {/foreach}
            </caption>
        {/if}

    </table>
</div>
