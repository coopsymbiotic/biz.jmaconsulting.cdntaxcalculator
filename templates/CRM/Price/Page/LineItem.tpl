{*
 +--------------------------------------------------------------------+
 | CiviCRM version 5                                                  |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2018                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}

{* Displays contribution/event fees when price set is used. *}
{foreach from=$lineItem item=value key=priceset}
  {if $value neq 'skip'}
    {if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}
      {if $priceset GT 0}
        <br />
      {/if}
      <strong>{ts}Participant {$priceset+1}{/ts}</strong> {$part.$priceset.info}
    {/if}
    <table>
      <tr class="columnheader">
        <th>{ts}Item{/ts}</th>
        {if $displayLineItemFinancialType}
          <th>{ts}Financial Type{/ts}</th>
        {/if}
        <th class="right">{ts}Qty{/ts}</th>
        <th class="right">{ts}Unit Price{/ts}</th>
        {if !$getTaxDetails}
          <th class="right">{ts}Total Price{/ts}</th>
        {/if}

        {if $getTaxDetails}
          <th class="right">{ts}Tax Rate{/ts}</th>
          <th class="right">{ts}Amount{/ts}</th>
        {/if}

        {if $pricesetFieldsCount}
          <th class="right">{ts}Total Participants{/ts}</th>
        {/if}
      </tr>
      {foreach from=$value item=line}
        <tr{if $line.qty EQ 0} class="cancelled"{/if}>
          <td>{if $line.field_title && $line.html_type neq 'Text'}{$line.field_title} &ndash; {$line.label}{else}{$line.label}{/if} {if $line.description}<div class="description">{$line.description}</div>{/if}</td>
          {if $displayLineItemFinancialType}
            <td>{$line.financial_type}</td>
          {/if}
          <td class="right">{$line.qty}</td>
          <td class="right">{$line.unit_price|crmMoney}</td>
    {if !$getTaxDetails && $context NEQ "Membership"}
      <td class="right">{$line.line_total|crmMoney}</td>
    {/if}
    {if $getTaxDetails}
      {if $line.tax_rate != "" || $line.tax_amount != ""}
        <td class="right">{$line.tax_rate}%</td>
      {else}
        <td></td>
      {/if}
      <td class="right">{$line.line_total|crmMoney}</td> {* [ML] avoid calculations *}
    {/if}
          {if $pricesetFieldsCount}
            <td class="right">{$line.participant_count}</td>
          {/if}
        </tr>
      {/foreach}
    </table>
  {/if}
{/foreach}

<div class="crm-section no-label total_amount-section">
  <div class="content bold" style="text-align: right; display: table; float: right;">
    {if $context EQ "Contribution"}
      {if $getTaxDetails && $totalTaxAmount}
        {if $cdnTaxRates.HST_GST}
          {* Example: invoice payment *}
          <div style="display: table-row;">
            <div style="display: table-cell;">{$cdnTaxRates.HST_GST_LABEL}&nbsp;&nbsp;</div>
            <div style="display: table-cell;">{$cdnTaxRates.HST_GST_AMOUNT_TOTAL|crmMoney}</div>
          </div>
        {else}
          <div style="display: table-row;">
            <div style="display: table-cell;">{ts}Total Tax Amount{/ts}:&nbsp;&nbsp;</div>
            <div style="display: table-cell;">{$totalTaxAmount|crmMoney}</div>
          </div>
        {/if}
      {/if}
      <div style="display: table-row;">
        <div style="display: table-cell;">{ts}Contribution Total{/ts}:&nbsp;&nbsp;</div>
        <div style="display: table-cell;">{$totalAmount|crmMoney}</div>
      </div>
    {elseif $context EQ "Event"}
      {if $totalTaxAmount}
        <div style="display: table-row;">
          <div style="display: table-cell;">{ts}Subtotal:{/ts}&nbsp;&nbsp;</div>
          <div style="display: table-cell; padding-left: 1em;">{$totalAmount-$totalTaxAmount|crmMoney}</div>
        </div>
      {/if}
      {if $getTaxDetails && $totalTaxAmount}
        <div style="display: table-row;">
          <div style="display: table-cell;">{ts}Total Tax Amount{/ts}:&nbsp;&nbsp;</div>
          <div style="display: table-cell;">{$totalTaxAmount|crmMoney}</div>
        </div>
      {/if}
      <div style="display: table-row;">
        <div style="display: table-cell;">{ts}Event Total{/ts}:&nbsp;&nbsp;</div>
        <div style="display: table-cell;">{$totalAmount|crmMoney}</div>
      </div>
    {elseif $context EQ "Membership"}
      {if $getTaxDetails && $totalTaxAmount}
        {if $cdnTaxRates.PST}
          <div style="display: table-row;">
            <div style="display: table-cell;">{$cdnTaxRates.PST_LABEL}&nbsp;&nbsp;</div>
            <div style="display: table-cell;">{$cdnTaxRates.PST_AMOUNT_TOTAL|crmMoney}</div>
          </div>
        {/if}
        {if $cdnTaxRates.HST_GST}
          <div style="display: table-row;">
            <div style="display: table-cell;">{$cdnTaxRates.HST_GST_LABEL}&nbsp;&nbsp;</div>
            <div style="display: table-cell;">{$cdnTaxRates.HST_GST_AMOUNT_TOTAL|crmMoney}</div>
          </div>
        {/if}
      {/if}
      <div style="display: table-row;">
        <div style="display: table-cell;">{ts}Total{/ts}&nbsp;&nbsp;</div>
        <div style="display: table-cell;">{$totalAmount|crmMoney}</div>
      </div>
    {else}
      {if $getTaxDetails && $totalTaxAmount}
        <div>{ts}Total Tax Amount{/ts}: {$totalTaxAmount|crmMoney}</div>
      {/if}
      <div>{ts}Total Amount{/ts}: {$totalAmount|crmMoney}
    {/if}
  </div>
  <div class="clear"></div>
  <div class="content bold">
    {if $pricesetFieldsCount}
      {ts}Total Participants{/ts}:
      {foreach from=$lineItem item=pcount}
        {if $pcount neq 'skip'}
        {assign var="lineItemCount" value=0}

        {foreach from=$pcount item=p_count}
          {assign var="lineItemCount" value=$lineItemCount+$p_count.participant_count}
        {/foreach}
        {if $lineItemCount < 1 }
          {assign var="lineItemCount" value=1}
        {/if}
        {assign var="totalcount" value=$totalcount+$lineItemCount}
        {/if}
      {/foreach}
      {$totalcount}
    {/if}
  </div>
  <div class="clear"></div>
</div>

{if $hookDiscount.message}
  <div class="crm-section hookDiscount-section">
    <em>({$hookDiscount.message})</em>
  </div>
{/if}
{literal}
<script type="text/javascript">
CRM.$(function($) {
  {/literal}
    var comma = '{$config->monetaryThousandSeparator}';
    var dot = '{$config->monetaryDecimalPoint}';
    var format = '{$config->moneyformat}';
    var currency = '{$currency}';
    var currencySymbol = '{$currencySymbol}';
  {literal}
  // Todo: This function should be a utility
  function moneyFormat(amount) {
    amount = parseFloat(amount).toFixed(2);
    amount = amount.replace(',', 'comma').replace('.', 'dot');
    amount = amount.replace('comma', comma).replace('dot', dot);
    return format.replace('%C', currency).replace('%c', currencySymbol).replace('%a', amount);
  }});
</script>
{/literal}
