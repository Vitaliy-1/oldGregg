{**
 * plugins/generic/jatsParser/templates/paragraph.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * for writing article paragraphs
 *}

{strip}
{if get_class($parCont) == "ParText"}
    {$parCont->getContent()}
{elseif get_class($parCont) == "Xref"}
    {foreach from=$references->getReferences() item=reference}
        {if $reference->getId() == $parCont->getRid()}
            {* get data from journal articles *}
            {if get_class($reference) == "BibitemJournal" && $reference->getTitle() != null}
                {assign var="refTitle" value=$reference->getTitle()}
            {elseif get_class($reference) == "BibitemBook" && $reference->getSource() != null}
                {assign var="refTitle" value=$reference->getSource()}
            {elseif get_class($reference) == "BibitemChapter" && $reference->getChapterTitle() != null}
                {assign var="refTitle" value=$reference->getChapterTitle()}
            {elseif get_class($reference) == "BibitemConf" && $reference->getSource() != null}
                {assign var="refTitle" value=$reference->getSource()}
            {/if}
        {/if}
    {/foreach}
    <a class="intext-citation" tabindex="0" data-trigger="focus" data-toggle="popover" title="{$refTitle}" rid="{$parCont->getRid()}">
        {$parCont->getContent()}
    </a>

{elseif get_class($parCont) == "XrefFig"}
    <a class="reffigure" href="#{$parCont->getRid()}">
        {$parCont->getContent()}
    </a>
{elseif get_class($parCont) == "XrefTable"}
    <a class="reftable" href="#{$parCont->getRid()}">
        {$parCont->getContent()}
    </a>
{elseif get_class($parCont) == "XrefVideo"}
    <a class="refvideo" href="#{$parCont->getRid()}">
        {$parCont->getContent()}
    </a>
{elseif get_class($parCont) == "Italic"}
    <i>
        {foreach from=$parCont->getContent() item=parCont}
            {include file="frontend/parser/paragraph.tpl"}
        {/foreach}
    </i>
{elseif get_class($parCont) == "Bold"}
    <b>
        {foreach from=$parCont->getContent() item=parCont}
            {include file="frontend/parser/paragraph.tpl"}
        {/foreach}
    </b>
{elseif get_class($parCont) == "Sup"}
    <sup>{$parCont->getContent()}</sup>
{elseif get_class($parCont) == "Sub"}
    <sub>{$parCont->getContent()}</sub>
{elseif get_class($parCont) == "ParContent"}
    <p class="par-inside-table">
        {foreach from=$parCont->getContent() item=parCont}
                {include file="frontend/parser/paragraph.tpl"}
        {/foreach}
    </p>
{/if}
{/strip}