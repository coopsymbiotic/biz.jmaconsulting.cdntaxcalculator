<?php

use CRM_Cdntaxcalculator_ExtensionUtil as E;

$is_multilingual = CRM_Core_I18n::isMultilingual();
$locales = [];

// TODO: We should add a core function for this!
$domain = new CRM_Core_DAO_Domain();
$domain->find(TRUE);

if ($domain->locales) {
  $locales = explode(CRM_Core_DAO::VALUE_SEPARATOR, $domain->locales);
}
else {
  $locales[] = CRM_Core_I18n::getLocale();
}

$settings = [
  'cdntaxcalculator_address_type' => [
    'group_name' => 'domain',
    'group' => 'cdntaxcalculator',
    'name' => 'cdntaxcalculator_address_type',
    'type' => 'Integer',
    'default' => 1,
    'add' => '1.0',
    'is_domain' => 1,
    'is_contact' => 0,
    'title' => E::ts('Address Type'),
    'description' => E::ts("Address type to be used for calculating taxes on memberhips or other type of non-event contributions. By default, the billing address is recommended since it is always included in the contribution form billing block."),
    'quick_form_type' => 'Select',
    'html_type' => 'Select',
    'select_options' => [
      1 => E::ts('Billing Address'),
      2 => E::ts('Primary Address'),
    ],
  ],
];

foreach ($locales as $locale) {
  $settings['cdntaxcalculator_text_select_location_' . $locale] = [
    'group_name' => 'domain',
    'group' => 'cdntaxcalculator',
    'name' => 'cdntaxcalculator_text_select_location_' . $locale,
    'type' => 'String',
    'default' => E::ts('Please select your billing location:'),
    'add' => '1.0',
    'is_domain' => 1,
    'is_contact' => 0,
    'title' => E::ts('Select location description') . ($is_multilingual ? ' - ' . $locale : ''),
    'description' => E::ts("Text shown to users in the popup to select their tax location"),
    'quick_form_type' => 'Element',
    'html_type' => 'Text',
    'html_attributes' => [
      'size' => 64,
    ],
  ];
  $settings['cdntaxcalculator_text_current_location_' . $locale] = [
    'group_name' => 'domain',
    'group' => 'cdntaxcalculator',
    'name' => 'cdntaxcalculator_text_current_location_' . $locale,
    'type' => 'String',
    'default' => E::ts('Taxes are calculated based on your billing address (%1)'),
    'add' => '1.0',
    'is_domain' => 1,
    'is_contact' => 0,
    'title' => E::ts('Location description') . ($is_multilingual ? ' - ' . $locale : ''),
    'description' => E::ts("Text shown to users to describe that taxes are based on their address. The %%1 is the province/country."),
    'quick_form_type' => 'Element',
    'html_type' => 'Text',
    'html_attributes' => [
      'size' => 64,
    ],
  ];
  $settings['cdntaxcalculator_text_change_location_' . $locale] = [
    'group_name' => 'domain',
    'group' => 'cdntaxcalculator',
    'name' => 'cdntaxcalculator_text_current_location_' . $locale,
    'type' => 'String',
    'default' => E::ts('Click here to select another region.'),
    'add' => '1.0',
    'is_domain' => 1,
    'is_contact' => 0,
    'title' => E::ts('Change location text') . ($is_multilingual ? ' - ' . $locale : ''),
    'description' => E::ts("Text in the link shown to users so that they can change their tax location."),
    'quick_form_type' => 'Element',
    'html_type' => 'Text',
    'html_attributes' => [
      'size' => 64,
    ],
  ];
  $settings['cdntaxcalculator_text_help_' . $locale] = [
    'group_name' => 'domain',
    'group' => 'cdntaxcalculator',
    'name' => 'cdntaxcalculator_text_help_' . $locale,
    'type' => 'String',
    'default' => '',
    'add' => '1.0',
    'is_domain' => 1,
    'is_contact' => 0,
    'title' => E::ts('Tax help text') . ($is_multilingual ? ' - ' . $locale : ''),
    'description' => E::ts("You can add extra help text here."),
    'quick_form_type' => 'Element',
    'html_type' => 'Text',
    'html_attributes' => [
      'size' => 64,
    ],
  ];
}

return $settings;
