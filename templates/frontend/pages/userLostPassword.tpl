{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<div class="page page_lost_password">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login.resetPassword"}
	<div class="container">
        <div class="alert alert-info" role="alert">
            {translate key="user.login.resetPasswordInstructions"}
        </div>

        <form class="cmp_form lost_password" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post">
            {csrf}
            {if $error}
                <div class="pkp_form_error alert alert-warning alert-dismissible fade show" role="alert">
                    {translate key=$error}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            {/if}
            <div class="form-group">
                <label for="email">{translate key="plugins.themes.PMGPTheme.email"}</label>
                <input name="email" type="email" class="form-control" id="email" aria-describedby="emailHelp" value="{$email|escape}" maxlength="32" required placeholder="{translate key="plugins.themes.PMGPTheme.enter-email"}">
            </div>
            {if !$disableUserReg}
                <div class="btn-group" role="group">
                    <button class="btn btn-secondary" type="submit">
                        {translate key="user.login.resetPassword"}
                    </button>
                    {url|assign:registerUrl page="user" op="register" source=$source}
                    <a class="btn btn-secondary" type="button" href="{$registerUrl}" class="register">
                        {translate key="user.login.registerNewAccount"}
                    </a>
                </div>
            {else}
                <button class="btn btn-secondary" type="submit">
                    {translate key="user.login.resetPassword"}
                </button>
            {/if}

        </form>

	</div><!--container-->
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
