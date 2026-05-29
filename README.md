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