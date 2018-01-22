{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko, MD
 *}
</div> {* end of the site-content wraper *}

<div class="site-footer">
    <div class="container">
        <div class="row">
            <div class="col footer-left">
                <a href="{url router=$smarty.const.ROUTE_PAGE page="about" op="contact"}">
                {translate key="about.contact"}
                </a>
                <a href="{url router=$smarty.const.ROUTE_PAGE page="information" op="readers"}">
                    {translate key="navigation.infoForReaders"}
                </a>
                <a href="{url router=$smarty.const.ROUTE_PAGE page="information" op="authors"}">
                    {translate key="navigation.infoForAuthors"}
                </a>
            </div>
            <div class="col footer-right">
                <a href="{url router=$smarty.const.ROUTE_PAGE page="information" op="librarians"}">
                    {translate key="navigation.infoForLibrarians"}
                </a>
                <a href="{$pkpLink}">
                    Powered by PKP
                </a>
                <a href="https://github.com/Vitaliy-1/oldGregg">
                    oldGregg Theme
                </a>
            </div>
        </div>
    </div>
</div><!-- pkp_structure_footer_wrapper -->
{load_script context="frontend" scripts=$scripts}
{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
