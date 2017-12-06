{**
 * plugins/generic/jatsParser/templates/abstract.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * article abstract
 *}

<div class="panwrap abstract">
    <div class="section-abstract" {* data-toggle="collapse" data-parent="#accordion" href="#accordion1" aria-expanded="true" aria-controls="accordion1" id="s1" *}>
        <h2 class="title title-abstract" id="sec-0">
            {translate key="article.abstract"}
        </h2>
    </div>
    <div class="forpan{*collapse show id="accordion1" role="tabpanel'*}">
        <div class="panel-body">
            {$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}
        </div>
    </div>
</div>