{**
 * templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}

<div class="page page_register">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.register"}
	<div class="register-page container">

		<form class="cmp_form register" id="register" method="post" action="{url op="register"}">
            {csrf}

            {if $source}
				<input type="hidden" name="source" value="{$source|escape}" />
            {/if}

            {include file="common/formErrors.tpl"}

            {include file="frontend/components/registrationForm.tpl"}

			{* initial code by PKP team, didn't changed it *}

            {* When a user is registering with a specific journal *}
            {if $currentContext}

	            <fieldset class="consent">
		            {* Require the user to agree to the terms of the privacy policy *}
		            <div class="fields">
			            <div class="optin optin-privacy">
				            <label>
					            <input type="checkbox" name="privacyConsent" value="1"{if $privacyConsent} checked="checked"{/if}>
					            {capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}
					            {translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
				            </label>
			            </div>
		            </div>
		            {* Ask the user to opt into public email notifications *}
		            <div class="fields">
			            <div class="optin optin-email">
				            <label>
					            <input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
					            {translate key="user.register.form.emailConsent"}
				            </label>
			            </div>
		            </div>
	            </fieldset>

                {* Users are opted into the Reader and Author roles in the current
                   journal/press by default. See RegistrationForm::initData() *}
                {assign var=contextId value=$currentContext->getId()}
                {foreach from=$readerUserGroups[$contextId] item=userGroup}
                    {if in_array($userGroup->getId(), $userGroupIds)}
                        {assign var="userGroupId" value=$userGroup->getId()}
						<input type="hidden" name="readerGroup[{$userGroupId}]" value="1">
                    {/if}
                {/foreach}
                {foreach from=$authorUserGroups[$contextId] item=userGroup}
                    {if in_array($userGroup->getId(), $userGroupIds)}
                        {assign var="userGroupId" value=$userGroup->getId()}
						<input type="hidden" name="authorGroup[{$userGroupId}]" value="1">
                    {/if}
                {/foreach}

                {* Allow the user to sign up as a reviewer *}
                {assign var=userCanRegisterReviewer value=0}
                {foreach from=$reviewerUserGroups[$contextId] item=userGroup}
                    {if $userGroup->getPermitSelfRegistration()}
                        {assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
                    {/if}
                {/foreach}
                {if $userCanRegisterReviewer}
					<fieldset class="reviewer">
						<legend>
                            {translate key="user.reviewerPrompt"}
						</legend>
						<div class="fields">
							<div id="reviewerOptinGroup" class="optin">
                                {foreach from=$reviewerUserGroups[$contextId] item=userGroup}
                                    {if $userGroup->getPermitSelfRegistration()}
										<label>
                                            {assign var="userGroupId" value=$userGroup->getId()}
											<input type="checkbox" name="reviewerGroup[{$userGroupId}]" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
                                            {translate key="user.reviewerPrompt.userGroup" userGroup=$userGroup->getLocalizedName()}
										</label>
                                    {/if}
                                {/foreach}
							</div>
						</div>
					</fieldset>
                {/if}
            {/if}

            {include file="frontend/components/registrationFormContexts.tpl"}


            {* recaptcha spam blocker *}
            {if $reCaptchaHtml}
				<fieldset class="recaptcha_wrapper">
					<div class="fields">
						<div class="recaptcha">
                            {$reCaptchaHtml}
						</div>
					</div>
				</fieldset>
            {/if}

			<div class="register-form-buttons btn-group" role="group">
				<button type="submit" class="submit btn btn-secondary">{translate key="user.register"}</button>
                {capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
				<a href="{url page="login" source=$rolesProfileUrl}" type="button" class="login btn btn-secondary">
					{translate key="user.login"}
				</a>
			</div>

		</form>
	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
