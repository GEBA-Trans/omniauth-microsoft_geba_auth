# Omniauth::MicrosoftV2Auth

Microsoft V2 OAuth2 Strategy for OmniAuth.
Can be used to authenticate with Microsoft Services and get a token for the Microsoft Graph Api.

You can use the gem directly from the repository, for example:

```ruby
gem 'omniauth-microsoft_geba_auth', git: 'https://github.com/GEBA-Trans/omniauth-microsoft_geba_auth.git'
```

## Usage

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :microsoft_geba_auth, ENV['AZURE_APPLICATION_CLIENT_ID'], ENV['AZURE_APPLICATION_CLIENT_SECRET']
end
```

## Microsoft Graph user info

Since version `0.3.0`, the strategy requests the signed-in user's profile from Microsoft Graph using an explicit `$select`:

```text
https://graph.microsoft.com/v1.0/me?$select=businessPhones,displayName,givenName,jobTitle,mail,mobilePhone,officeLocation,preferredLanguage,surname,onPremisesSamAccountName,userPrincipalName,id
```

This includes `onPremisesSamAccountName`, so applications can use the on-premises SAM account name/login name. It is exposed as:

```ruby
auth_hash.extra.raw_info['userPrincipalName']
```

The original Microsoft Entra ID/Azure `userPrincipalName` value is preserved as:

```ruby
auth_hash.extra.raw_info['azureUserPrincipalName']
```

For example, if Microsoft Graph returns:

```json
{
  "onPremisesSamAccountName": "krei",
  "userPrincipalName": "K.Reiter@gebatrans.com"
}
```

then `raw_info['userPrincipalName']` will return `"krei"`, and `raw_info['azureUserPrincipalName']` will return `"K.Reiter@gebatrans.com"`.

<!-- GEBA hand-off runbook -->

## GEBA operational hand-off

### Wat zijn de veelvoorkomende fouten en storingen, en hoe worden die normaal opgelost?

Check Microsoft OAuth configuration, callback URL, scope, tenant/issuer and the availability of Microsoft identity services. Validate the OmniAuth callback payload without logging sensitive claims.


<!-- GEBA git history bugfix review -->


#### Git history: bugfixes and incident-related changes
The following commits were identified from the available Git history by bugfix, incident, failure, retry, timeout, regression, or recovery-related wording. Use the commit hash to inspect the exact implementation and deployment context; the commit subject is a concise historical indication, not a complete root-cause report.
- `e7f536f` (2023-03-31) — refactor filter to Fixes GEBA-Trans/omniauth-microsoft_geba_auth#2

### Hoe en waar is de logging terug te vinden?

Rails application logs and Microsoft Entra sign-in/audit logs; redact tokens and personal claims.

### Hoe herstart of herstel je de applicatie?

This is an authentication library, not normally a standalone service. Restart the consuming Rails application after gem/config changes and test login/logout/callback in staging.

### Hoe worden updates doorgevoerd, en wat is er verder aan onderhoud nodig?

Update the gem through the consuming application’s dependency process. Maintain supported OAuth API behavior, callback URLs, certificates/secrets and security patches.
