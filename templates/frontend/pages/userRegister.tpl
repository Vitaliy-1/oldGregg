{extends "frontend/layouts/general.tpl"}

{assign var=pageTitle value="user.register"}

{block name="pageContent"}

	<div class="box_primary bb-lightgrey">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-9">
					<h1>
						{translate key="user.register"}
					</h1>
				</div>
			</div>
		</div>
	</div>

	<form class="cmp_form register" id="register" method="post" action="{url op="register"}">
		{csrf}

		{if $source}
			<input type="hidden" name="source" value="{$source|escape}" />
		{/if}

		{include file="common/formErrors.tpl"}

		{include file="frontend/components/registrationForm.tpl"}

		{* When a user is registering with a specific journal *}
		{if $currentContext}

			<div class="box_primary">
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-md-9">
							<fieldset class="consent">
								{if $currentContext->getData('privacyStatement')}
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
								{/if}
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

							{* Allow the user to sign up as a reviewer *}
							{assign var=contextId value=$currentContext->getId()}
							{assign var=userCanRegisterReviewer value=0}
							{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
								{if $userGroup->getPermitSelfRegistration()}
									{assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
								{/if}
							{/foreach}
							{if $userCanRegisterReviewer}
								<fieldset class="reviewer">
									{if $userCanRegisterReviewer > 1}
										<legend>
											{translate key="user.reviewerPrompt"}
										</legend>
										{capture assign="checkboxLocaleKey"}user.reviewerPrompt.userGroup{/capture}
									{else}
										{capture assign="checkboxLocaleKey"}user.reviewerPrompt.optin{/capture}
									{/if}
									<div class="fields">
										<div id="reviewerOptinGroup" class="optin">
											{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
												{if $userGroup->getPermitSelfRegistration()}
													<label>
														{assign var="userGroupId" value=$userGroup->getId()}
														<input type="checkbox" name="reviewerGroup[{$userGroupId}]" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
														{translate key=$checkboxLocaleKey userGroup=$userGroup->getLocalizedName()}
													</label>
												{/if}
											{/foreach}
										</div>

										{**
										<div id="reviewerInterests" class="reviewer_interests">
											<div class="label">
												{translate key="user.interests"}
											</div>
											<ul class="interests tag-it" data-field-name="interests[]" data-autocomplete-url="{url|escape router=$smarty.const.ROUTE_PAGE page='user' op='getInterests'}">
												{foreach from=$interests item=interest}
													<li>{$interest|escape}</li>
												{/foreach}
											</ul>
										</div>
										*}
									</div>
								</fieldset>
							{/if}
						</div>
					</div>
				</div>
			</div>
		{/if}

		{include file="frontend/components/registrationFormContexts.tpl"}

		{* When a user is registering for no specific journal, allow them to
		   enter their reviewer interests *}
		{if !$currentContext}
		<div class="box_primary">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-md-9">
						<fieldset class="reviewer_nocontext_interests">
							<legend>
								{translate key="user.register.noContextReviewerInterests"}
							</legend>
							<div class="fields">
								<div class="reviewer_nocontext_interests">
									{* See comment for .tag-it above *}
									<ul class="interests tag-it" data-field-name="interests[]" data-autocomplete-url="{url|escape router=$smarty.const.ROUTE_PAGE page='user' op='getInterests'}">
										{foreach from=$interests item=interest}
											<li>{$interest|escape}</li>
										{/foreach}
									</ul>
								</div>
							</div>
						</fieldset>

						{* Require the user to agree to the terms of the privacy policy *}
						{if $siteWidePrivacyStatement}
							<div class="fields">
								<div class="optin optin-privacy">
									<label>
										<input type="checkbox" name="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]" id="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]" value="1"{if $privacyConsent[$smarty.const.CONTEXT_ID_NONE]} checked="checked"{/if}>
										{capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}
										{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
									</label>
								</div>
							</div>
						{/if}

						{* Ask the user to opt into public email notifications *}
						<div class="fields">
							<div class="optin optin-email">
								<label>
									<input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
									{translate key="user.register.form.emailConsent"}
								</label>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		{/if}

		{* recaptcha spam blocker *}
		<div class="box_secondary">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-md-9">
						{if $reCaptchaHtml}
							<fieldset class="recaptcha_wrapper">
								<div class="fields">
									<div class="recaptcha">
										{$reCaptchaHtml}
									</div>
								</div>
							</fieldset>
						{/if}

						<div class="buttons">
							<button class="submit btn btn-primary" type="submit">
								{translate key="user.register"}
							</button>

							{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
							<a href="{url page="login" source=$rolesProfileUrl}" class="login btn btn-secondary">{translate key="user.login"}</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

{/block}
