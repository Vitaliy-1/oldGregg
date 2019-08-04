{**
 * templates/frontend/pages/contact.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

{extends "frontend/layouts/informational.tpl"}

{* passing variable *}
{assign var="pageTitle" value="about.contact"}

{block name="informationalContent"}
    {include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="contact" sectionTitleKey="about.contact"}

    {* Contact section *}
    <div class="contact_section">

        {if $mailingAddress}
            <div class="journal-address">
                {$mailingAddress|nl2br|strip_unsafe_html}
            </div>
        {/if}

        {* Primary contact *}
        {if $contactTitle || $contactName || $contactAffiliation || $contactPhone || $contactEmail}
            <div class="primary-contact">
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
        {if $supportName || $supportPhone || $supportEmail}
            <div class="secondary-contact">
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
    </div>
{/block}
