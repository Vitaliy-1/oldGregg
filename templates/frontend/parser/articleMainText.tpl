{**
 * plugins/generic/jatsParser/templates/articleMainText.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A base template for displaying parsed article's JATS XML
 *}

{* intra-article navigation *}
<div class="col-lg-6" id="article-nav">
    <div id="nav-absolute-position">
        <nav class="article-menu nav nav-tabs" id="myTab" role="tablist">
            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-content" role="tab" aria-controls="nav-content" aria-selected="true">
                <i class="fas fa-list fa-lg"></i>
                Content
            </a>
            <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-references" role="tab" aria-controls="nav-references" aria-selected="false">
                <i class="fas fa-quote-left fa-lg"></i>
                References
            </a>
            <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Contact</a>
        </nav>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-content" role="tabpanel" aria-labelledby="nav-content-tab">
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
                    {*
                    {if $references->getTitle() != NULL}
                        <a class="intranav nav-link" href="#sec-ref">{$references->getTitle()}</a>
                    {/if}
                    *}
                </nav>
            </div>
            <div class="tab-pane fade" id="nav-references" role="tabpanel" aria-labelledby="nav-references-tab">

                {if $references->getTitle() != NULL}
                    <div class="panwrap item">
                        <div class = "section">
                        {*<h2 class="title references" id="sec-ref">{$references->getTitle()}</h2>*}
                    </div>

                    <div class="forpan">
                        <div class="panel-body">
                            <ol class="references">
                                {foreach from=$references->getReferences() item=reference}
                                    {if get_class($reference) == "BibitemJournal"}
                                        <li class="ref">
                                        <span class="bib" id="{$reference->getId()}">
                                            {include file="frontend/parser/vancouver/journal_article.tpl"}
                                        </span>
                                        </li>
                                    {/if}
                                    {if get_class($reference) == "BibitemBook"}
                                        <li class="ref">
                                        <span class="bib" id="{$reference->getId()}">
                                            {include file="frontend/parser/vancouver/book.tpl"}
                                        </span>
                                        </li>
                                    {/if}
                                    {if get_class($reference) == "BibitemChapter"}
                                        <li class="ref">
                                        <span class="bib" id="{$reference->getId()}">
                                            {include file="frontend/parser/vancouver/chapter.tpl"}
                                        </span>
                                        </li>
                                    {/if}
                                    {if get_class($reference) == "BibitemConf"}
                                        <li class="ref">
                                        <span class="bib" id="{$reference->getId()}">
                                            {include file="frontend/parser/vancouver/conference.tpl"}
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
            <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">...</div>
        </div>

        </nav>
    </div>
</div>

{* Article text *}

<div class="col-lg-6" id="full-article-block">
    <div id="article-absolute-position" data-spy="scroll" data-target="#navbar-article-links" data-offset="0">
        <div class="article-text">
            {** get abstract *}
            {if $article->getLocalizedAbstract()}
                {include file="frontend/parser/abstract.tpl"}
            {/if}
            {** get sections *}
        {foreach from=$sections item=sect key=i}
            <div class="panwrap item">
                <div class="section">
                    <h2 class="title" id="sec-{$i+1}">{$sect->getTitle()}</h2>
                </div>
                <div class="forpan">
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

    </div>
</div>

