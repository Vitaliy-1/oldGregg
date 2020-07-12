{**
 * templates/frontend/pages/privacy.tpl
 *
 * Copyright (c) 2017-2020 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief Template for privacy statement.
 *
 *}
{extends "frontend/layouts/informational.tpl"}

{assign var="pageTitle" value="manager.setup.privacyStatement"}

{block name="informationalContent"}
	<h1>{translate key="manager.setup.privacyStatement"}</h1>
	{$privacyStatement}
{/block}
