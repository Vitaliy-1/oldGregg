{**
 * templates/frontend/layouts/informational.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief template for informational pages
 *}

{extends "frontend/layouts/general.tpl"}

{block name="pageContent"}
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col-md-9">
				{block name="informationalContent"}{/block}
			</div>
		</div>
	</div>
{/block}
