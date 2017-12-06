{**
 * plugins/generic/jatsParser/templates/articleMainText.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * Gives main structure of the article document
 *}

{* intra-article navigation *}
<div class="col-lg-3 col-sm-0" id="article-nav">
    <nav id="navbar-article" class="navbar navbar-light bg-white">
        <nav id="navbar-article-links" class="nav nav-pills flex-column">
            {if $article->getLocalizedAbstract()}
                <a class="intranav nav-link" href="#sec-0">{translate key="article.abstract"}</a>
            {/if}
            {foreach from=$sections item=sect key=sectionNumber}
                <a class="intranav nav-link" href="#sec-{$sectionNumber+1}">{$sect->getTitle()}</a>
                {if $sect->getHasSection() === TRUE}
                    <nav class="subnav nav nav-pills flex-column">
                        {foreach from=$sect->getContent() item=secCont key=subsectionNumber}
                            {if get_class($secCont) == "ArticleSection"}
                                <a class="intranav nav-link ml-3 my-1" href="#sec-{$sectionNumber+1}-{$subsectionNumber}">{$secCont->getTitle()}</a>
                            {/if}
                        {/foreach}
                    </nav>
                {/if}
            {/foreach}
            {if $references->getTitle() != NULL}
                <a class="intranav nav-link" href="#sec-ref">{$references->getTitle()}</a>
            {/if}
        </nav>
    </nav>
</div>

{* Article text *}

<div class="col-lg-6 col-sm-12">
    <div class="for-spy">

        <div class="article-text"{* adding by javascrip: id="accordion" data-children=".item" *}>
            {** get abstract *}
            {if $article->getLocalizedAbstract()}
                {include file="frontend/parser/abstract.tpl"}
            {/if}
            {** get sections *}
        {foreach from=$sections item=sect key=i}
            <div class="panwrap item">
                <div class="section" data-toggle="collapse" data-parent="#accordion" href="#accordion{$i+2}" aria-expanded="false" aria-controls="accordion{$i+2}" id="s{$i+2}">
                    <h2 class="title" id="sec-{$i+1}">{$sect->getTitle()}</h2>
                </div>
                <div class="forpan collapse" id="accordion{$i+2}" role="tabpanel">
                    <div class="panel-body">
                        {foreach from=$sect->getContent() item=secCont key=y}
                            {include file="frontend/parser/section.tpl"}
                            {if get_class($secCont) == "ArticleSection"}
                                <div class="subsection">
                                    <h3 class="subtitle" id="sec-{$i+1}-{$y}">{$secCont->getTitle()}</h3>
                                </div>
                                <div class="subforpan">
                                    <div class="subpanel-body">
                                        {foreach from=$secCont->getContent() item=secCont}
                                            {include file="frontend/parser/section.tpl"}
                                            {if get_class($secCont) == "ArticleSection"}
                                                <div class="subsubsection">
                                                    <h4 class="subsubtitle">{$secCont->getTitle()}</h4>
                                                </div>
                                                <div class="subsubforpan">
                                                    <div class="subsubpanel-body">
                                                        {foreach from=$secCont->getContent() item=secCont}
                                                            {include file="frontend/parser/section.tpl"}
                                                        {/foreach}
                                                    </div>
                                                </div>
                                            {/if}
                                        {/foreach}
                                    </div>
                                </div>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            </div>
        {/foreach}
            {** writing references *}
        {if $references->getTitle() != NULL}
        <div class="panwrap item">
            <div class = "section" data-toggle="collapse" data-parent="#accordion" href="#accordionref" aria-expanded="false" aria-controls="accordion{$i+2}" id="sref">
                <h2 class="title references" id="sec-ref">{$references->getTitle()}</h2>
            </div>
            <div class="forpan collapse" id="accordionref" role="tabpanel">
                <div class="panel-body">
                    <ol class="references">
                        {foreach from=$references->getReferences() item=reference}
                            {if get_class($reference) == "BibitemJournal"}
                                <li class="ref">
                                    <span class="bib" id="{$reference->getId()}">
                                        {include file="frontend/parser/vancouver/journal_article.tpl"}
                                        <button type="button" class="tocite btn btn-outline-info btn-sm" id="to-{$reference->getId()}">
                                            <span class="glyphicon glyphicon-circle-arrow-up" aria-hidden="true"></span> {translate key="jatsParser.references.link"}
                                        </button>
                                    </span>
                                </li>
                            {/if}
                            {if get_class($reference) == "BibitemBook"}
                                <li class="ref">
                                    <span class="bib" id="{$reference->getId()}">
                                        {include file="frontend/parser/vancouver/book.tpl"}
                                        <button type="button" class="tocite btn btn-outline-info btn-sm" id="to-{$reference->getId()}">
                                            <span class="glyphicon glyphicon-circle-arrow-up" aria-hidden="true"></span> {translate key="jatsParser.references.link"}
                                        </button>
                                    </span>
                                </li>
                            {/if}
                            {if get_class($reference) == "BibitemChapter"}
                                <li class="ref">
                                    <span class="bib" id="{$reference->getId()}">
                                        {include file="frontend/parser/vancouver/chapter.tpl"}
                                        <button type="button" class="tocite btn btn-outline-info btn-sm" id="to-{$reference->getId()}">
                                            <span class="glyphicon glyphicon-circle-arrow-up" aria-hidden="true"></span> {translate key="jatsParser.references.link"}
                                        </button>
                                    </span>
                                </li>
                            {/if}
                            {if get_class($reference) == "BibitemConf"}
                                <li class="ref">
                                    <span class="bib" id="{$reference->getId()}">
                                        {include file="frontend/parser/vancouver/conference.tpl"}
                                        <button type="button" class="tocite btn btn-outline-info btn-sm" id="to-{$reference->getId()}">
                                            <span class="glyphicon glyphicon-circle-arrow-up" aria-hidden="true"></span> {translate key="jatsParser.references.link"}
                                        </button>
                                    </span>
                                </li>
                            {/if}
                        {/foreach}
                    </ol>
                </div>
            </div>
        </div>
        {/if}
        </div>

    </div>
</div>

