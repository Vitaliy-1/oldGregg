{**
 * templates/frontend/pages/contact.tpl
 *
 * Copyright (c) 2018-2020 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

{extends "frontend/layouts/general.tpl"}

{* passing variable *}
{assign var="pageTitle" value="about.contact"}

{block name="pageContent"}
    {if $contactTitle || $contactName || $contactAffiliation || $contactPhone || $contactEmail}
        {assign var="isPrimaryContact" value=true}
    {else}
        {assign var="isPrimaryContact" value=false}
    {/if}

    {if $supportName || $supportPhone || $supportEmail}
        {assign var="isTechnicalContact" value=true}
    {else}
        {assign var="isTechnicalContact" value=false}
    {/if}

    <div class="box_edit">
        {include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="contact" sectionTitleKey="about.contact"}
    </div>


    {if $mailingAddress}
        <div class="box_primary">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-9">
                        <div class="journal-address">
                            {$mailingAddress|nl2br|strip_unsafe_html}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/if}

    {* Primary contact *}
    {if $isPrimaryContact || $isTechnicalContact}
        <div class="container">
            <div class="row justify-content-md-around">

                {if $isPrimaryContact}
                    <div class="primary-contact col-md-4">
                        <h3>
                            {translate key="about.contact.principalContact"}
                        </h3>

                        {if $contactName}
                            <div class="name">
                                {$contactName|escape}
                            </div>
                        {/if}

                        {if $contactTitle}
                            <div class="title">
                                {$contactTitle|escape}
                            </div>
                        {/if}

                        {if $contactAffiliation}
                            <div class="affiliation">
                                {$contactAffiliation|strip_unsafe_html}
                            </div>
                        {/if}

                        {if $contactPhone}
                            <div class="phone">
                            <span class="label">
                                {translate key="about.contact.phone"}
                            </span>
                                <span class="value">
                                {$contactPhone|escape}
                            </span>
                            </div>
                        {/if}

                        {if $contactEmail}
                            <div class="email">
                                <a href="mailto:{$contactEmail|escape}">
                                    {$contactEmail|escape}
                                </a>
                            </div>
                        {/if}
                    </div>
                {/if}

                {* Technical contact *}
                {if $isTechnicalContact}
                    <div class="secondary-contact col-md-4">
                        <h3>
                            {translate key="about.contact.supportContact"}
                        </h3>

                        {if $supportName}
                            <div class="name">
                                {$supportName|escape}
                            </div>
                        {/if}

                        {if $supportPhone}
                            <div class="phone">
                            <span class="label">
                                {translate key="about.contact.phone"}
                            </span>
                                <span class="value">
                                {$supportPhone|escape}
                            </span>
                            </div>
                        {/if}

                        {if $supportEmail}
                            <div class="email">
                                <a href="mailto:{$supportEmail|escape}">
                                    {$supportEmail|escape}
                                </a>
                            </div>
                        {/if}
                    </div>
                {/if}

            </div><!-- row -->
        </div><!-- container -->
    {/if}
{/block}
