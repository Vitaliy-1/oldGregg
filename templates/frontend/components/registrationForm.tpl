{**
 * templates/frontend/components/registrationForm.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *

 *}

<div class="registration-info-title alert alert-dark" role="alert">
    {translate key="user.profile"}
</div>
<div class="form-row">
    <div class="form-group col-md-4">
        <label for="firstName">{translate key="user.firstName"}</label>
        <input type="text" class="form-control" name="firstName" id="firstName" value="{$firstName|escape}" maxlength="40" required>
        <small class="form-text text-muted">*{translate key="common.required"}</small>
    </div>

    <div class="form-group col-md-4">
        <label for="middleName">{translate key="user.middleName"}</label>
        <input type="text" class="form-control" name="middleName" id="middleName" value="{$middleName|escape}" maxlength="40">
    </div>

    <div class="form-group col-md-4">
        <label for="lastName">{translate key="user.lastName"}</label>
        <input type="text" class="form-control" name="lastName" id="lastName" value="{$lastName|escape}" maxlength="40" required>
        <small class="form-text text-muted">*{translate key="common.required"}</small>
    </div>

    <div class="form-group col-md-6">
        <label for="affiliation">{translate key="user.affiliation"}</label>
        <input type="text" class="form-control" name="affiliation[{$primaryLocale|escape}]" id="affiliation" value="{$affiliation.$primaryLocale|escape}" required>
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

<div class="registration-info-title alert alert-dark" role="alert">
    {translate key="user.login"}
</div>
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


