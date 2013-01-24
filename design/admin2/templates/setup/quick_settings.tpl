{def $settings_list=ezini( 'DebugSettings', 'QuickSettingsList', 'site.ini' )
     $setting=array()
     $debug_output=true()
     $debug_output_override=true()
}

<form id="quicksettings" action={'debug/settingstoolbar'|ezurl} method="post">

{set $ui_context=''}

<div class="block">
<input type="hidden" name="SiteAccess" value="{$siteaccess|wash}" />

{section show=eq( $siteaccess, 'global_override' )}
   {section loop=$settings_list}
     <input type="hidden" name="AllSettingsList[]" value="{$:item|wash}"/>
     {set $setting=$:item|explode( ';' )}
     {set $debug_output=ezini( $setting.0, $setting.1, $setting.2, 'extension/debug/settings', true )}
      <label>
      <input type="checkbox" {or( eq( $debug_output, 'enabled' ), eq( $debug_output, 'true' ) )|choose( '', 'checked="checked" ' )}name="SelectedList[]" value="{$:index}" />
         {if eq( $debug_output, '' )}
            <span class="disabled">{$setting.3|wash}</span>
         {else}
            {$setting.3|wash}
         {/if}
     </label>
   {/section}
{section-else}
   {section loop=$settings_list}
      <input type="hidden" name="AllSettingsList[]" value="{$:item|wash}" />
      {set $setting=$:item|explode( ';' )}
      {set $debug_output=ezini( $setting.0, $setting.1, $setting.2, concat( 'extension/debug/settings/siteaccess/', $siteaccess ), true )
           debug_output_override=ezini( $setting.0, $setting.1, $setting.2, 'extension/debug/settings', true )}
         <label>
      {if ne( $debug_output_override, '' )}
         <input type="checkbox"{eq( $ui_context, 'edit' )|choose( '', ' disabled="disabled"' )} {or( eq( $debug_output_override, 'enabled' ), eq( $debug_output_override, 'true' ) )|choose( '', 'checked="checked" ' )}name="SelectedList[]" value="{$:index}" />
         <span class="overriden">{$setting.3|wash}</span>
      {else}
         {if eq( $debug_output, '' )}
            <input type="checkbox"{eq( $ui_context, 'edit' )|choose( '', ' disabled="disabled"' )} {or( eq( ezini( $setting.0, $setting.1, $setting.2 ), 'enabled' ), eq( ezini( $setting.0, $setting.1, $setting.2 ), 'true' ) )|choose( '', 'checked="checked" ' )}name="SelectedList[]" value="{$:index}" />
         {else}
            <input type="checkbox"{eq( $ui_context, 'edit' )|choose( '', ' disabled="disabled"' )} {or( eq( $debug_output, 'enabled' ), eq( $debug_output, 'true' ) )|choose( '', 'checked="checked" ' )}name="SelectedList[]" value="{$:index}" />
         {/if}
            {$setting.3|wash}
      {/if}
         </label>
   {/section}
{/section}
</div>
{section show=eq( $select_siteaccess, true )}
    {def $siteaccesslist=ezini( 'SiteAccessSettings', 'RelatedSiteAccessList' )}
    {set $siteaccesslist=$siteaccesslist|prepend( "debug" )}
    <div class="block">
    <label>Siteaccess:</label>
    <select name="siteaccesslist"{eq( $ui_context, 'edit' )|choose( '', ' disabled="disabled"' )} onchange='location.href=this.value'>
            <option value={'/user/preferences/set/admin_quicksettings_siteaccess/global_override'|ezurl}{if eq( $siteaccess, 'global_override')} selected="selected"{/if}>Global (override)</option>
    {section loop=$siteaccesslist}
            <option value={concat( '/user/preferences/set/admin_quicksettings_siteaccess/', $:item )|ezurl}{if eq( $siteaccess, $:item )} selected="selected"{/if}>{$:item|shorten(20, '...', 'middle')|wash}</option>
    {/section}
    </select>
    </div>
{/section}
<div class="block">
<input {eq( $ui_context, 'edit' )|choose( "class='button'", "class='button-disabled'" )}{eq( $ui_context, 'edit' )|choose( '', ' disabled="disabled"' )} type="submit" name="SetButton" value="Set" />
</div>

</form>
