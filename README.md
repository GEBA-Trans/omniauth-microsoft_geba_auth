# Omniauth::MicrosoftV2Auth

Microsoft V2 OAuth2 Strategy for OmniAuth.
Can be used to authenticate with Microsoft Services and get a token for the Microsoft Graph Api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-microsoft_geba_auth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-microsoft_geba_auth

## Usage

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :microsoft_geba_auth, ENV['AZURE_APPLICATION_CLIENT_ID'], ENV['AZURE_APPLICATION_CLIENT_SECRET']
end
```

## Microsoft Graph user info

The strategy requests the signed-in user's profile from Microsoft Graph using an explicit `$select`:

```text
https://graph.microsoft.com/v1.0/me?$select=businessPhones,displayName,givenName,jobTitle,mail,mobilePhone,officeLocation,preferredLanguage,surname,onPremisesSamAccountName,userPrincipalName,id
```

This includes `onPremisesSamAccountName`, which is exposed as:

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