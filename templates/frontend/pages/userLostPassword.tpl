{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2000-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Password reset form.
 *
 *}

{extends "frontend/layouts/informational.tpl"}

{* passing variable *}
{assign var="pageTitle" value="user.login.resetPassword"}

{block name="informationalContent"}
	<h1>
		{translate key="user.login.resetPassword"}
	</h1>

	<p>{translate key="user.login.resetPasswordInstructions"}</p>

	<form class="cmp_form lost_password" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post">
		{csrf}
		{if $error}
			<div class="pkp_form_error">
				{translate key=$error}
			</div>
		{/if}

		<fieldset class="fields">
			<div class="form-group">
				<label for="email">{translate key="user.login.registeredEmail"}</label>
				<input type="text" class="form-control" name="email" id="email" value="{$email|escape}" required>
			</div>
			<div class="buttons">
				<button class="btn btn-primary submit" type="submit">
					{translate key="user.login.resetPassword"}
				</button>

				{if !$disableUserReg}
					{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
					<a href="{$registerUrl}" class="register btn btn-secondary">
						{translate key="user.login.registerNewAccount"}
					</a>
				{/if}
			</div>
		</fieldset>

	</form>

{/block}
