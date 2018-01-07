{**
 * templates/frontend/pages/contact.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="about.contact"}

<div class="page page_contact">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.contact"}

    {* Contact section *}
    <div class="contact_section container">
        {include file="frontend/components/editLink.tpl" page="management" op="settings" path="press" anchor="contact" sectionTitleKey="about.contact"}

        {if $mailingAddress}
            <div class="address">
                {$mailingAddress|nl2br|strip_unsafe_html}
            </div>
        {/if}

        {* Primary contact *}
        {if $contactTitle || $contactName || $contactAffiliation || $contactPhone || $contactEmail}
            <div class="contact primary">
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
            <div class="contact support">
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

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
