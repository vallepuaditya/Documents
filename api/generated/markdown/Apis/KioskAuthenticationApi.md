# KioskAuthenticationApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**kioskLoginApiV1KioskAuthLoginPost**](KioskAuthenticationApi.md#kioskLoginApiV1KioskAuthLoginPost) | **POST** /api/v1/kiosk/auth/login | Kiosk Login |
| [**kioskLogoutApiV1KioskAuthLogoutPost**](KioskAuthenticationApi.md#kioskLogoutApiV1KioskAuthLogoutPost) | **POST** /api/v1/kiosk/auth/logout | Kiosk Logout |
| [**kioskMeApiV1KioskAuthMeGet**](KioskAuthenticationApi.md#kioskMeApiV1KioskAuthMeGet) | **GET** /api/v1/kiosk/auth/me | Kiosk Me |


<a name="kioskLoginApiV1KioskAuthLoginPost"></a>
# **kioskLoginApiV1KioskAuthLoginPost**
> KioskLoginResponse kioskLoginApiV1KioskAuthLoginPost(KioskLoginRequest)

Kiosk Login

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **KioskLoginRequest** | [**KioskLoginRequest**](../Models/KioskLoginRequest.md)| Send **application/json** with &#x60;logon_id&#x60; and &#x60;password&#x60;. Swagger **Authorize** (OAuth2 password) uses **application/x-www-form-urlencoded** with &#x60;username&#x60; (&#x3D; logon_id) and &#x60;password&#x60;. | |

### Return type

[**KioskLoginResponse**](../Models/KioskLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json, application/x-www-form-urlencoded
- **Accept**: application/json

<a name="kioskLogoutApiV1KioskAuthLogoutPost"></a>
# **kioskLogoutApiV1KioskAuthLogoutPost**
> Map kioskLogoutApiV1KioskAuthLogoutPost()

Kiosk Logout

### Parameters
This endpoint does not need any parameter.

### Return type

[**Map**](../Models/AnyType.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="kioskMeApiV1KioskAuthMeGet"></a>
# **kioskMeApiV1KioskAuthMeGet**
> KioskUserProfile kioskMeApiV1KioskAuthMeGet()

Kiosk Me

### Parameters
This endpoint does not need any parameter.

### Return type

[**KioskUserProfile**](../Models/KioskUserProfile.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

