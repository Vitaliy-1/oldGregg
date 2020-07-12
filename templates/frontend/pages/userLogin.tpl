{extends "frontend/layouts/general.tpl"}

{assign var=pageTitle value="user.login"}

{block name="pageContent"}
	<div class="box_primary">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-9">
					<h1>
						{translate key="user.login"}
					</h1>
					{* A login message may be displayed if the user was redireceted to the
					   login page from another request. Examples include if login is required
					   before dowloading a file. *}
					{if $loginMessage}
						<p>
							{translate key=$loginMessage}
						</p>
					{/if}
				</div>
			</div>
		</div>
	</div>

	<div class="box_secondary">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-9">
					<form class="cmp_form cmp_form login" id="login" method="post" action="{$loginUrl}">
						{csrf}

						{if $error}
							<div class="alert alert-danger" role="alert">
								{translate key=$error reason=$reason}
							</div>
						{/if}

						<input type="hidden" name="source" value="{$source|escape}"/>

						<div class="form-group">
							<label for="username">{translate key="user.username"}</label>
							<input type="text" class="form-control" name="username" id="username" aria-describedby="emailHelp"
							       value="{$username|escape}" maxlength="32" required>
						</div>

						<div class="form-group">
							<label for="password">{translate key="user.password"}</label>
							<input type="password" class="form-control" name="password" id="password" value="{$password|escape}"
							       password="true" maxlength="32" required">
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

						<div class="buttons">
							<button type="submit" class="btn btn-primary">{translate key="user.login"}</button>

							{if !$disableUserReg}
								{capture assign="registerUrl"}{url page="user" op="register" source=$source}{/capture}
								<a href="{$registerUrl}" class="btn btn-secondary">
									{translate key="user.login.registerNewAccount"}
								</a>
							{/if}
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
{/block}
