{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div class="page page_login">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}

    <div class="login-page container">
        {if $loginMessage}
            <p>
                {translate key=$loginMessage}
            </p>
        {/if}

        <form class="cmp_form cmp_form login" id="login" method="post" action="{$loginUrl}">
            {csrf}
            <input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}"/>
            <div class="form-group">
                <label for="username">{translate key="user.username"}</label>
                <input type="text" class="form-control" name="username" id="username" aria-describedby="emailHelp"
                       value="{$username|escape}" maxlength="32" required>
            </div>
            <div class="form-group">
                <label for="password">{translate key="user.password"}</label>
                <input type="password" class="form-control" name="password" id="password" value="{$password|escape}"
                       password="true" maxlength="32" required="$passwordRequired">
                <a href="{url page="login" op="lostPassword"}" class="form-text">
                    {translate key="user.login.forgotPassword"}
                </a>
            </div>
            <div class="form-check">
                <label class="form-check-label">
                    <input type="checkbox" class="form-check-input" name="remember" id="remember" value="1"
                           checked="$remember">
                    {translate key="user.login.rememberUsernameAndPassword"}
                </label>
            </div>
            <button type="submit" class="btn btn-secondary">{translate key="user.login"}</button>
            {if !$disableUserReg}
                {url|assign:registerUrl page="user" op="register" source=$source}
                <a href="{$registerUrl}" class="btn btn-secondary">
                    {translate key="user.login.registerNewAccount"}
                </a>
            {/if}
        </form>
    </div> <!-- container -->
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
