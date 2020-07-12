{**
 * templates/frontend/components/registrationForm.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the basic registration form fields
 *
 * @uses $locale string Locale key to use in the affiliate field
 * @uses $givenName string First name input entry if available
 * @uses $familyName string Last name input entry if available
 * @uses $countries array List of country options
 * @uses $country string The selected country if available
 * @uses $email string Email input entry if available
 * @uses $username string Username input entry if available
 *}

<div class="box_primary">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-9">
				<fieldset class="identity">
					<legend>
						{translate key="user.profile"}
					</legend>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="givenName">{translate key="user.givenName"}</label>
							<input type="text" class="form-control" name="givenName" id="givenName" value="{$givenName|escape}" maxlength="255" required>
							<small class="form-text text-muted">*{translate key="common.required"}</small>
						</div>

						<div class="form-group col-md-6">
							<label for="familyName">{translate key="user.familyName"}</label>
							<input type="text" class="form-control" name="familyName" id="familyName" value="{$familyName|escape}" maxlength="255">
						</div>

						<div class="form-group col-md-6">
							<label for="affiliation">{translate key="user.affiliation"}</label>
							<input type="text" class="form-control" name="affiliation" id="affiliation" value="{$affiliation|escape}" required>
							<small class="form-text text-muted">*{translate key="common.required"}</small>
						</div>
						<div class="form-group col-md-6">
							<label for="country">{translate key="common.country"}</label>
							<select class="form-control" name="country" id="country" required>
								<option></option>
								{html_options options=$countries selected=$country}
							</select>
							<small class="form-text text-muted">*{translate key="common.required"}</small>
						</div>
					</div>
				</fieldset>
			</div>
		</div>
	</div>
</div>

<div class="box_secondary">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-9">
				<fieldset class="login">
					<legend>
						{translate key="user.login"}
					</legend>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="email">{translate key="user.email"}</label>
							<input type="text" class="form-control" name="email" id="email" value="{$email|escape}" maxlength="90" required>
							<small class="form-text text-muted">*{translate key="common.required"}</small>
						</div>

						<div class="form-group col-md-6">
							<label for="username">{translate key="user.username"}</label>
							<input type="text" class="form-control" name="username" id="username" value="{$username|escape}" maxlength="32" required>
							<small class="form-text text-muted">*{translate key="common.required"}</small>
						</div>

						<div class="form-group col-md-6">
							<label for="password">{translate key="user.password"}</label>
							<input type="password" class="form-control" name="password" id="password" password="true" maxlength="32" required>
							<small class="form-text text-muted">*{translate key="common.required"}</small>
						</div>

						<div class="form-group col-md-6">
							<label for="password2">{translate key="user.repeatPassword"}</label>
							<input type="password" class="form-control"  name="password2" id="password2" password="true" maxlength="32" required>
							<small class="form-text text-muted">*{translate key="common.required"}</small>
						</div>
					</div>
				</fieldset>
			</div>
		</div>
	</div>
</div>
